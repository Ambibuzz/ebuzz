import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/salesorder/model/sales_order.dart';
import 'package:ebuzz/salesorder/service/sales_order_service.dart';
import 'package:ebuzz/salesorder/ui/sales_order_detail_ui.dart';
import 'package:ebuzz/salesorder/ui/sales_order_form1.dart';
import 'package:flutter/material.dart';

class SalesOrderListUi extends StatefulWidget {
  @override
  _SalesOrderListUiState createState() => _SalesOrderListUiState();
}

class _SalesOrderListUiState extends State<SalesOrderListUi> {
  List<SalesOrder> _salesOrderList = [];
  @override
  void initState() {
    super.initState();
    getSalesOrderList();
  }

  getSalesOrderList() async {
    _salesOrderList = await SalesOrderService().getSalesOrderList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Sales Order',
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: ListView.builder(
          itemCount: _salesOrderList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                pushScreen(
                  context,
                  SalesOrderDetail(
                    salesOrder: _salesOrderList[index],
                  ),
                );
              },
              child: SOTileUi(
                soData: _salesOrderList[index],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueAccent,
        onPressed: () {
          pushScreen(context, SalesOrderForm1());
        },
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}

//SOTileUi class is a reusable widget which contains ui of list of sales order

class SOTileUi extends StatelessWidget {
  final SalesOrder soData;
  const SOTileUi({this.soData});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.99,
      height: 130,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      soData.customer ?? '',
                      style: TextStyles.t18Black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Delivery Date : ' + soData.deliverydate,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Grand Total : \$' + soData.grandtotal.toString(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Percent Billed : ' +
                              soData.perbilled.toStringAsPrecision(4) +
                              '%  ',
                        ),
                        Text(
                          'Percent Delivered : ' +
                              soData.perdelivered.toStringAsPrecision(4) +
                              '%',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Status : ' + soData.status,
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 5,
                ),
                // Container(
                //   width: displayWidth(context) > 600 ? 30 : 15,
                //   height: displayWidth(context) > 600 ? 30 : 15,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: soData.status == 'Draft' ? redColor : blackColor),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
