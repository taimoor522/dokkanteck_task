import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../extensions/widget_extensions.dart';

/// Custom TextFiled widget
class MyTextFiled extends StatefulWidget {
  const MyTextFiled({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.dense = true,
    this.onTap,
  });
  final bool dense;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final VoidCallback? onTap;

  @override
  State<MyTextFiled> createState() => _MyTextFiledState();
}

class _MyTextFiledState extends State<MyTextFiled> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: TextFormField(
        onTap: widget.onTap,
        validator: widget.validator,
        controller: widget.controller,
        cursorColor: Theme.of(context).colorScheme.secondary,
        obscuringCharacter: '*',
        readOnly: widget.onTap != null ? true : false,
        cursorRadius: const Radius.circular(0),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
        obscureText: widget.isPassword && !visible ? true : false,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          isDense: widget.dense,
          hintText: widget.hintText,
          fillColor: Theme.of(context).colorScheme.tertiary,
          filled: true,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? Icon(
                  visible ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.secondary,
                ).onTap(() {
                  setState(() => visible = !visible);
                })
              : widget.suffixIcon,
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.onTap != null
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.error),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.error),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
        ),
      ),
    );
  }
}
