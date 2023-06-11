/// abstract class for all Auth events
abstract class AuthEvent {
  AuthEvent();
}

/// SignUp Event which carries email, password and name
class SignupWithEmailPass extends AuthEvent {
  final String email;
  final String password;
  final String name;
  SignupWithEmailPass({
    required this.email,
    required this.password,
    required this.name,
  });
}

/// Login with google event
class LoginWithGoogle extends AuthEvent {
  LoginWithGoogle();
}

/// Login with email and pass event
class LoginWithEmailPass extends AuthEvent {
  final String email;
  final String password;
  LoginWithEmailPass({
    required this.email,
    required this.password,
  });
}

/// checks if user is logged in event
class IsUserLoggedIn extends AuthEvent {
  IsUserLoggedIn();
}

/// logout event
class LogoutEvent extends AuthEvent {
  LogoutEvent();
}
