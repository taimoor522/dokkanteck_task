import 'package:flutter/material.dart';
import 'package:flutter_snackbar_plus/flutter_snackbar_plus.dart';

import '../constants/colors.dart';
import '../enum/snackbar_content_type.dart';

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    SnackbarContentType? snackbarContentType,
  }) {
    FlutterSnackBar.showTemplated(
      context,
      title: snackbarContentType.text,
      message: message,
      leading: CircleAvatar(
        backgroundColor: AppColors.white,
        child: Icon(
          snackbarContentType.icon,
          size: 30,
          color: snackbarContentType.color,
        ),
      ),
      style: FlutterSnackBarStyle(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        radius: BorderRadius.circular(6),
        backgroundColor: snackbarContentType.color,
        shadow: BoxShadow(
          color: Colors.black.withOpacity(0.55),
          blurRadius: 32,
          offset: const Offset(0, 12),
          blurStyle: BlurStyle.normal,
          spreadRadius: -10,
        ),
        leadingSpace: 22,
        trailingSpace: 12,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        titleStyle: const TextStyle(fontSize: 20, color: Colors.white),
        messageStyle: const TextStyle(fontSize: 16, color: Colors.white),
        titleAlignment: TextAlign.start,
        messageAlignment: TextAlign.start,
      ),
      configuration: const FlutterSnackBarConfiguration(
        location: FlutterSnackBarLocation.top,
        distance: 10,
        animationCurve: Curves.ease,
        animationDuration: Duration(milliseconds: 500),
        showDuration: Duration(seconds: 3),
        persistent: false,
        dismissible: false,
        dismissDirection: DismissDirection.horizontal,
        showLoadingBar: false,
      ),
    );
  }
}

extension SnackbarContentTypeExtension on SnackbarContentType? {
  String get text {
    if (this == SnackbarContentType.failure) return 'Error';
    if (this == SnackbarContentType.success) return 'Success';
    if (this == SnackbarContentType.info) return 'Info';
    throw UnsupportedError('Enum not defined');
  }

  IconData get icon {
    if (this == SnackbarContentType.failure) return Icons.close;
    if (this == SnackbarContentType.success) return Icons.check;
    if (this == SnackbarContentType.info) return Icons.info;
    throw UnsupportedError('Enum not defined');
  }

  Color get color {
    if (this == SnackbarContentType.failure) return AppColors.error;
    if (this == SnackbarContentType.success) return AppColors.success;
    throw UnsupportedError('Enum not defined');
  }
}
