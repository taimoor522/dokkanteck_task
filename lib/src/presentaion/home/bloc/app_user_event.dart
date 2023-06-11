part of 'app_user_bloc.dart';

/// base abstract class for all user events
abstract class AppUserEvent {
  AppUserEvent();
}

/// when the user is not signedIn
class AppUserLogoutEvent extends AppUserEvent {
  AppUserLogoutEvent();
}

/// when the user is signedIn
class LoadAppUserEvent extends AppUserEvent {
  final Email id;
  LoadAppUserEvent(this.id);
}
