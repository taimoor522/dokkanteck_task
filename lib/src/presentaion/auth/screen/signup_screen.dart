import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../core/constants/assets.dart';
import '../../../core/enum/snackbar_content_type.dart';
import '../../../core/extensions/build_context_extensions.dart';
import '../../../core/extensions/widget_extensions.dart';
import '../../../core/overlays/dialog.dart';
import '../../../core/overlays/snackbar.dart';
import '../../../core/widgets/loading_indicator.dart';
import '../../../core/widgets/text_field.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

typedef UserEditData = (String name, String phone, String dateOfBith, String gender, String? image);

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// name controller
  late final TextEditingController nameController;

  /// email controller
  late final TextEditingController emailController;

  /// password controller
  late final TextEditingController passwordController;

  /// confirm password controller
  late final TextEditingController confirmPasswordController;

  /// form key for validations
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Form(
        key: formKey,

        /// automatically validates as user interacts wth the form
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// logo
              Image.asset(Assets.assetsDokkanTechLogo, height: 150.h),

              /// create your account text
              Text(
                'Create Your Account',
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ).padVertical(20.h),

              /// name text field
              MyTextFiled(
                controller: nameController,
                hintText: 'Name',
                prefixIcon: Icon(
                  Icons.person_rounded,
                  color: context.colorScheme.secondary,
                ),
                keyboardType: TextInputType.name,
                validator: Validators.compose([
                  Validators.required('Name is required'),
                  Validators.minLength(3, 'Name must contain at least 3 characters'),
                ]),
              ),

              /// email text field
              MyTextFiled(
                controller: emailController,
                hintText: 'Email',
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: context.colorScheme.secondary,
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
                  color: context.colorScheme.secondary,
                ),
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: Validators.compose([
                  Validators.required('Password is required'),
                  Validators.minLength(6, 'Minimum password length is 6 characters'),
                ]),
              ),

              /// confirm password text field
              MyTextFiled(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: context.colorScheme.secondary,
                ),
                isPassword: true,
                keyboardType: TextInputType.visiblePassword,
                validator: Validators.compose([
                  Validators.required('Passwords must be same'),
                  Validators.minLength(6, 'Passwords must be same'),
                  (confirmPassword) =>
                      confirmPassword != passwordController.text ? 'Passwords must be same' : null,
                ]),
              ),

              /// signup button
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) async {
                  if (state is AuthFailureState) {
                    AppSnackbar.show(
                      context,
                      message: state.error,
                      snackbarContentType: SnackbarContentType.failure,
                    );
                  } else if (state is SignupSuccessState) {
                    /// show success dialog
                    AppDialog.show(
                      context,
                      icon: Icons.person_rounded,
                      title: 'Congrtulations!',
                      discription: 'Account Created',
                      action: LoadingIndicator(
                        color: context.colorScheme.secondary,
                      ),
                    );

                    /// pop to Login screen after 3 seconds
                    Future.delayed(const Duration(seconds: 3), () {
                      context.popUntil((route) => route.isFirst);
                    });
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is AuthLoadingState
                        ? () {}
                        : () async {
                            if (formKey.currentState!.validate()) {
                              /// hide keyboard
                              context.unfocus;

                              /// add signup event to auth bloc
                              context.read<AuthBloc>().add(
                                    SignupWithEmailPass(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    ),
                                  );
                            }
                          },
                    child: state is AuthLoadingState
                        ? const LoadingIndicator()
                        : const Text('Sign Up'),
                  );
                },
              ).padVertical(20.h),

              /// already have an account text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: context.textTheme.bodySmall,
                  ),
                  Text(
                    ' Sign In',
                    style: context.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                  ).onTap(() => context.pop()),
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
