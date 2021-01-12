import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//It displays toast message throughout the app

fluttertoast(Color textColor, Color backgroundColor, String message) {
  return Fluttertoast.showToast(
      msg: message,
      textColor: textColor,
      backgroundColor: backgroundColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG);
}
