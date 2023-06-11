import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Vertical Spacing widgets
class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing(this.height, {super.key});
  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height.h);
}

/// Horizontal Spacing widgets
class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing(this.width, {super.key});
  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(width: width.w);
}
