import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/ui_reusable_widget.dart';
import 'package:ebuzz/qualityinspection/model/quality_inspection_model.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:flutter/material.dart';

//QualityInspectionDetailUi class contains detail of particular quality inspection
class QualityInspectionDetailUi extends StatefulWidget {
  final QualityInspectionModel qiData;
  const QualityInspectionDetailUi({required this.qiData});

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
        .getQualityInspectionReadingList(widget.qiData.name!, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title:
                Text('Quality Inspection', style: TextStyle(color: whiteColor)),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
            ),
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

  const QIDetailUiWidget({required this.qiData, required this.qiReadingsList});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.all(16.0),
          child: Column(
            children: [
              qualityInspectionDetailWidget('Report Date', qiData.reportDate),
              SizedBox(height: 15),
              qualityInspectionDetailWidget(
                  'Inspection Type', qiData.inspectionType),
              SizedBox(height: 15),
              qualityInspectionDetailWidget(
                  'Reference Type', qiData.referenceType),
              SizedBox(height: 15),
              qualityInspectionDetailWidget(
                  'Reference Name', qiData.referenceName),
              SizedBox(height: 15),
              qualityInspectionDetailWidget('Item Code', qiData.itemCode),
              SizedBox(height: 15),
              qualityInspectionDetailWidget('Item Name', qiData.itemname),
              SizedBox(height: 15),
              qualityInspectionDetailWidget(
                  'Sample Size', qiData.sampleSize.toString()),
              SizedBox(height: 15),
              qualityInspectionDetailWidget('Inspected By', qiData.inspectedBy),
              SizedBox(height: 15),
              qualityInspectionDetailWidget('Quality Inspection Template',
                  qiData.qualityInspectionTemplate),
              SizedBox(height: 15),
              qualityInspectionDetailWidget('Status', qiData.status),
              SizedBox(height: 15),
              qualityInspectionDetailWidget('Remarks', qiData.remarks),
              SizedBox(height: 15),
              qualityInspectionDetailWidget('Description', qiData.description),
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
              tableColumnText(context, 'Parameter'),
              tableColumnText(context, 'Acceptance Criteria'),
              tableColumnText(context, 'Reading 1'),
              tableColumnText(context, 'Status'),
            ],
            rows: qiReadingsList
                .map((data) => DataRow(cells: <DataCell>[
                      dataCellText(context, data.parameter!,
                          displayWidth(context) * 0.5),
                      dataCellText(context, data.acceptanceCriteria!,
                          displayWidth(context) * 0.7),
                      dataCellText(
                          context, data.reading1!, displayWidth(context) * 0.7),
                      dataCellText(
                          context, data.status!, displayWidth(context) * 0.2),
                    ]))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget qualityInspectionDetailWidget(String label, String? value) {
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
