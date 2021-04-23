import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final Function onPressed;
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  const GradientButton(
      {@required this.onPressed,
      @required this.child,
      @required this.gradient,
      this.width,
      this.height});

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: widget.gradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: widget.onPressed,
          child:  widget.child,
        ),
      ),
    );
  }
}
