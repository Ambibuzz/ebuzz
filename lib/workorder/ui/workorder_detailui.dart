import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/workorder/model/workorder_model.dart';
import 'package:ebuzz/workorder/service/workorder_service.dart';
import 'package:flutter/material.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';

//WorkOrderDetailUi consist of detail of particular workorder

class WorkOrderDetailUi extends StatefulWidget {
  final WorkOrderModel workOrderData;
  const WorkOrderDetailUi({this.workOrderData});
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
        .getWorkOrderItemList(widget.workOrderData.name,context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Work Order',
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WODetailUiWidget(
              workOrderModelData: widget.workOrderData,
              workOrderItemsList: _workOrderItemsList,
            ),
          ],
        ),
      ),
    );
  }
}

// WODetailUiWidget consist of data of work order

class WODetailUiWidget extends StatelessWidget {
  final WorkOrderModel workOrderModelData;
  final List<WorkOrderItems> workOrderItemsList;
  WODetailUiWidget({this.workOrderModelData, this.workOrderItemsList});
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
                    textFieldName(context, 'Company'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Item to Manufacture'),
                    SizedBox(
                      height: 15,
                    ),
                    textFieldName(context, 'Item Name'),
                    SizedBox(
                      height: 20,
                    ),
                    textFieldName(context, 'Bom No'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Qty to Manufacture'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(
                        context, 'Material Transfered for Manufacturing'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Manufactured Quantity'),
                    SizedBox(
                      height: 15,
                    ),
                    textFieldName(context, 'Sales Order'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Status'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Start Date'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Delivery Date'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Target Warehouse'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Work in progress Warehouse'),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
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
                    height: 20,
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
                    textFieldName(context, workOrderModelData.company),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(
                        context,
                        workOrderModelData.productionItem +
                            ' : ' +
                            workOrderModelData.itemName),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, workOrderModelData.itemName),
                    SizedBox(
                      height: 15,
                    ),
                    textFieldName(context, workOrderModelData.bomNo),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context,
                        workOrderModelData.qtyToManufacture.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context,
                        workOrderModelData.materialTransfForManuf.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(
                        context, workOrderModelData.manufacturedQty.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, workOrderModelData.salesOrder),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, workOrderModelData.status),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, workOrderModelData.plannedStartDate),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(
                        context, workOrderModelData.expectedDeliveryDate),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, workOrderModelData.targetWarehouse),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(
                        context, workOrderModelData.workInProgressWarehouse),
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
        //WorkOrderItem list data displayed in tabular form

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
              rows: workOrderItemsList
                  .map((data) => DataRow(cells: <DataCell>[
                        dataCellText(
                            context, data.itemCode + ': ' + data.itemName),
                        dataCellText(context, data.sourceWarehouse),
                        dataCellText(context, data.requiredQty.toString()),
                        dataCellText(
                            context, data.transferedQuantity.toString()),
                        dataCellText(
                            context, data.transferedQuantity.toString()),
                      ]))
                  .toList()),
        ),
      ],
    );
  }
}
