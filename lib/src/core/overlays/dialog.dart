import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/assets.dart';
import '../extensions/widget_extensions.dart';
import '../widgets/spacing.dart';

class AppDialog {
  static void show(BuildContext context,
      {required IconData icon,
      required String title,
      required String discription,
      required Widget action}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: SizedBox(
          width: 300.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.assetsDialogBubbles,
                    width: 250.w,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  CircleAvatar(
                    radius: 50.r,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      icon,
                      size: 50.w,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              VerticalSpacing(20.h),
              Text(title,
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
              VerticalSpacing(20.h),
              Text(discription,
                  textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
              VerticalSpacing(20.h),
              action,
            ],
          ).padAll(20.w),
        ),
      ),
    );
  }
}
