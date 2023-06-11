import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  // Theme Extensions
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  IconThemeData get iconTheme => Theme.of(this).iconTheme;
  ElevatedButtonThemeData get elevatedButtonTheme => Theme.of(this).elevatedButtonTheme;

  // MediaQuery Extensions
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  // Focus Extensions
  void unfocus() {
    final FocusScopeNode currentScope = FocusScope.of(this);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  // Navigation Extensions
  Future push(Widget screen) =>
      Navigator.of(this, rootNavigator: true).push(MaterialPageRoute(builder: (_) => screen));
  Future pushReplacement(Widget screen) => Navigator.of(this, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (_) => screen),
      );
  void pop([result]) => Navigator.of(this, rootNavigator: true).pop(result);
  void popUntil(bool Function(Route<dynamic>) predicate) =>
      Navigator.of(this, rootNavigator: true).popUntil(predicate);
}
