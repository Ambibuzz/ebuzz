import 'package:flutter/material.dart';

class RoundButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  final Color primaryColor;
  final Color onPrimaryColor;
  const RoundButton(
      {@required this.onPressed,
      @required this.child,
      @required this.primaryColor,
      @required this.onPrimaryColor});

  @override
  _RoundButtonState createState() => _RoundButtonState();
}

class _RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.child,
      style: ElevatedButton.styleFrom(
        primary: widget.primaryColor,
        onPrimary: widget.onPrimaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
