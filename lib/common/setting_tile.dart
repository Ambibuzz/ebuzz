import 'package:ebuzz/common/colors.dart';
import 'package:flutter/material.dart';

//It contains ui of tile used in settings
class SettingsTile extends StatelessWidget {
  final String text;
  SettingsTile({this.text=''});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(text),
        ),
        Divider(
          color: blackColor,
          height: 1,
        ),
      ],
    );
  }
}
