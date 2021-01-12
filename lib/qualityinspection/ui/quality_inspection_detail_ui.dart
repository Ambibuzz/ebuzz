import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/qualityinspection/model/quality_inspection_model.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:flutter/material.dart';

//QualityInspectionDetailUi class contains detail of particular quality inspection
class QualityInspectionDetailUi extends StatefulWidget {
  final QualityInspectionModel qiData;
  const QualityInspectionDetailUi({this.qiData});

  @override
  _QualityInspectionDetailUiState createState() =>
      _QualityInspectionDetailUiState();
}

class _QualityInspectionDetailUiState extends State<QualityInspectionDetailUi> {
  List<QualityInspectionReadings> _qiReadingsList = [];

  @override
  void initState() {
    super.initState();
    getQualityInspectionReadingList();
  }

  getQualityInspectionReadingList() async {
    _qiReadingsList = await QualityInspectionService()
        .getQualityInspectionReadingList(widget.qiData.name);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Quality Inspection',
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            QIDetailUiWidget(
              qiData: widget.qiData,
              qiReadingsList: _qiReadingsList,
            ),
          ],
        ),
      ),
    );
  }
}

//QIDetailUiWidget class is a reusable widget which contains detail of quality inspection
class QIDetailUiWidget extends StatelessWidget {
  final QualityInspectionModel qiData;
  final List<QualityInspectionReadings> qiReadingsList;

  const QIDetailUiWidget({this.qiData, this.qiReadingsList});
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      child: Text(
                        'Report Date',
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
                        'Inspection Type',
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
                        'Reference Type',
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
                        'Reference Name',
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
                        'Item Code',
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
                        'Item Name',
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
                        'Sample Size',
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
                        'Inspected By',
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
                        'Quality Inspection Template',
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
                        'Remarks',
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
                        'Description',
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
                        qiData.reportDate,
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
                        qiData.inspectionType,
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
                        qiData.referenceType,
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
                        qiData.referenceName,
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
                        qiData.itemCode,
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
                        qiData.itemname,
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
                        qiData.sampleSize.toString(),
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
                        qiData.inspectedBy,
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
                        qiData.qualityInspectionTemplate,
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
                        qiData.status,
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
                        qiData.remarks,
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
                      width: displayWidth(context) * 0.5,
                      child: Text(
                        qiData.description,
                        maxLines: 10,
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
                  'Parameter',
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
                  'Acceptance Criteria',
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
                  'Reading 1',
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
                  'Status',
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 32,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)
                      : TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: qiReadingsList
                .map((data) => DataRow(cells: <DataCell>[
                      DataCell(Text(
                        data.parameter,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 26, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Text(
                        data.acceptanceCriteria,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 28, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Text(
                        data.reading1,
                        style: displayWidth(context) > 600
                            ? TextStyle(fontSize: 28, color: blackColor)
                            : TextStyles.t16Black,
                      )),
                      DataCell(Center(
                        child: Text(
                          data.status,
                          style: displayWidth(context) > 600
                              ? TextStyle(fontSize: 28, color: blackColor)
                              : TextStyles.t16Black,
                        ),
                      )),
                    ]))
                .toList(),
          ),
        ),
      ],
    );
  }
}
