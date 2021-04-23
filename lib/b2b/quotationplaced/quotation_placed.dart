import 'package:ebuzz/b2b/myquotations/myquotations.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/home/ui/home.dart';
import 'package:flutter/material.dart';

class QuotationPlaced extends StatelessWidget {
  final String name;
  final IconData icon;
  final String statusText;
  final Color iconColor;
  final int qty;
  final int totalPrice;
  QuotationPlaced(
      {this.name,
      this.icon,
      this.statusText,
      this.iconColor,
      this.qty,
      this.totalPrice});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: displayHeight(context) * 0.15,
          ),
          Icon(
            icon,
            color: iconColor,
            size: 120,
          ),
          SizedBox(
            height: displayHeight(context) * 0.06,
          ),
          Text(
            'Quotation Placed',
            style: TextStyles.t24Black,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Text(
            'Your Quotation is $name',
            style: TextStyles.t16Black,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: displayHeight(context) * 0.02,
          ),
          Text(
            'Total price for $qty items is $totalPrice',
            style: TextStyles.t16Black,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          Column(
            children: [
              button(context, 'Your Quotations', blueAccent, whiteColor, () {
                pushReplacementScreen(context, MyQuotations());
              }, TextStyles.t18White),
              button(context, 'Return to Home', whiteColor, blueAccent, () {
                // pushReplacementScreen(context, Home());
                Navigator.pop(context);
                Navigator.pop(context);
              }, TextStyles.t18Blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context, String text, Color primaryColor,
      Color onPrimaryColor, Function onPress, TextStyle textStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ConstrainedBox(
        constraints:
            BoxConstraints.tightFor(width: displayWidth(context), height: 60),
        child: RoundButton(
          onPressed: onPress,
          child: Text(text, style: textStyle),
          primaryColor: primaryColor,
          onPrimaryColor: onPrimaryColor,
          elevation: 2,
        ),
      ),
    );
  }
}
