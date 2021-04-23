import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:flutter/material.dart';

class MyQuotations extends StatefulWidget {
  @override
  _MyQuotationsState createState() => _MyQuotationsState();
}

class _MyQuotationsState extends State<MyQuotations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'My Quotations',
        ),
      ),
    );
  }
}
