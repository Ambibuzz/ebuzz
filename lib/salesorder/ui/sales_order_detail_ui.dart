import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
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
        await SalesOrderService().getSalesOrderItemList(widget.salesOrder.name);
    _salesOrderPaymentSchedule = await SalesOrderService()
        .getSalesOrderPaymentScheduleList(widget.salesOrder.name);
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
                    Container(
                      height: 40,
                      child: Text(
                        'Customer',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Company',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Order Type',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Transaction Date',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Delivery Date',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Purchase Order Date',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Purchase Order Number',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Port Of Discharge',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Total Quantity',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Total Net Weight',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Grand Total (INR)',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Grand Total (USD)',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Status',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Advance Paid',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
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
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    child: Text(
                      ':',
                      style: displayWidth(context) > 600
                          ? TextStyle(
                              fontSize: 28,
                            )
                          : TextStyle(fontSize: 16),
                    ),
                  ),
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
                    Container(
                      height: 40,
                      child: Text(
                        soData.customer,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.company,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.ordertype,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.transactiondate,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.deliverydate,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.pono,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.podate,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.portofdischarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.totalqty.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.totalnetweight.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        '₹' + soData.basegrandtotal.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        '\$' + soData.grandtotal.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        soData.status,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: displayWidth(context) * 0.5,
                      child: Text(
                        soData.advancepaid.toString(),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
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
        ),
        SizedBox(
          height: 5,
        ),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  'Item Code',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                ),
              ),
              DataColumn(
                label: Text(
                  'ItemName',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Delivery Date',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Quantity',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Rate',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Amount',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: salesOrderItemsList
                .map((data) => DataRow(cells: <DataCell>[
                      DataCell(Text(
                        data.itemcode,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 26, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Text(
                        data.itemname,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 28, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Text(
                        data.deliverydate,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 28, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Center(
                        child: Text(
                          data.qty.toString(),
                          style: displayWidth(context) > 600
                              ? TextStyle(fontSize: 28, color: blackColor)
                              : TextStyles.t16Black,
                        ),
                      )),
                      DataCell(Center(
                        child: Text(
                          '\$' + data.rate.toString(),
                          style: displayWidth(context) > 600
                              ? TextStyle(fontSize: 28, color: blackColor)
                              : TextStyles.t16Black,
                        ),
                      )),
                      DataCell(Center(
                        child: Text(
                          '\$' + data.amount.toString(),
                          style: displayWidth(context) > 600
                              ? TextStyle(fontSize: 28, color: blackColor)
                              : TextStyles.t16Black,
                        ),
                      )),
                    ]))
                .toList(),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Text(
                  'Payment Term',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Description',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Due Date',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Invoice Portion',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              DataColumn(
                label: Text(
                  'Payment Amount',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: salesOrderPaymentScheduleList
                .map((data) => DataRow(cells: <DataCell>[
                      DataCell(Text(
                        data.paymentterm,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 26, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Text(
                        data.description,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 28, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Text(
                        data.duedate,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 28, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Center(
                        child: Text(
                          data.invoiceportion.toString() + '%',
                          style: displayWidth(context) > 600
                              ? TextStyle(fontSize: 28, color: blackColor)
                              : TextStyles.t16Black,
                        ),
                      )),
                      DataCell(Center(
                        child: Text(
                          '\$' + data.paymentamount.toString(),
                          style: displayWidth(context) > 600
                              ? TextStyle(fontSize: 28, color: blackColor)
                              : TextStyles.t16Black,
                        ),
                      )),
                    ]))
                .toList(),
          ),
        ),
      ],
    );
  }
}
