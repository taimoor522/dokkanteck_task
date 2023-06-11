import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/enum/snackbar_content_type.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/extensions/widget_extensions.dart';
import '../../../core/overlays/snackbar.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Email Controller
  late final TextEditingController emailController;

  /// Password Controller
  late final TextEditingController passwordController;

  /// Form Key for validations
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,

          /// automatically vlidates as user interacts wth the form
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              /// logo
              Image(
                image: const AssetImage(Assets.assetsDokkanTechLogo),
                height: 150.h,
              ),

              /// login text
              Text(
                'Login to Your Account',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ).padVertical(20.h),

              /// email text field
              MyTextFiled(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: Validators.compose([
                  Validators.required('Email is required'),
                  Validators.email('Invalid email address'),
                ]),
              ),

              /// password text field
              MyTextFiled(
                controller: passwordController,
                hintText: 'Password',
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: Validators.compose([
                  Validators.required('Password is required'),
                  Validators.minLength(6, 'Minimum password length is 6 characters'),
                ]),
              ),

              /// login button
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailureState) {
                    AppSnackbar.show(
                      context,
                      message: state.error,
                      snackbarContentType: SnackbarContentType.failure,
                    );
                  } else if (state is LoginSuccessState) {
                    AppSnackbar.show(
                      context,
                      message: 'Logged in',
                      snackbarContentType: SnackbarContentType.success,
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AuthLoadingState
                        ? () {}
                        : () {
                            if (formKey.currentState!.validate()) {
                              /// unfocus the keyboard
                              context.unfocus;

                              /// add login event to the [AuthBloc]
                              context.read<AuthBloc>().add(
                                    LoginWithEmailPass(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            }
                          },
                    child:
                        state is AuthLoadingState ? const LoadingIndicator() : const Text('Login'),
                  );
                },
              ).padOnly(top: 40.h),

              /// forgot password button
              TextButton(
                onPressed: () {},
                child: const Text('Forgot the password?'),
              ).padVertical(10.h),

              /// divider
              Row(
                children: [
                  const Divider().expand(),
                  Text(
                    'or continue with',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.grey,
                    ),
                  ).expand(2),
                  const Divider().expand(),
                ],
              ),

              /// google login button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return OutlinedButton(
                        onPressed: state is AuthLoadingState
                            ? () {}
                            : () {
                                context.read<AuthBloc>().add(LoginWithGoogle());
                              },
                        child: SvgPicture.asset(
                          Assets.assetsGoogle,
                          height: 50.h,
                          color: context.colorScheme.secondary,
                        ),
                      );
                    },
                  ),
                ],
              ).padVertical(20.h),

              /// signup text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: context.textTheme.bodySmall,
                  ),
                  Text(
                    ' Sign Up',
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ).onTap(
                    () => context.push(const SignUpScreen()),
                  ),
                ],
              )
            ],
          ).center.padAll(20.w),
        ),
      ),
    ).onTap(() => context.unfocus());
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
