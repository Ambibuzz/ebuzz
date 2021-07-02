import 'package:ebuzz/common/colors.dart';
import 'package:flutter/material.dart';

//CircularProgress class displays circular progress indicator or loader in app
class CircularProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(backgroundColor: blueAccent,),
    );
  }
}
