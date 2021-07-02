import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    this.child,
    this.elevation = 1,
    this.color = Colors.white,
    this.margin = EdgeInsets.zero,
    this.shape,
  });
  final Widget? child;
  final double? elevation;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final ShapeBorder? shape;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: child,
      color: color,
      margin: margin,
      shape: shape,
    );
  }
}
