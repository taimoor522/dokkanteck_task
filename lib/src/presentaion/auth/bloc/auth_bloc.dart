import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di.dart';
import '../../../core/exceptions/auth_exception.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/user_repository.dart';
import 'auth_bloc.dart';
import 'auth_event.dart';

export 'auth_state.dart';

/// [AuthBloc] to keep all the authentication
/// related login
/// performs login and signup
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<SignupWithEmailPass>(_signupWithEmailPass);
    on<LoginWithGoogle>(_loginWithGoogle);
    on<LoginWithEmailPass>(_loginWithEmailPass);
    on<IsUserLoggedIn>(_isUserLoggedIn);
    on<LogoutEvent>(_logout);
  }

  /// [AuthRepository] and [UserRepository]
  /// instances to perform authentication
  /// and writing new users data to database
  final _authRepository = getInstance<AuthRepository>();

  /// creates a new user with email & pass
  ///
  void _signupWithEmailPass(SignupWithEmailPass event, Emitter emit) async {
    emit(AuthLoadingState());
    try {
      await _authRepository.signupWithEmailPass(event.email, event.password, event.name);
      emit(SignupSuccessState());
    } on AuthException catch (e) {
      emit(AuthFailureState(e.message));
    } catch (e) {
      emit(const AuthFailureState('Something Went Wrong'));
    } finally {
      emit(AuthInitialState());
    }
  }

  /// login the user using google
  void _loginWithGoogle(_, Emitter emit) async {
    emit(AuthLoadingState());
    try {
      final appUser = await _authRepository.loginWithGoogle();

      /// in case of user canceled the auth process
      if (appUser == null) return;

      emit(LoginSuccessState(appUser.email!));
    } on AuthException catch (e) {
      emit(AuthFailureState(e.message));
    } catch (e) {
      emit(const AuthFailureState('Something Went Wrong'));
    } finally {
      emit(AuthInitialState());
    }
  }

  /// checks if user is logged in
  void _isUserLoggedIn(_, Emitter emit) async {
    final email = await _authRepository.isUserLoggedIn();
    if (email != null) {
      emit(LoginSuccessState(email));
    } else {
      emit(AuthInitialState());
    }
  }

  /// login the user using email and pass
  /// emit [LoginSuccessState] on login
  /// emit [AuthFailureState] with friendly message
  void _loginWithEmailPass(LoginWithEmailPass event, Emitter emit) async {
    try {
      emit(AuthLoadingState());

      final appUser = await _authRepository.loginWithEmailPass(
        event.email,
        event.password,
      );
      emit(LoginSuccessState(appUser.email!));
    } on AuthException catch (e) {
      emit(AuthFailureState(e.message));
    } catch (e) {
      emit(const AuthFailureState('Something Went Wrong'));
    }
  }

  void _logout(_, Emitter emit) async {
    try {
      emit(AuthLoadingState());
      await _authRepository.logout();
      emit(AuthInitialState());
    } catch (_) {}
  }
}
