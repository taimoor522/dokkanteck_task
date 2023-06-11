import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';

/// AppThemes class

class AppThemes {
  static ThemeData light = ThemeData.light().copyWith(
    primaryColor: AppColors.lightGrey,
    textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).copyWith(
          bodySmall: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).bodyLarge!.copyWith(
                color: AppColors.black,
                fontSize: 16.sp,
              ),
          bodyMedium: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).bodyMedium!.copyWith(
                color: AppColors.black,
                fontSize: 18.sp,
              ),
          bodyLarge: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).bodyMedium!.copyWith(
                color: AppColors.black,
                fontSize: 20.sp,
              ),
          titleSmall: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).titleLarge!.copyWith(
                color: AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
          titleMedium: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).titleLarge!.copyWith(
                color: AppColors.black,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
          titleLarge: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).titleLarge!.copyWith(
                color: AppColors.black,
                fontSize: 32.sp,
                fontWeight: FontWeight.w900,
              ),
          displaySmall:
              Typography.englishLike2018.apply(fontSizeFactor: 1.sp).displaySmall!.copyWith(
                    color: AppColors.black,
                    fontSize: 38.sp,
                    fontWeight: FontWeight.w400,
                  ),
          displayMedium:
              Typography.englishLike2018.apply(fontSizeFactor: 1.sp).displayMedium!.copyWith(
                    color: AppColors.black,
                    fontSize: 44.sp,
                    fontWeight: FontWeight.w700,
                  ),
          displayLarge:
              Typography.englishLike2018.apply(fontSizeFactor: 1.sp).displayMedium!.copyWith(
                    color: AppColors.black,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w900,
                  ),
        ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.white,
      secondary: AppColors.black,
      tertiary: AppColors.lightGrey,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.grey,
        disabledForegroundColor: AppColors.white,
        maximumSize: Size(double.infinity, 60.h),
        minimumSize: Size(double.infinity, 60.h),
        padding: EdgeInsets.symmetric(vertical: 5.h),
        textStyle: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).labelLarge!.copyWith(
              color: AppColors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
        shape: const StadiumBorder(),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.black,
        splashFactory: NoSplash.splashFactory,
        textStyle: Typography.englishLike2018
            .apply(fontSizeFactor: 1.sp)
            .labelLarge!
            .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(10.w),
        foregroundColor: AppColors.black,
        side: const BorderSide(width: 1.0, color: AppColors.black),
        textStyle: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).labelLarge!.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
      ),
    ),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.black,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).titleLarge!.copyWith(
            fontSize: 24.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w600,
          ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.lightGrey,
      titleTextStyle: Typography.englishLike2018.apply(fontSizeFactor: 1.sp).titleLarge!.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
          ),
      contentTextStyle: Typography.englishLike2018
          .apply(fontSizeFactor: 1.sp)
          .bodyMedium!
          .copyWith(fontSize: 18.sp),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lightGrey,
      elevation: 0,
    ),
    iconTheme: const IconThemeData(color: AppColors.black),
  );
}
