import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/presentaion/auth/bloc/auth_bloc.dart';
import 'src/presentaion/auth/bloc/auth_event.dart';
import 'src/presentaion/auth/screen/login_screen.dart';
import 'src/presentaion/home/bloc/app_user_bloc.dart';
import 'src/presentaion/home/screen/home_scree.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    /// wrap inside postframe callback
    /// to avoid multiple setstate exceptions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(IsUserLoggedIn());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      /// listen to auth changes
      /// and update current user status

      listener: (context, state) {
        if (state is LoginSuccessState) {
          context.read<AppUserBloc>().add(LoadAppUserEvent(state.id));
        } else if (state is AuthInitialState) {
          context.read<AppUserBloc>().add(AppUserLogoutEvent());
        }
      },

      /// build when user user state changes in response to auth states
      /// return home screen if user if loggedIn
      /// else return login sreen

      child: BlocBuilder<AppUserBloc, AppUserState>(
        builder: (_, state) {
          return state is AppUserLoadedState ? const HomeScreen() : const LoginScreen();
        },
      ),
    );
  }
}
