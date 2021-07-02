import 'dart:io';

import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/qualityinspection/model/quality_inspection_model.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:ebuzz/widgets/custom_card.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:flutter/material.dart';

List<QualityInspectionReadings> qir = [];

//Quality Inspection form 5
class QiForm5 extends StatefulWidget {
  final String date;
  final String referenceType;
  final String inspectionType;
  final String referenceName;
  final String itemCode;
  final String itemName;
  final double sampleSize;
  final String qiTemplate;
  final String status;

  QiForm5(
      {required this.date,
      required this.referenceType,
      required this.inspectionType,
      required this.referenceName,
      required this.itemCode,
      required this.itemName,
      required this.sampleSize,
      required this.qiTemplate,
      required this.status});
  @override
  _QiForm5State createState() => _QiForm5State();
}

class _QiForm5State extends State<QiForm5> {
  bool loading = false;
  bool _postButtonDisabled = false;
  String username = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    // qir = await QualityInspectionService()
    //     .getQIReadingsList('RM189_Chilli powder Hot_QC_Template');
    qir = await QualityInspectionService()
        .getQIReadingsList(widget.qiTemplate, context);
    username = await CommonService().getUsername(context);
    setState(() {});
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: blueAccent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(right: 10, top: 0),
            child: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: whiteColor,
              size: 25,
            ),
          ),
        ),
        elevation: Platform.isAndroid ? 1 : 0,
        centerTitle: Platform.isAndroid ? false : true,
        title: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Text(
            'Quality Inspection Form',
            style: TextStyle(color: whiteColor, fontSize: 20),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: whiteColor, width: 1),
                  borderRadius: BorderRadius.circular(5)),
              child: RoundButton(
                onPressed: _postButtonDisabled ? null : save,
                child: Text('Save',
                    style: TextStyle(fontSize: 16, color: whiteColor)),
                onPrimaryColor: whiteColor,
                primaryColor: _postButtonDisabled ? greyColor : blueAccent,
              ),
            ),
          )
        ],
      ),
      body: loading
          ? CircularProgress()
          : Form(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 8),
                    child: Column(
                      children: [
                        qualityInspectionDetailWidget(
                            'Quality Inspection Template', widget.qiTemplate),
                      ],
                    ),
                  ),
                  qir.length == 0
                      ? Container(
                          height: displayHeight(context) * 0.75,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Readings is empty'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Click Save button to save form')
                            ],
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: qir.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final item = qir[index];
                                return Column(
                                  children: [
                                    QIReadingsForm(
                                      key: ObjectKey(item),
                                      qir: item,
                                      i: index,
                                      onDelete: () => onDelete(index),
                                    ),
                                  ],
                                );
                              }),
                        ),
                ],
              ),
            ),
    );
  }

  Widget save() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          child: RoundButton(
            onPressed: _postButtonDisabled ? null : save,
            child:
                Text('Save', style: TextStyle(fontSize: 16, color: whiteColor)),
            onPrimaryColor: whiteColor,
            primaryColor: _postButtonDisabled ? greyColor : blueAccent,
          ),
        ),
      ),
    );
  }

  onSave() async {
    QualityInspectionModel qualityInspectionModel = QualityInspectionModel(
      docstatus: 0,
      inspectionType: widget.inspectionType,
      itemCode: widget.itemCode,
      itemname: widget.itemName,
      inspectedBy: username,
      qiReadings: qir,
      qualityInspectionTemplate: widget.qiTemplate,
      referenceName: widget.referenceName,
      referenceType: widget.referenceType,
      reportDate: widget.date,
      sampleSize: widget.sampleSize,
      status: widget.status,
    );
    if (!mounted) return;
    setState(() {
      _postButtonDisabled = true;
    });
    await QualityInspectionService().post(qualityInspectionModel, context);
    if (!mounted) return;
    setState(() {
      _postButtonDisabled = false;
    });
  }

  void onDelete(int index) {
    qir.removeAt(index);
    if (!mounted) return;
    setState(() {});
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

typedef OnDelete();

class QIReadingsForm extends StatefulWidget {
  final QualityInspectionReadings qir;
  final OnDelete onDelete;
  final int i;

  QIReadingsForm(
      {required Key key,
      required this.qir,
      required this.onDelete,
      required this.i})
      : super(key: key);
  @override
  _QIReadingsFormState createState() => _QIReadingsFormState();
}

class _QIReadingsFormState extends State<QIReadingsForm>
    with AutomaticKeepAliveClientMixin {
  String status = 'Rejected';
  late TextEditingController parameterController;
  late TextEditingController acceptanceCriteriaController;
  late TextEditingController reading1Controller;
  late TextEditingController reading2Controller;
  late TextEditingController reading3Controller;
  late TextEditingController reading4Controller;
  late TextEditingController reading5Controller;
  late TextEditingController reading6Controller;
  bool statusValue = false;
  int count = 0;

  @override
  void initState() {
    super.initState();
    parameterController = TextEditingController();
    acceptanceCriteriaController = TextEditingController();
    reading1Controller = TextEditingController();
    reading2Controller = TextEditingController();
    reading3Controller = TextEditingController();
    reading4Controller = TextEditingController();
    reading5Controller = TextEditingController();
    reading6Controller = TextEditingController();
    parameterController.text = widget.qir.parameter!;
    acceptanceCriteriaController.text = widget.qir.acceptanceCriteria!;
    qir[widget.i].status = 'Rejected';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomCard(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                parameterField(),
                SizedBox(height: 5),
                acceptanceCriteriaField(),
                SizedBox(height: 5),
                Text('Status'),
                statusCheckBox(),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: reading1()),
                    SizedBox(width: 3),
                    Expanded(child: reading2()),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: reading3()),
                    SizedBox(width: 3),
                    Expanded(child: reading4()),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(child: reading5()),
                    SizedBox(width: 3),
                    Expanded(child: reading6()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget acceptanceCriteriaField() {
    return CustomTextFormField(
      controller: acceptanceCriteriaController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      onChanged: (value) {
        if (!mounted) return;
        setState(() {
          qir[widget.i].acceptanceCriteria = value;
        });
      },
      label: 'Acceptance Criteria',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  Widget parameterField() {
    return CustomTextFormField(
      controller: parameterController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      onChanged: (value) {
        if (!mounted) return;
        setState(() {
          qir[widget.i].parameter = value;
        });
      },
      label: 'Parameter',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  Widget statusCheckBox() {
    return Checkbox(
      checkColor: whiteColor,
      activeColor: blueAccent,
      value: this.statusValue,
      onChanged: (bool? value) {
        setState(() {
          this.statusValue = value!;
        });
        if (value == true) {
          setState(() {
            qir[widget.i].status = 'Accepted';
          });
        }
        if (value == false) {
          setState(() {
            qir[widget.i].status = 'Rejected';
          });
        }
      },
    );
  }

  Widget reading1() {
    return CustomTextFormField(
      controller: reading1Controller,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      onChanged: (value) {
        if (value != '') {
          qir[widget.i].reading1 = value;
          if (!mounted) return;
          setState(() {});
        }
      },
      label: 'Reading 1',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  Widget reading2() {
    return CustomTextFormField(
      controller: reading2Controller,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      onChanged: (value) {
        if (value != '') {
          qir[widget.i].reading2 = value;
          if (!mounted) return;
          setState(() {});
        }
      },
      label: 'Reading 2',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  Widget reading3() {
    return CustomTextFormField(
      controller: reading3Controller,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      onChanged: (value) {
        if (value != '') {
          qir[widget.i].reading3 = value;
          if (!mounted) return;
          setState(() {});
        }
      },
      label: 'Reading 3',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  Widget reading4() {
    return CustomTextFormField(
      controller: reading4Controller,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      onChanged: (value) {
        if (value != '') {
          qir[widget.i].reading4 = value;
          if (!mounted) return;
          setState(() {});
        }
      },
      label: 'Reading 4',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  Widget reading5() {
    return CustomTextFormField(
      controller: reading5Controller,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      onChanged: (value) {
        if (value != '') {
          qir[widget.i].reading5 = value;
          if (!mounted) return;
          setState(() {});
        }
      },
      label: 'Reading 5',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  Widget reading6() {
    return CustomTextFormField(
      controller: reading6Controller,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      onChanged: (value) {
        if (value != '') {
          qir[widget.i].reading6 = value;
          if (!mounted) return;
          setState(() {});
        }
      },
      label: 'Reading 6',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
