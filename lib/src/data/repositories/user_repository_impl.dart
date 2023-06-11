import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/strings.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/app_user_model.dart';

/// Handles all the user releated bussiness login
/// Implemets the [UserRepository]
class UserRespositoryImpl implements UserRepository {
  /// [FirebaseFirestore] instance to perform CRUD operations
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  /// create new user in DB
  @override
  Future createNewUser(AppUser user) async {
    _firestoreInstance.collection(AppStrings.userCollections).doc(user.email).set(
          AppUserModel.fromDomain(user).toMap(),
        );
  }

  /// load user from DB
  /// accepst user document ID
  @override
  Future<AppUser?> loadUser(String userId) async {
    final userDoc =
        await _firestoreInstance.collection(AppStrings.userCollections).doc(userId).get();
    if (userDoc.exists) {
      return AppUserModel.fromMap(userDoc.data()!).toDomain();
    } else {
      return null;
    }
  }
}
