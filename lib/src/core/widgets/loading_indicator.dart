import 'package:flutter/material.dart';

import '../extensions/build_context_extensions.dart';
import '../extensions/widget_extensions.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.color, this.size = 50});
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: SizedBox(
        height: size,
        child: AspectRatio(
          aspectRatio: 1,
          child: CircularProgressIndicator(
            color: color ?? context.colorScheme.primary,
          ),
        ),
      ).center,
    );
  }
}
