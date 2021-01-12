import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//CircularProgress class displays circular progress indicator or loader in app
class CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCircle(
        color: blueAccent,
        size: displayWidth(context) > 600 ? 75 : 45,
      ),
    );
  }
}
