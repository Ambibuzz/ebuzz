import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/workorder/model/workorder_model.dart';
import 'package:ebuzz/workorder/service/workorder_service.dart';
import 'package:flutter/material.dart';

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
        .getWorkOrderItemList(widget.workOrderData.name);
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
                        'Item to Manufacture',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Item Name',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Bom No',
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
                        'Qty to Manufacture',
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
                        'Material Transfered for Manufacturing',
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
                        'Manufactured Quantity',
                        style: displayWidth(context) > 600
                            ? TextStyle(
                                fontSize: 28,
                              )
                            : TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Sales Order',
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
                        'Start Date',
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
                        'Target Warehouse',
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
                        'Work in progress Warehouse',
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
                    height: 20,
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
                    height: 20,
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
                        workOrderModelData.company,
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
                        workOrderModelData.productionItem +
                            ' : ' +
                            workOrderModelData.itemName,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        workOrderModelData.itemName,
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
                      height: 15,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        workOrderModelData.bomNo,
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
                        workOrderModelData.qtyToManufacture.toString(),
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
                        workOrderModelData.materialTransfForManuf.toString(),
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
                        workOrderModelData.manufacturedQty.toString(),
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
                        workOrderModelData.salesOrder,
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
                        workOrderModelData.status,
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
                        workOrderModelData.plannedStartDate,
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
                        workOrderModelData.expectedDeliveryDate,
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
                        workOrderModelData.targetWarehouse,
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
                        workOrderModelData.workInProgressWarehouse,
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

        //WorkOrderItem list data displayed in tabular form

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
                    'Source Warehouse',
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
                    'Required Quantity',
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
                    'Transfered Quantity',
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
                    'Consumed Quantity',
                    style: displayWidth(context) > 600
                        ? TextStyle(
                            fontSize: 32,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)
                        : TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: workOrderItemsList
                  .map((data) => DataRow(cells: <DataCell>[
                        DataCell(Text(
                          data.itemCode + ': ' + data.itemName,
                          style: displayWidth(context) > 600
                              ? TextStyle(fontSize: 26, color: blackColor)
                              : TextStyles.t16Black,
                        )),
                        DataCell(Text(
                          data.sourceWarehouse,
                          style: displayWidth(context) > 600
                              ? TextStyle(fontSize: 28, color: blackColor)
                              : TextStyles.t16Black,
                        )),
                        DataCell(Center(
                          child: Text(
                            data.requiredQty.toString(),
                            style: displayWidth(context) > 600
                                ? TextStyle(fontSize: 28, color: blackColor)
                                : TextStyles.t16Black,
                          ),
                        )),
                        DataCell(Center(
                          child: Text(
                            data.transferedQuantity.toString(),
                            style: displayWidth(context) > 600
                                ? TextStyle(fontSize: 28, color: blackColor)
                                : TextStyles.t16Black,
                          ),
                        )),
                        DataCell(Center(
                          child: Text(
                            data.consumedQuantity.toString(),
                            style: displayWidth(context) > 600
                                ? TextStyle(fontSize: 28, color: blackColor)
                                : TextStyles.t16Black,
                          ),
                        )),
                      ]))
                  .toList()),
        ),
      ],
    );
  }
}
