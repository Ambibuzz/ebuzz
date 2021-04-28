import 'dart:io';

import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/qualityinspection/model/quality_inspection_model.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
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
      {this.date,
      this.referenceType,
      this.inspectionType,
      this.referenceName,
      this.itemCode,
      this.itemName,
      this.sampleSize,
      this.qiTemplate,
      this.status});
  @override
  _QiForm5State createState() => _QiForm5State();
}

class _QiForm5State extends State<QiForm5> {
  bool loading = false;
  bool _postButtonDisabled = false;
  String username;

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
    qir = await QualityInspectionService().getQIReadingsList(widget.qiTemplate,context);
    username = await QualityInspectionService().getUsername(context);
    setState(() {});
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueAccent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: EdgeInsets.only(
                right: 10, top: displayWidth(context) > 600 ? 20 : 0),
            child: Icon(
              Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
              color: whiteColor,
              size: displayWidth(context) > 600 ? 35 : 25,
            ),
          ),
        ),
        elevation: Platform.isAndroid ? 1 : 0,
        centerTitle: Platform.isAndroid ? false : true,
        title: Padding(
          padding: EdgeInsets.only(top: displayWidth(context) > 600 ? 20 : 0),
          child: Text(
            'Quality Inspection Form',
            style: TextStyle(
                color: whiteColor,
                fontSize: displayWidth(context) > 600 ? 30 : 20),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: whiteColor, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: RoundButton(
                onPressed: _postButtonDisabled ? null : save,
                child: Text('Save', style: TextStyles.t16WhiteBold),
                onPrimaryColor: whiteColor,
                primaryColor: _postButtonDisabled ? greyColor : blueAccent,
              ),
              //  RaisedButton(
              //   color: _postButtonDisabled ? greyColor : blueAccent,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   onPressed: _postButtonDisabled ? null : onSave,
              //   child: Text(
              //     'Save',
              //     style: TextStyle(color: whiteColor, fontSize: 16),
              //   ),
              // ),
            ),
          )
        ],
      ),
      body: loading
          ? CircularProgress()
          : Form(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                                height: 30,
                                child: Text(
                                  'QI Template',
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
                          width: displayWidth(context) * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 30,
                                child: Text(
                                  widget.qiTemplate,
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
            child: Text('Save', style: TextStyles.t16WhiteBold),
            onPrimaryColor: whiteColor,
            primaryColor: _postButtonDisabled ? greyColor : blueAccent,
          ),
          //  RaisedButton(
          //   color: _postButtonDisabled ? greyColor : blueAccent,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   onPressed: _postButtonDisabled ? null : onSave,
          //   child: Text(
          //     'Save',
          //     style: TextStyles.t16White,
          //   ),
          // ),
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
    await QualityInspectionService().post(qualityInspectionModel,context);
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
}

typedef OnDelete();

class QIReadingsForm extends StatefulWidget {
  final QualityInspectionReadings qir;
  final OnDelete onDelete;
  final int i;

  QIReadingsForm({Key key, this.qir, this.onDelete, this.i}) : super(key: key);
  @override
  _QIReadingsFormState createState() => _QIReadingsFormState();
}

class _QIReadingsFormState extends State<QIReadingsForm> {
  String status = 'Rejected';
  TextEditingController parameterController;
  TextEditingController acceptanceCriteriaController;
  TextEditingController reading1Controller;
  TextEditingController reading2Controller;
  TextEditingController reading3Controller;
  TextEditingController reading4Controller;
  TextEditingController reading5Controller;
  TextEditingController reading6Controller;
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
    parameterController.text = widget.qir.parameter;
    acceptanceCriteriaController.text = widget.qir.acceptanceCriteria;
    qir[widget.i].status = 'Rejected';
  }

  // addReading() {
  //   setState(() {
  //     count++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // List<Widget> widgetList = [];

    // for (var i = 1; i <= count; ++i) {
    //   widgetList.add(Reading(
    //     c: i,
    //     index: widget.i,
    //   ));
    // }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: displayWidth(context) * 0.25,
                  child: TextFormField(
                    controller: parameterController,
                    decoration: InputDecoration(
                      hintText: 'Parameter',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        qir[widget.i].parameter = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: displayWidth(context) * 0.25,
                  child: TextFormField(
                    controller: acceptanceCriteriaController,
                    decoration: InputDecoration(
                      hintText: 'Acceptance Criteria',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        qir[widget.i].acceptanceCriteria = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Checkbox(
                  checkColor: whiteColor,
                  activeColor: blueAccent,
                  value: this.statusValue,
                  onChanged: (bool value) {
                    setState(() {
                      this.statusValue = value;
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
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: displayWidth(context) * 0.24,
                  child: TextFormField(
                    controller: reading1Controller,
                    decoration: InputDecoration(
                      hintText: 'Reading 1',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        qir[widget.i].reading1 = value;
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: displayWidth(context) * 0.24,
                  child: TextFormField(
                    controller: reading2Controller,
                    decoration: InputDecoration(
                      hintText: 'Reading 2',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        qir[widget.i].reading2 = value;
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: displayWidth(context) * 0.24,
                  child: TextFormField(
                    controller: reading3Controller,
                    decoration: InputDecoration(
                      hintText: 'Reading 3',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        qir[widget.i].reading3 = value;
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: displayWidth(context) * 0.24,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Reading 4',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        qir[widget.i].reading4 = value;
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: displayWidth(context) * 0.24,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Reading 5',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        qir[widget.i].reading5 = value;
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: displayWidth(context) * 0.24,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Reading 6',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        qir[widget.i].reading6 = value;
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class Reading extends StatefulWidget {
//   final int c;
//   final int index;

//   Reading({this.c, this.index});
//   @override
//   _ReadingState createState() => _ReadingState();
// }

// class _ReadingState extends State<Reading> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TextFormField(
//           decoration: InputDecoration(
//             hintText: 'Reading ${widget.c}',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           onChanged: (value) {
//             if (widget.c == 1) {
//               setState(() {
//                 qir[widget.index].reading1 = value;
//               });
//             }
//             if (widget.c == 2) {
//               setState(() {
//                 qir[widget.index].reading2 = value;
//               });
//             }
//             if (widget.c == 3) {
//               setState(() {
//                 qir[widget.index].reading3 = value;
//               });
//             }
//             if (widget.c == 4) {
//               setState(() {
//                 qir[widget.index].reading4 = value;
//               });
//             }
//             if (widget.c == 5) {
//               setState(() {
//                 qir[widget.index].reading5 = value;
//               });
//             }
//             if (widget.c == 6) {
//               setState(() {
//                 qir[widget.index].reading6 = value;
//               });
//             }
//           },
//         ),
//         SizedBox(
//           height: 5,
//         ),
//       ],
//     );
//   }
// }
