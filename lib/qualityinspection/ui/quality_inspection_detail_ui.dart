import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';
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
        .getQualityInspectionReadingList(widget.qiData.name,context);
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
                    textFieldName(context, 'Report Date'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Inspection Type'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Reference Type'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Reference Name'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Item Code'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Item Name'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Sample Size'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Inspected By'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Quality Inspection Template'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Status'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Remarks'),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, 'Description'),
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
                    textFieldName(context, qiData.inspectionType),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.referenceType),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.referenceName),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.itemCode),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.itemname),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.sampleSize.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.inspectedBy),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.qualityInspectionTemplate),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.status),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.remarks),
                    SizedBox(
                      height: 10,
                    ),
                    textFieldName(context, qiData.description),
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
              tableColumnText(context, 'Parameter'),
              tableColumnText(context, 'Acceptance Criteria'),
              tableColumnText(context, 'Reading 1'),
              tableColumnText(context, 'Status'),
            ],
            rows: qiReadingsList
                .map((data) => DataRow(cells: <DataCell>[
                      dataCellText(context, data.parameter),
                      dataCellText(context, data.acceptanceCriteria),
                      dataCellText(context, data.reading1),
                      dataCellText(context, data.status),
                    ]))
                .toList(),
          ),
        ),
      ],
    );
  }
}
