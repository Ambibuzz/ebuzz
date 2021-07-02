import 'package:ebuzz/common/colors.dart';
import 'package:flutter/material.dart';

//It contains appbar which is used throughout the app
class CustomAppBar extends StatelessWidget {
  final List<Widget>? actions;
  final double? elevation;
  final bool? centerTitle;
  final Widget? title;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  CustomAppBar(
      {required this.title,
      this.actions,
      this.elevation = 1,
      this.centerTitle = false,
      this.leading,
      this.automaticallyImplyLeading = true});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blueAccent,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: elevation,
      centerTitle: centerTitle,
      title: title,
    );
  }
}
