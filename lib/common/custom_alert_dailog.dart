import 'package:flutter/material.dart';

void customAlertDialog({
   required BuildContext context,
    required Widget content,
    required  Widget title,
    required  List<Widget> actions}) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          elevation: 2,
          content: content,
          title: title,
          actions: actions,
        );
      });
}
