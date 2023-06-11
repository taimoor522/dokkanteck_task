import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../di.dart';
import '../../core/constants/strings.dart';
import '../../core/exceptions/auth_exception.dart';
import '../../core/extensions/string_extensions.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/app_user_model.dart';

/// Handles all the auth releated bussiness login
/// Implements the [AuthRepository]
class AuthRespositoryImpl implements AuthRepository {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;
  final GoogleSignIn _googleSigninInstance = GoogleSignIn();
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  /// [UserRepository] instance to create new user
  final UserRepository _userRepository = getInstance();

  /// login user using email and pass
  /// throw [AuthException] with a friendly message
  /// to inform call about the failure
  @override
  Future<AppUser> loginWithEmailPass(Email email, String password) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final snapshot =
          await _firestoreInstance.collection(AppStrings.userCollections).doc(email).get();

      return AppUserModel.fromMap(snapshot.data()!).toDomain();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code.errorToPresentableString);
    }
  }

  /// login user using email and pass
  /// throw [AuthException] with a friendly message
  /// to inform call about the failure
  /// creates new user in DB if does not exist
  @override
  Future<AppUser?> loginWithGoogle() async {
    try {
      final googleAccountAuth = await _googleSigninInstance.signIn();
      final googleAuth = await googleAccountAuth?.authentication;
      if (googleAuth == null) return null;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _authInstance.signInWithCredential(credential);
      final user = await _userRepository.loadUser(googleAccountAuth!.email);

      if (user != null) {
        return user;
      } else {
        final user = AppUserModel(
          email: googleAccountAuth.email,
          name: googleAccountAuth.displayName ?? 'No Name',
          image: googleAccountAuth.photoUrl,
        ).toDomain();

        await _userRepository.createNewUser(user);
        return user;
      }
    } on FirebaseAuthException catch (e) {
      logout();
      throw AuthException(e.code.errorToPresentableString);
    } catch (e) {
      logout();
      throw AuthException(e.toString());
    }
  }

  /// logout user from firebase
  /// and from google
  @override
  Future<bool> logout() async {
    try {
      await _authInstance.signOut();
      _googleSigninInstance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// creates a new user with email and password
  /// also create a new user in DB
  @override
  Future<void> signupWithEmailPass(String email, String password, String name) async {
    try {
      await _authInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = AppUserModel(
        email: email,
        name: name,
      ).toDomain();
      await _userRepository.createNewUser(user);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code.errorToPresentableString);
    }
  }

  /// checks if user is already loggedIn
  /// return [AppUser] if user is looggedIn
  /// else return null
  @override
  Future<Email?> isUserLoggedIn() async =>
      _authInstance.currentUser != null ? _authInstance.currentUser!.email! : null;
}
