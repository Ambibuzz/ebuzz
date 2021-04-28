import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';
import 'package:ebuzz/stockentry/service/stock_entry_service.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/stockentry/model/stockentry.dart';

//StockEntryDetail class contains detail of particular stock entry
class StockEntryDetail extends StatefulWidget {
  final String name;
  final StockEntryModel stockEntryModelData;

  StockEntryDetail({this.name, this.stockEntryModelData});
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
    list = await StockEntryService().getStockEntryitemList(widget.name,context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'Stock Entry',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12, right: 10),
              child: Row(
                children: [
                  Container(
                    width: displayWidth(context) * 0.33,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(context, 'Stock Entry Type'),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(context, 'Posting Date'),
                      
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(context, 'Posting Time'),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(context, 'Company'),
                        SizedBox(
                          height: 10,
                        ),

                        widget.stockEntryModelData.purchaseOrder != ''
                            ? textFieldName(context, 'Purchase Order')
                            : Container(),
                        widget.stockEntryModelData.purchaseOrder != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.workOrder != ''
                            ? textFieldName(context, 'Work Order')
                            : Container(),
                        widget.stockEntryModelData.workOrder != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),

                        widget.stockEntryModelData.bomNo != ''
                            ? textFieldName(context, 'Bom No')
                            : Container(),
                        widget.stockEntryModelData.bomNo != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),

                        widget.stockEntryModelData.forQuantity != 0
                            ? textFieldName(context, 'For Quantity')
                            : Container(),
                        widget.stockEntryModelData.forQuantity != 0
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultSourceWarehouse != ''
                            ? textFieldName(context, 'Source Warehouse')
                            : Container(),
                        widget.stockEntryModelData.defaultSourceWarehouse != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultTargetWarehouse != ''
                            ? textFieldName(context, 'Target Warehouse')
                            : Container(),
                        widget.stockEntryModelData.defaultTargetWarehouse != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        textFieldName(context, 'Incoming Value'),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(context, 'Outgoing Value'),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(context, 'Value Difference'),
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
                      widget.stockEntryModelData.purchaseOrder != ''
                          ? colon(context)
                          : Container(),
                      widget.stockEntryModelData.purchaseOrder != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.workOrder != ''
                          ? colon(context)
                          : Container(),
                      widget.stockEntryModelData.workOrder != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.bomNo != ''
                          ? colon(context)
                          : Container(),
                      widget.stockEntryModelData.bomNo != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.forQuantity != 0
                          ? colon(context)
                          : Container(),
                      widget.stockEntryModelData.forQuantity != 0
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.defaultSourceWarehouse != ''
                          ? colon(context)
                          : Container(),
                      widget.stockEntryModelData.defaultSourceWarehouse != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.defaultTargetWarehouse != ''
                          ? colon(context)
                          : Container(),
                      widget.stockEntryModelData.defaultTargetWarehouse != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      colon(context),
                      SizedBox(
                        height: 10,
                      ),
                      colon(context),
                      SizedBox(
                        height: 10,
                      ),
                      colon(context),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: displayWidth(context) * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(
                            context, widget.stockEntryModelData.stockEntryType),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(
                            context, widget.stockEntryModelData.postingDate),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(
                            context, widget.stockEntryModelData.postingTime),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(
                            context, widget.stockEntryModelData.company),
                        SizedBox(
                          height: 10,
                        ),
                        widget.stockEntryModelData.purchaseOrder != ''
                            ? textFieldName(context,
                                widget.stockEntryModelData.purchaseOrder)
                            : Container(),
                        widget.stockEntryModelData.purchaseOrder != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.workOrder != ''
                            ? textFieldName(
                                context, widget.stockEntryModelData.workOrder)
                            : Container(),
                        widget.stockEntryModelData.workOrder != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.bomNo != ''
                            ? textFieldName(
                                context, widget.stockEntryModelData.bomNo)
                            : Container(),
                        widget.stockEntryModelData.bomNo != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.forQuantity != 0
                            ? textFieldName(
                                context,
                                widget.stockEntryModelData.forQuantity
                                    .toString())
                            : Container(),
                        widget.stockEntryModelData.forQuantity != 0
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultSourceWarehouse != ''
                            ? textFieldName(
                                context,
                                widget
                                    .stockEntryModelData.defaultSourceWarehouse)
                            : Container(),
                        widget.stockEntryModelData.defaultSourceWarehouse != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultTargetWarehouse != ''
                            ? textFieldName(
                                context,
                                widget
                                    .stockEntryModelData.defaultTargetWarehouse)
                            : Container(),
                        widget.stockEntryModelData.defaultTargetWarehouse != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        textFieldName(
                            context,
                            widget.stockEntryModelData.totalIncomingValue
                                .toString()),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(
                            context,
                            widget.stockEntryModelData.totalOutgoingValue
                                .toString()),
                        SizedBox(
                          height: 10,
                        ),
                        textFieldName(
                            context,
                            widget.stockEntryModelData.totalValueDifference
                                .toString()),
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
                    tableColumnText(context, 'Source Warehouse'),
                    tableColumnText(context, 'Target Warehouse'),
                    tableColumnText(context, 'Item Code'),
                    tableColumnText(context, 'Item Group'),
                    tableColumnText(context, 'Quantity'),
                  ],
                  rows: list
                      .map((data) => DataRow(cells: <DataCell>[
                            dataCellText(context, data.defaultSourceWarehouse),
                            dataCellText(context, data.defaultTargetWarehouse),
                            dataCellText(
                                context, data.itemCode + ': ' + data.itemName),
                            dataCellText(context, data.itemGroup),
                            dataCellText(context, data.quantity.toString()),
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
}
