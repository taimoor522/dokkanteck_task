import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/extensions/widget_extensions.dart';
import '../../../core/widgets/spacing.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../bloc/app_user_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<AppUserBloc, AppUserState>(
          builder: (context, state) {
            final user = (state as AppUserLoadedState).user;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///
                if (user.image != null)
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.image!),
                    radius: 70.r,
                  ),

                ///
                const VerticalSpacing(20),

                ///
                Text(
                  user.name,
                  style: context.textTheme.titleSmall,
                ),

                ///
                const VerticalSpacing(20),

                ///
                Text(
                  user.email!,
                  style: context.textTheme.bodyLarge,
                ),

                ///
                const VerticalSpacing(20),

                /// log the user out of the app
                ElevatedButton(
                  onPressed: () => context.read<AuthBloc>().add(LogoutEvent()),
                  child: const Text('Logout'),
                ),
              ],
            ).padHorizontal(20);
          },
        ),
      ),
    );
  }
}
