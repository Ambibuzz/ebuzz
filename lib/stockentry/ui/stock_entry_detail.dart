import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';
import 'package:ebuzz/stockentry/service/stock_entry_service.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/stockentry/model/stockentry.dart';

//StockEntryDetail class contains detail of particular stock entry
class StockEntryDetail extends StatefulWidget {
  final String name;
  final StockEntryModel stockEntryModelData;

  StockEntryDetail({required this.name, required this.stockEntryModelData});
  @override
  _StockEntryDetailState createState() => _StockEntryDetailState();
}

class _StockEntryDetailState extends State<StockEntryDetail> {
  List<StockEntryItem> list = [];
  @override
  void initState() {
    super.initState();
    getStockEntryItemListData();
  }

  getStockEntryItemListData() async {
    list =
        await StockEntryService().getStockEntryitemList(widget.name, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title:
              Text('Stock Entry Detail', style: TextStyle(color: whiteColor)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  stockEntryDetailWidget('Stock Entry Type',
                      widget.stockEntryModelData.stockEntryType),
                  SizedBox(height: 15),
                  stockEntryDetailWidget(
                      'Posting Date', widget.stockEntryModelData.postingDate),
                  SizedBox(height: 15),
                  stockEntryDetailWidget(
                      'Posting Time', widget.stockEntryModelData.postingTime),
                  SizedBox(height: 15),
                  stockEntryDetailWidget(
                      'Company', widget.stockEntryModelData.company),
                  SizedBox(height: 15),
                  stockEntryDetailWidget('Purchase Order',
                      widget.stockEntryModelData.purchaseOrder),
                  SizedBox(height: 15),
                  stockEntryDetailWidget(
                      'Work Order', widget.stockEntryModelData.workOrder),
                  SizedBox(height: 15),
                  stockEntryDetailWidget(
                      'Bom no', widget.stockEntryModelData.bomNo),
                  SizedBox(height: 15),
                  stockEntryDetailWidget('For Quantity',
                      widget.stockEntryModelData.forQuantity.toString()),
                  SizedBox(height: 15),
                  stockEntryDetailWidget('Source Warehouse',
                      widget.stockEntryModelData.defaultSourceWarehouse),
                  SizedBox(height: 15),
                  stockEntryDetailWidget('Target Warehouse',
                      widget.stockEntryModelData.defaultTargetWarehouse),
                  SizedBox(height: 15),
                  stockEntryDetailWidget('Incoming Value',
                      widget.stockEntryModelData.totalIncomingValue.toString()),
                  SizedBox(height: 15),
                  stockEntryDetailWidget('Outgoing Value',
                      widget.stockEntryModelData.totalOutgoingValue.toString()),
                  SizedBox(height: 15),
                  stockEntryDetailWidget(
                      'Value Difference',
                      widget.stockEntryModelData.totalValueDifference
                          .toString()),
                  SizedBox(height: 15),
                ],
              ),
            ),
            scrollToViewTableBelow(context),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: <DataColumn>[
                    tableColumnText(context, 'Source Warehouse'),
                    tableColumnText(context, 'Target Warehouse'),
                    tableColumnText(context, 'Item Code'),
                    tableColumnText(context, 'Item Group'),
                    tableColumnText(context, 'Quantity'),
                  ],
                  rows: list
                      .map((data) => DataRow(cells: <DataCell>[
                            dataCellText(context, data.defaultSourceWarehouse!,
                                displayWidth(context) * 0.7),
                            dataCellText(context, data.defaultTargetWarehouse!,
                                displayWidth(context) * 0.7),
                            dataCellText(
                                context,
                                data.itemCode! + ': ' + data.itemName!,
                                displayWidth(context) * 0.7),
                            dataCellText(context, data.itemGroup!,
                                displayWidth(context) * 0.5),
                            dataCellText(context, data.quantity.toString(),
                                displayWidth(context) * 0.2),
                          ]))
                      .toList()),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget stockEntryDetailWidget(String label, String? value) {
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
