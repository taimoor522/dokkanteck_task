import '../../../domain/repositories/auth_repository.dart';

/// abstract class for all auth states
abstract class AuthState {
  const AuthState();
}

/// initial state of auth
class AuthInitialState extends AuthState {}

/// loading state of auth
class AuthLoadingState extends AuthState {}

/// signup success state
class SignupSuccessState extends AuthState {
  SignupSuccessState();
}

/// login success state
class LoginSuccessState extends AuthState {
  final Email id;

  LoginSuccessState(this.id);
}

/// failure state of auth
class AuthFailureState extends AuthState {
  final String error;

  const AuthFailureState(this.error);
}
