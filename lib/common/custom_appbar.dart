import 'dart:io';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:flutter/material.dart';

//It contains appbar which is used throughout the app
class CustomAppBar extends StatelessWidget {
  final String title;
  CustomAppBar({this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: blueAccent,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.only(
              right: 10, top: displayWidth(context) > 600 ? 20 : 0),
          child: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: whiteColor,
            size: displayWidth(context) > 600 ? 35 : 25,
          ),
        ),
      ),
      elevation: Platform.isAndroid ? 1 : 0,
      centerTitle: Platform.isAndroid ? false : true,
      title: Padding(
        padding: EdgeInsets.only(top: displayWidth(context) > 600 ? 20 : 0),
        child: Text(
          title,
          style: TextStyle(
              color: whiteColor,
              fontSize: displayWidth(context) > 600 ? 30 : 20),
        ),
      ),
    );
  }
}
