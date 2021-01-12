import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
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
    list = await StockEntryService().getStockEntryitemList(widget.name);
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
                        Container(
                          height: 40,
                          child: Text(
                            'Stock Entry Type',
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
                          height: 30,
                          child: Text(
                            'Posting Date',
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
                          height: 30,
                          child: Text(
                            'Posting Time',
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
                        widget.stockEntryModelData.purchaseOrder != ''
                            ? Container(
                                height: 30,
                                child: Text(
                                  'Purchase Order',
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.purchaseOrder != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.workOrder != ''
                            ? Container(
                                height: 30,
                                child: Text(
                                  'Work Order',
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.workOrder != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.bomNo != ''
                            ? Container(
                                height: 30,
                                child: Text(
                                  'Bom No',
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.bomNo != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.forQuantity != 0
                            ? Container(
                                height: 30,
                                child: Text(
                                  'For Quantity',
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.forQuantity != 0
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultSourceWarehouse != ''
                            ? Container(
                                height: 40,
                                child: Text(
                                  'Source Warehouse',
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultSourceWarehouse != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultTargetWarehouse != ''
                            ? Container(
                                height: 40,
                                child: Text(
                                  'Target Warehouse',
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultTargetWarehouse != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        Container(
                          height: 30,
                          child: Text(
                            'Incoming Value',
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
                          height: 30,
                          child: Text(
                            'Outgoing Value',
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
                          height: 30,
                          child: Text(
                            'Value Difference',
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
                        height: 30,
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
                        height: 30,
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
                      widget.stockEntryModelData.purchaseOrder != ''
                          ? Container(
                              height: 30,
                              child: Text(
                                ':',
                                style: displayWidth(context) > 600
                                    ? TextStyle(
                                        fontSize: 28,
                                      )
                                    : TextStyle(fontSize: 16),
                              ),
                            )
                          : Container(),
                      widget.stockEntryModelData.purchaseOrder != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.workOrder != ''
                          ? Container(
                              height: 30,
                              child: Text(
                                ':',
                                style: displayWidth(context) > 600
                                    ? TextStyle(
                                        fontSize: 28,
                                      )
                                    : TextStyle(fontSize: 16),
                              ),
                            )
                          : Container(),
                      widget.stockEntryModelData.workOrder != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.bomNo != ''
                          ? Container(
                              height: 30,
                              child: Text(
                                ':',
                                style: displayWidth(context) > 600
                                    ? TextStyle(
                                        fontSize: 28,
                                      )
                                    : TextStyle(fontSize: 16),
                              ),
                            )
                          : Container(),
                      widget.stockEntryModelData.bomNo != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.forQuantity != 0
                          ? Container(
                              height: 30,
                              child: Text(
                                ':',
                                style: displayWidth(context) > 600
                                    ? TextStyle(
                                        fontSize: 28,
                                      )
                                    : TextStyle(fontSize: 16),
                              ),
                            )
                          : Container(),
                      widget.stockEntryModelData.forQuantity != 0
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.defaultSourceWarehouse != ''
                          ? Container(
                              height: 40,
                              child: Text(
                                ':',
                                style: displayWidth(context) > 600
                                    ? TextStyle(
                                        fontSize: 28,
                                      )
                                    : TextStyle(fontSize: 16),
                              ),
                            )
                          : Container(),
                      widget.stockEntryModelData.defaultSourceWarehouse != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      widget.stockEntryModelData.defaultTargetWarehouse != ''
                          ? Container(
                              height: 40,
                              child: Text(
                                ':',
                                style: displayWidth(context) > 600
                                    ? TextStyle(
                                        fontSize: 28,
                                      )
                                    : TextStyle(fontSize: 16),
                              ),
                            )
                          : Container(),
                      widget.stockEntryModelData.defaultTargetWarehouse != ''
                          ? SizedBox(
                              height: 10,
                            )
                          : Container(),
                      Container(
                        height: 30,
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
                        height: 30,
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
                        height: 30,
                        child: Text(
                          ':',
                          style: displayWidth(context) > 600
                              ? TextStyle(
                                  fontSize: 28,
                                )
                              : TextStyle(fontSize: 16),
                        ),
                      ),
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
                        Container(
                          height: 40,
                          child: Text(
                            widget.stockEntryModelData.stockEntryType,
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
                          height: 30,
                          child: Text(
                            widget.stockEntryModelData.postingDate,
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
                          height: 30,
                          child: Text(
                            widget.stockEntryModelData.postingTime,
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
                            widget.stockEntryModelData.company,
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
                        widget.stockEntryModelData.purchaseOrder != ''
                            ? Container(
                                height: 30,
                                child: Text(
                                  widget.stockEntryModelData.purchaseOrder,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.purchaseOrder != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.workOrder != ''
                            ? Container(
                                height: 30,
                                child: Text(
                                  widget.stockEntryModelData.workOrder,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.workOrder != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.bomNo != ''
                            ? Container(
                                height: 30,
                                child: Text(
                                  widget.stockEntryModelData.bomNo,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.bomNo != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.forQuantity != 0
                            ? Container(
                                height: 30,
                                child: Text(
                                  widget.stockEntryModelData.forQuantity
                                      .toString(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.forQuantity != 0
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultSourceWarehouse != ''
                            ? Container(
                                height: 40,
                                child: Text(
                                  widget.stockEntryModelData
                                      .defaultSourceWarehouse,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultSourceWarehouse != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultTargetWarehouse != ''
                            ? Container(
                                height: 40,
                                child: Text(
                                  widget.stockEntryModelData
                                      .defaultTargetWarehouse,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: displayWidth(context) > 600
                                      ? TextStyle(
                                          fontSize: 28,
                                        )
                                      : TextStyle(fontSize: 16),
                                ),
                              )
                            : Container(),
                        widget.stockEntryModelData.defaultTargetWarehouse != ''
                            ? SizedBox(
                                height: 10,
                              )
                            : Container(),
                        Container(
                          height: 30,
                          child: Text(
                            widget.stockEntryModelData.totalIncomingValue
                                .toString(),
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
                          height: 30,
                          child: Text(
                            widget.stockEntryModelData.totalOutgoingValue
                                .toString(),
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
                          height: 30,
                          child: Text(
                            widget.stockEntryModelData.totalValueDifference
                                .toString(),
                            maxLines: 3,
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
                        'Source Warehouse',
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
                        'Target Warehouse',
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
                        'Item Group',
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
                  ],
                  rows: list
                      .map((data) => DataRow(cells: <DataCell>[
                            DataCell(Text(
                              data.defaultSourceWarehouse,
                              style: displayWidth(context) > 600
                                  ? TextStyle(fontSize: 26, color: blackColor)
                                  : TextStyles.t16Black,
                            )),
                            DataCell(Text(
                              data.defaultTargetWarehouse,
                              style: displayWidth(context) > 600
                                  ? TextStyle(fontSize: 28, color: blackColor)
                                  : TextStyles.t16Black,
                            )),
                            DataCell(Text(
                              data.itemCode + ': ' + data.itemName,
                              style: displayWidth(context) > 600
                                  ? TextStyle(fontSize: 28, color: blackColor)
                                  : TextStyles.t16Black,
                            )),
                            DataCell(Text(
                              data.itemGroup,
                              style: displayWidth(context) > 600
                                  ? TextStyle(fontSize: 28, color: blackColor)
                                  : TextStyles.t16Black,
                            )),
                            DataCell(Center(
                              child: Text(
                                data.quantity.toString(),
                                style: displayWidth(context) > 600
                                    ? TextStyle(fontSize: 28, color: blackColor)
                                    : TextStyles.t16Black,
                              ),
                            )),
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
