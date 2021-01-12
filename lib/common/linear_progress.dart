import 'package:flutter/material.dart';
import 'colors.dart';

//LinearProgress class displays linear progress indicator or loader which is not circular but linear in app
class LinearProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinearProgressIndicator(
        backgroundColor: blueAccent,
      ),
    );
  }
}
