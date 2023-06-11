import '../entities/app_user.dart';


/// User Repository abstract class for [Dependency Inversion]
abstract class UserRepository {

  /// create new user in DB
  Future createNewUser(AppUser user);
  
  /// load user from DB
  Future<AppUser?> loadUser(String userId);
}
