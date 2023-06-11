import '../entities/app_user.dart';

typedef Email = String;

/// Auth Repository abstract class for [Dependency Inversion]
abstract class AuthRepository {
  /// login with email & pass
  Future<AppUser> loginWithEmailPass(Email email, String password);

  /// login with google
  Future<AppUser?> loginWithGoogle();

  /// signup with email & pass
  Future<void> signupWithEmailPass(String email, String password, String name);

  /// logout
  Future<bool> logout();

  /// check if user is logged in
  Future<Email?> isUserLoggedIn();
}
