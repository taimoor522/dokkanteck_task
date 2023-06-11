import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';
import 'di.dart';
import 'src/core/constants/strings.dart';
import 'src/core/theme/themes.dart';
import 'src/presentaion/auth/bloc/auth_bloc.dart';
import 'src/presentaion/home/bloc/app_user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// dependency injection
  /// & firebase app init
  await appConfigurations();

  runApp(const Bootstrap());
}

class Bootstrap extends StatelessWidget {
  const Bootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    /// inject blocs in widget tree through [MultiBlocProvider]

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AppUserBloc()),
        BlocProvider(create: (_) => AuthBloc()),
      ],

      /// [ScreenUtilInit] for responsive design
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        useInheritedMediaQuery: true,
        splitScreenMode: false,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: AppThemes.light,
            home: const App(),
          );
        },
      ),
    );
  }
}
