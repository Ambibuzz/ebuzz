import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final double elevation;
  const RoundButton(
      {required this.onPressed,
      required this.child,
      required this.primaryColor,
      required this.onPrimaryColor,
      this.elevation = 1,
      });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
      ),
    );
  }
}
