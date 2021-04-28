import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/qualityinspection/model/quality_inspection_model.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:ebuzz/qualityinspection/ui/qiform1.dart';
import 'package:ebuzz/qualityinspection/ui/quality_inspection_detail_ui.dart';
import 'package:flutter/material.dart';

//QualityInspectionListUi class contains ui of list of quality inpsections
class QualityInspectionListUi extends StatefulWidget {
  @override
  _QualityInspectionListUiState createState() =>
      _QualityInspectionListUiState();
}

class _QualityInspectionListUiState extends State<QualityInspectionListUi> {
  List<QualityInspectionModel> _qualityInspectionList = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getQualityInspectionModelList();
  }

  getQualityInspectionModelList() async {
    setState(() {
      _loading = true;
    });
    _qualityInspectionList =
        await QualityInspectionService().getQualityInspectionModelList(context);
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
          title: 'Quality Inspection',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueAccent,
        onPressed: () {
          pushScreen(context, QiForm1());
        },
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
      body: _loading
          ? CircularProgress()
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: ListView.builder(
                itemCount: _qualityInspectionList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      pushScreen(
                        context,
                        QualityInspectionDetailUi(
                          qiData: _qualityInspectionList[index],
                        ),
                      );
                    },
                    child: QITileUi(
                      qiData: _qualityInspectionList[index],
                    ),
                  );
                },
              ),
            ),
    );
  }
}

//QITileUi class is a reusable widget which contains ui of list of quality inspection

class QITileUi extends StatelessWidget {
  final QualityInspectionModel qiData;
  const QITileUi({this.qiData});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context) * 0.99,
      height: 120,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      qiData.name,
                      style: TextStyles.t18Black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Report Date : ' + qiData.reportDate,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Inspection Type : ' + qiData.inspectionType,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Item Code : ' + qiData.itemCode,
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
                      color: qiData.status == 'Accepted'
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
