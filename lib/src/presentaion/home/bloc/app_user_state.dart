import '../../../domain/entities/app_user.dart';

/// base abtract class for all user states
abstract class AppUserState {}

/// When the user's data is loading
class AppUserLoadingState extends AppUserState {}

/// When the user's data is not loaded
class AppUserEmptyState extends AppUserState {}

/// When the user's data is loaded
class AppUserLoadedState extends AppUserState {
  final AppUser user;

  AppUserLoadedState(this.user);
}
