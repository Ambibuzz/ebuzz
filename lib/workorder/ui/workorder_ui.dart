import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/workorder/model/workorder_model.dart';
import 'package:ebuzz/workorder/service/workorder_service.dart';
import 'package:ebuzz/workorder/ui/workorder_detailui.dart';
import 'package:flutter/material.dart';

//WorkOrderUi consist of ui of list of work orders
class WorkOrderUi extends StatefulWidget {
  @override
  _WorkOrderUiState createState() => _WorkOrderUiState();
}

class _WorkOrderUiState extends State<WorkOrderUi> {
  List<WorkOrderModel> _workOrderModelList = [];
  //loading variable is used for displaying circular progress indicator
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getWorkOrderListData();
  }

  getWorkOrderListData() async {
    setState(() {
      _loading = true;
    });
    _workOrderModelList = await WorkOrderService().getWorkOrderModelList();
    setState(() {});
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Work Order',
          )),
      body:
          //display circular progress indicator when loading is true else display ui
          _loading
              ? CircularProgress()
              : Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ListView.builder(
                    itemCount: _workOrderModelList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          pushScreen(
                              context,
                              WorkOrderDetailUi(
                                workOrderData: _workOrderModelList[index],
                              ));
                        },
                        child: WorkTileUi(
                          workorderData: _workOrderModelList[index],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}

class WorkTileUi extends StatelessWidget {
  final WorkOrderModel workorderData;

  const WorkTileUi({this.workorderData});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.99,
      height: 100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workorderData.productionItem,
                      style: TextStyles.t20Black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: displayWidth(context) * 0.85,
                      child: Text(
                        workorderData.itemName,
                        maxLines: 3,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Expected Date : ' + workorderData.expectedDeliveryDate,
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: displayWidth(context) > 600 ? 30 : 15,
                  height: displayWidth(context) > 600 ? 30 : 15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: workorderData.status == 'Completed'
                          ? greenColor
                          : blackColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
