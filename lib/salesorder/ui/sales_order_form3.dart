import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/salesorder/model/sales_order.dart';
import 'package:flutter/material.dart';

class SalesOrderForm3 extends StatefulWidget {
  final String date;
  final String company;
  final String customer;
  final String warehouse;
  final String purchaseorder;
  final String portOfDischarge;
  final String orderType;
  final double totalInr;
  final int totalQuantity;
  final List<SalesOrderItems> salesOrderItems;

  SalesOrderForm3(
      {this.date,
      this.company,
      this.customer,
      this.warehouse,
      this.purchaseorder,
      this.portOfDischarge,
      this.orderType,
      this.salesOrderItems,
      this.totalInr,
      this.totalQuantity});
  @override
  _SalesOrderForm3State createState() => _SalesOrderForm3State();
}

class _SalesOrderForm3State extends State<SalesOrderForm3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'Sales Order Form',
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
