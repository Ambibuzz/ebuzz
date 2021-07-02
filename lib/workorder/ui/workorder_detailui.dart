import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:ebuzz/workorder/model/workorder_model.dart';
import 'package:ebuzz/workorder/service/workorder_service.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';

//WorkOrderDetailUi consist of detail of particular workorder

class WorkOrderDetailUi extends StatefulWidget {
  final WorkOrderModel workOrderData;
  const WorkOrderDetailUi({required this.workOrderData});
  @override
  _WorkOrderDetailUiState createState() => _WorkOrderDetailUiState();
}

class _WorkOrderDetailUiState extends State<WorkOrderDetailUi> {
  List<WorkOrderItems> _workOrderItemsList = [];
  @override
  void initState() {
    super.initState();
    getWorkOrderItemListData();
  }

  getWorkOrderItemListData() async {
    _workOrderItemsList = await WorkOrderService()
        .getWorkOrderItemList(widget.workOrderData.name!, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppBar(
            title:
                Text('Work Order Detail', style: TextStyle(color: whiteColor)),
            leading: IconButton(
              onPressed: () => Navigator.pop(context, false),
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
            ),
          )),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: versionText(),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      workOrderDetailWidget(
                          'Company', widget.workOrderData.company),
                      SizedBox(height: 15),
                      workOrderDetailWidget('Item to Manufacture',
                          widget.workOrderData.productionItem),
                      SizedBox(height: 15),
                      workOrderDetailWidget(
                          'Item Name', widget.workOrderData.itemName),
                      SizedBox(height: 15),
                      workOrderDetailWidget(
                          'Bom no', widget.workOrderData.bomNo),
                      SizedBox(height: 15),
                      workOrderDetailWidget('Quantity to Manufacture',
                          widget.workOrderData.qtyToManufacture.toString()),
                      SizedBox(height: 15),
                      workOrderDetailWidget(
                          'Material Transfered for Manufacturing',
                          widget.workOrderData.materialTransfForManuf
                              .toString()),
                      SizedBox(height: 15),
                      workOrderDetailWidget('Manufactured Quantity',
                          widget.workOrderData.manufacturedQty.toString()),
                      SizedBox(height: 15),
                      workOrderDetailWidget(
                          'Status', widget.workOrderData.status),
                      SizedBox(height: 15),
                      workOrderDetailWidget(
                          'Start Date', widget.workOrderData.plannedStartDate),
                      SizedBox(height: 15),
                      workOrderDetailWidget('Delivery Date',
                          widget.workOrderData.expectedDeliveryDate),
                      SizedBox(height: 15),
                      workOrderDetailWidget('Target Warehouse',
                          widget.workOrderData.targetWarehouse),
                      SizedBox(height: 15),
                      workOrderDetailWidget('Work in Progress Warehouse',
                          widget.workOrderData.workInProgressWarehouse),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                Column(
                  children: [
                    scrollToViewTableBelow(context),
                    SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: <DataColumn>[
                          tableColumnText(context, 'Item Code'),
                          tableColumnText(context, 'Source Warehouse'),
                          tableColumnText(context, 'Required Quantity'),
                          tableColumnText(context, 'Transfered Quantity'),
                          tableColumnText(context, 'Consumed Quantity'),
                        ],
                        rows: _workOrderItemsList
                            .map((data) => DataRow(cells: <DataCell>[
                                  dataCellText(
                                      context,
                                      data.itemCode ??
                                          '' + ': ' + data.itemName!,
                                      displayWidth(context) * 0.5),
                                  dataCellText(
                                      context,
                                      data.sourceWarehouse ?? '',
                                      displayWidth(context) * 0.7),
                                  dataCellText(
                                      context,
                                      data.requiredQty.toString(),
                                      displayWidth(context) * 0.3),
                                  dataCellText(
                                      context,
                                      data.transferedQuantity.toString(),
                                      displayWidth(context) * 0.3),
                                  dataCellText(
                                      context,
                                      data.consumedQuantity.toString(),
                                      displayWidth(context) * 0.3),
                                ]))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget workOrderDetailWidget(String label, String? value) {
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
