import 'package:flutter/material.dart';

void customAlertDialog({
    BuildContext context, Widget content, Widget title, List<Widget> actions}) {
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
