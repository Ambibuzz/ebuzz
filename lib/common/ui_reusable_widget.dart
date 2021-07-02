import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/util/version.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//datail ui widgets
Widget textFieldName(BuildContext context, String name) {
  return Container(
    height: 40,
    child: Text(
      name,
      style: TextStyle(fontSize: 16),
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
      style: TextStyle(fontSize: 16),
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
          style: TextStyle(fontSize: 18, color: blackColor),
        ),
        Icon(
          Icons.arrow_back,
          color: blackColor,
          size: 25,
        ),
        Text(
          ' or ',
          style: TextStyle(fontSize: 18, color: blackColor),
        ),
        Icon(
          Icons.arrow_forward,
          color: blackColor,
          size: 25,
        ),
        Text(
          ' to view table below',
          style: TextStyle(fontSize: 18, color: blackColor),
        ),
      ],
    ),
  );
}

DataColumn tableColumnText(BuildContext context, String text) {
  return DataColumn(
    label: Text(text),
  );
}

DataCell dataCellText(BuildContext context, String text, double width,
    {int? maxlines = 5, TextOverflow? overflow = TextOverflow.ellipsis}) {
  return DataCell(Container(
    width: width,
    child: Text(
      text,
      maxLines: maxlines,
      overflow: overflow,
    ),
  ));
}

Widget versionText() {
  return Text(
    version,
    style: TextStyle(fontSize: 10),
  );
}
