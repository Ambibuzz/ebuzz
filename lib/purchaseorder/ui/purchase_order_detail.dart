import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/purchaseorder/model/purchase_model.dart';
import 'package:ebuzz/purchaseorder/service/purchase_api_service.dart';
import 'package:ebuzz/purchasereciept/ui/purchase_reciept_Form_ui.dart';
import 'package:flutter/material.dart';

//PurchaseOrderDetail class contains details of particular purchase order
class PurchaseOrderDetail extends StatefulWidget {
  final String name;
  final String supplier;
  final String date;
  final String requiredDate;
  PurchaseOrderDetail({this.name, this.supplier, this.date, this.requiredDate});
  @override
  _PurchaseOrderDetailState createState() => _PurchaseOrderDetailState();
}

class _PurchaseOrderDetailState extends State<PurchaseOrderDetail> {
  List<ItemsModel> items = [];
  PurchaseApiService _purchaseApiService = PurchaseApiService();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    items = await _purchaseApiService.getPurchaseOrderItemList(widget.name);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Purchase Order Detail',
          )),
      body: PurchaseOrderDetailUi(
        date: widget.date,
        itemList: items,
        name: widget.name,
        requiredDate: widget.requiredDate,
        supplier: widget.supplier,
      ),
      floatingActionButton: Container(
        width: displayWidth(context) > 600 ? 100 : 50,
        height: displayWidth(context) > 600 ? 100 : 50,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.add, size: displayWidth(context) > 600 ? 35 : 25),
            backgroundColor: blueAccent,
            onPressed: () {
              pushScreen(
                  context,
                  PurchaseRecieptFormUi(
                    supplier: widget.supplier,
                    name: widget.name,
                  ));
            },
          ),
        ),
      ),
    );
  }
}

class PurchaseOrderDetailUi extends StatelessWidget {
  final String name;
  final String supplier;
  final String date;
  final String requiredDate;
  final List<ItemsModel> itemList;
  PurchaseOrderDetailUi(
      {this.name, this.supplier, this.date, this.requiredDate, this.itemList});

  @override
  Widget build(BuildContext context) {
    return itemList.length == 0
        ? CircularProgress()
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Supplier : ' + supplier,
                    style: displayWidth(context) > 600
                        ? TextStyle(
                            fontSize: 32,
                            color: blackColor,
                            fontWeight: FontWeight.bold)
                        : TextStyles.t20BlackBold,
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Name : ' + name,
                    style: displayWidth(context) > 600
                        ? TextStyle(fontSize: 28, color: blackColor)
                        : TextStyles.t18Black,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Date : ' + date,
                    style: displayWidth(context) > 600
                        ? TextStyle(fontSize: 28, color: blackColor)
                        : TextStyles.t18Black,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Required Date : ' + requiredDate,
                    style: displayWidth(context) > 600
                        ? TextStyle(fontSize: 28, color: blackColor)
                        : TextStyles.t18Black,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
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
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Name',
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
                              'Item Code',
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
                              'Recieved',
                              style: displayWidth(context) > 600
                                  ? TextStyle(
                                      fontSize: 32,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold)
                                  : TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: itemList
                            .map((data) => DataRow(cells: <DataCell>[
                                  DataCell(Text(
                                    data.itemName,
                                    style: displayWidth(context) > 600
                                        ? TextStyle(
                                            fontSize: 26, color: blackColor)
                                        : TextStyles.t16Black,
                                  )),
                                  DataCell(Text(
                                    data.itemCode,
                                    style: displayWidth(context) > 600
                                        ? TextStyle(
                                            fontSize: 28, color: blackColor)
                                        : TextStyles.t18Black,
                                  )),
                                  DataCell(Text(
                                    data.quantity.toString(),
                                    style: displayWidth(context) > 600
                                        ? TextStyle(
                                            fontSize: 28, color: blackColor)
                                        : TextStyles.t18Black,
                                  )),
                                  DataCell(Text(
                                    data.quantityRecieved.toString(),
                                    style: displayWidth(context) > 600
                                        ? TextStyle(
                                            fontSize: 28, color: blackColor)
                                        : TextStyles.t18Black,
                                  )),
                                ]))
                            .toList()),
                  ),
                ],
              ),
            ),
          );
  }
}
