import 'package:bloc/bloc.dart';

import '../../../../di.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/user_repository.dart';
import 'app_user_state.dart';

export 'app_user_state.dart';

part 'app_user_event.dart';

/// This bloc teep track of current user
/// handle user related events
class AppUserBloc extends Bloc<AppUserEvent, AppUserState> {
  ///
  /// [UserRepository] instance get through dependency injection
  final _userRepository = getInstance<UserRepository>();

  /// bloc constructor listen to different events passed to it
  AppUserBloc() : super(AppUserEmptyState()) {
    on<LoadAppUserEvent>(_loadUser);
    on<AppUserLogoutEvent>((_, emit) => emit(AppUserEmptyState()));
  }

  /// load user data from [FirebaseFirestore]
  void _loadUser(LoadAppUserEvent event, Emitter emit) async {
    try {
      emit(AppUserLoadingState());
      final user = await _userRepository.loadUser(event.id);

      if (user == null) throw Exception('User not Found in DB');

      emit(AppUserLoadedState(user));
    } catch (e) {
      emit(AppUserEmptyState());
    }
  }
}
