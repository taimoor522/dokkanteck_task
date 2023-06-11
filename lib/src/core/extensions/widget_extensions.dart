import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  Widget expand([int? flex]) => Expanded(flex: flex ?? 1, child: this);
  Widget flexible([int? flex]) => Flexible(flex: flex ?? 1, child: this);
  Widget get center => Center(child: this);
  Widget padAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);
  Widget padHorizontal(double value) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: value), child: this);
  Widget padVertical(double value) =>
      Padding(padding: EdgeInsets.symmetric(vertical: value), child: this);

  Widget padOnly({double? left, double? top, double? right, double? bottom}) => Padding(
        padding:
            EdgeInsets.only(left: left ?? 0, top: top ?? 0, right: right ?? 0, bottom: bottom ?? 0),
        child: this,
      );

  Widget onTap(Function() onTap) => GestureDetector(onTap: onTap, child: this);
}
