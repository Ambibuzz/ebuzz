import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final double? elevation;
  final void Function()? onTap;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final Widget? title;
  final Widget? subtitle;

  const CardListTile({
    this.leading,
    this.trailing,
    this.elevation=1,
    this.onTap,
    this.color,
    this.margin=EdgeInsets.zero,
    this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      margin: margin,
      child: ListTile(
        leading: leading,
        trailing: trailing,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
      ),
    );
  }
}
