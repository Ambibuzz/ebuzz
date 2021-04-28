import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';
import 'package:ebuzz/salesorder/model/sales_order.dart';
import 'package:ebuzz/salesorder/service/sales_order_service.dart';
import 'package:flutter/material.dart';

class SalesOrderDetail extends StatefulWidget {
  final SalesOrder salesOrder;
  SalesOrderDetail({this.salesOrder});
  @override
  _SalesOrderDetailState createState() => _SalesOrderDetailState();
}

class _SalesOrderDetailState extends State<SalesOrderDetail> {
  List<SalesOrderItems> _salesOrderItems = [];
  List<SalesOrderPaymentSchedule> _salesOrderPaymentSchedule = [];

  @override
  void initState() {
    super.initState();
    getSalesOrderItemsAndPaymentSchedule();
  }

  getSalesOrderItemsAndPaymentSchedule() async {
    _salesOrderItems =
        await SalesOrderService().getSalesOrderItemList(widget.salesOrder.name,context);
    _salesOrderPaymentSchedule = await SalesOrderService()
        .getSalesOrderPaymentScheduleList(widget.salesOrder.name,context);
    print(_salesOrderItems.length);
    print(_salesOrderPaymentSchedule.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'Sales Order Detail',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SODetailUiWidget(
              soData: widget.salesOrder,
              salesOrderItemsList: _salesOrderItems,
              salesOrderPaymentScheduleList: _salesOrderPaymentSchedule,
            ),
          ],
        ),
      ),
    );
  }
}

//SODetailUiWidget class is a reusable widget which contains detail of sales order
class SODetailUiWidget extends StatelessWidget {
  final SalesOrder soData;
  final List<SalesOrderItems> salesOrderItemsList;
  final List<SalesOrderPaymentSchedule> salesOrderPaymentScheduleList;

  SODetailUiWidget(
      {this.soData,
      this.salesOrderItemsList,
      this.salesOrderPaymentScheduleList});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Container(
                width: displayWidth(context) * 0.32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Customer'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Company'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Order Type'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Transaction Date'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Delivery Date'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Purchase Order Date'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Purchase Order Number'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Port Of Discharge'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Total Quantity'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Total Net Weight'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Grand Total (INR)'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Grand Total (USD)'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Status'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Advance Paid'),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                  colon(context),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: displayWidth(context) * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.customer),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.company),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.ordertype),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.transactiondate),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.deliverydate),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.pono),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.podate),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.portofdischarge),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.totalqty.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.totalnetweight.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(
                        context, '₹' + soData.basegrandtotal.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, '\$' + soData.grandtotal.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.status),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, soData.advancepaid.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        scrollToViewTableBelow(context),
        SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: <DataColumn>[
              tableColumnText(context, 'Item Code'),
              tableColumnText(context, 'ItemName'),
              tableColumnText(context, 'Delivery Date'),
              tableColumnText(context, 'Quantity'),
              tableColumnText(context, 'Rate'),
              tableColumnText(context, 'Amount'),
            ],
            rows: salesOrderItemsList
                .map((data) => DataRow(cells: <DataCell>[
                      dataCellText(context, data.itemcode),
                      dataCellText(context, data.itemname),
                      dataCellText(context, data.deliverydate),
                      dataCellText(context, data.qty.toString()),
                      dataCellText(context, '\$' + data.rate.toString()),
                      dataCellText(context, '\$' + data.amount.toString()),
                    ]))
                .toList(),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: <DataColumn>[
              tableColumnText(context, 'Payment Term'),
              tableColumnText(context, 'Description'),
              tableColumnText(context, 'Due Date'),
              tableColumnText(context, 'Invoice Portion'),
              tableColumnText(context, 'Payment Amount'),
            ],
            rows: salesOrderPaymentScheduleList
                .map((data) => DataRow(cells: <DataCell>[
                      dataCellText(context, data.paymentterm),
                      dataCellText(context, data.description),
                      dataCellText(context, data.duedate),
                      dataCellText(
                          context, data.invoiceportion.toString() + '%'),
                      dataCellText(
                          context, '\$' + data.paymentamount.toString()),
                    ]))
                .toList(),
          ),
        ),
      ],
    );
  }
}
