import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'src/data/repositories/auth_repository_impl.dart';
import 'src/data/repositories/user_repository_impl.dart';
import 'src/domain/repositories/auth_repository.dart';
import 'src/domain/repositories/user_repository.dart';

/// global [GetIt] instance to get dependencies
final getInstance = GetIt.instance;

Future<void> appConfigurations() async {
  /// Firebase initialization
  await Firebase.initializeApp();

  /// injecting repositories
  getInstance.registerFactory<AuthRepository>(() => AuthRespositoryImpl());
  getInstance.registerFactory<UserRepository>(() => UserRespositoryImpl());
}
