import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//datail ui widgets
Widget textFieldName(BuildContext context, String name) {
  return Container(
    height: 40,
    child: Text(
      name,
      style: displayWidth(context) > 600
          ? TextStyle(
              fontSize: 28,
            )
          : TextStyle(fontSize: 16),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    ),
  );
}

Widget colon(BuildContext context) {
  return Container(
    height: 40,
    child: Text(
      ':',
      style: displayWidth(context) > 600
          ? TextStyle(
              fontSize: 28,
            )
          : TextStyle(fontSize: 16),
    ),
  );
}

Widget scrollToViewTableBelow(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        Text(
          'Scroll ',
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyles.t18Black,
        ),
        Icon(
          Icons.arrow_back,
          color: blackColor,
          size: displayWidth(context) > 600 ? 35 : 25,
        ),
        Text(
          ' or ',
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyles.t18Black,
        ),
        Icon(
          Icons.arrow_forward,
          color: blackColor,
          size: displayWidth(context) > 600 ? 35 : 25,
        ),
        Text(
          ' to view table below',
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyles.t18Black,
        ),
      ],
    ),
  );
}

DataColumn tableColumnText(BuildContext context, String text) {
  return DataColumn(
    label: Text(
      text,
      style: displayWidth(context) > 600
          ? TextStyle(
              fontSize: 32,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold)
          : TextStyle(
              fontStyle: FontStyle.italic,
            ),
    ),
  );
}

DataCell dataCellText(BuildContext context, String text) {
  return DataCell(
    Text(
      text,
      style: displayWidth(context) > 600
          ? TextStyle(fontSize: 26, color: blackColor)
          : TextStyles.t16Black,
    ),
  );
}
