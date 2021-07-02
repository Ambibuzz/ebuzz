import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';
import 'package:ebuzz/purchaseorder/model/purchase_model.dart';
import 'package:ebuzz/purchaseorder/service/purchase_api_service.dart';
import 'package:ebuzz/purchasereciept/ui/purchase_reciept_Form_ui.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:flutter/material.dart';

//PurchaseOrderDetail class contains details of particular purchase order
class PurchaseOrderDetail extends StatefulWidget {
  final String name;
  final String supplier;
  final String date;
  final String requiredDate;
  PurchaseOrderDetail(
      {required this.name,
      required this.supplier,
      required this.date,
      required this.requiredDate});
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
    items = await _purchaseApiService.getPurchaseOrderItemList(
        widget.name, context);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: Text('Purchase Order Detail',
                style: TextStyle(color: whiteColor)),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
            ),
          )),
      body: PurchaseOrderDetailUi(
        date: widget.date,
        itemList: items,
        name: widget.name,
        requiredDate: widget.requiredDate,
        supplier: widget.supplier,
      ),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.add, size: 25),
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
      {required this.name,
      required this.supplier,
      required this.date,
      required this.requiredDate,
      required this.itemList});

  @override
  Widget build(BuildContext context) {
    return itemList.length == 0
        ? CircularProgress()
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      purchaseOrderDetailWidget('Supplier', supplier),
                      SizedBox(height: 15),
                      purchaseOrderDetailWidget('Name', name),
                      SizedBox(height: 15),
                      purchaseOrderDetailWidget('Date', date),
                      SizedBox(height: 15),
                      purchaseOrderDetailWidget('Required Date', requiredDate),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                scrollToViewTableBelow(context),
                SizedBox(height: 5),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                      columns: <DataColumn>[
                        tableColumnText(context, 'Name'),
                        tableColumnText(context, 'Item Code'),
                        tableColumnText(context, 'Quantity'),
                        tableColumnText(context, 'Recieved'),
                      ],
                      rows: itemList
                          .map((data) => DataRow(cells: <DataCell>[
                                dataCellText(context, data.itemName!,
                                    displayWidth(context) * 0.7),
                                dataCellText(context, data.itemCode!,
                                    displayWidth(context) * 0.3),
                                dataCellText(context, data.quantity.toString(),
                                    displayWidth(context) * 0.3),
                                dataCellText(
                                    context,
                                    data.quantityRecieved.toString(),
                                    displayWidth(context) * 0.3),
                              ]))
                          .toList()),
                ),
              ],
            ),
          );
  }

  Widget purchaseOrderDetailWidget(String label, String value) {
    return CustomTextFormField(
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: label,
      readOnly: true,
      initialValue: value,
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }
}
