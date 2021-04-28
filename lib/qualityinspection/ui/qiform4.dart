import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/item/model/product.dart';
import 'package:ebuzz/item/service/item_api_service.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:ebuzz/qualityinspection/ui/qiform5.dart';
import 'package:flutter/material.dart';

//Quality Inspection form 4
class QiForm4 extends StatefulWidget {
  final String date;
  final String referenceType;
  final String inspectionType;
  final String referenceName;
  final String itemCode;

  QiForm4(
      {this.date,
      this.referenceType,
      this.inspectionType,
      this.itemCode,
      this.referenceName});
  @override
  _QiForm4State createState() => _QiForm4State();
}

class _QiForm4State extends State<QiForm4> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController qualityInspectionTemplateController =
      TextEditingController();
  TextEditingController sampleSizeController = TextEditingController();
  bool loading = false;

  String status;
  String qitemplate;
  String itemCode;

  @override
  void initState() {
    super.initState();
    fetchItem();
  }

  fetchItem() async {
    setState(() {
      loading = true;
    });
    Product item;
    itemCode = await ItemApiService().getItemCodeFromItemName(widget.itemCode,context);
    item = await ItemApiService().getData(itemCode,context);
    qitemplate = await QualityInspectionService().getQITemplate(itemCode,context);
    qualityInspectionTemplateController.text = qitemplate;
    itemNameController.text = item.itemName;
    sampleSizeController.text = item.sampleSize.toString();
    setState(() {
      loading = false;
    });
    setState(() {});
  }

  Widget itemUi(String item) {
    return ListTile(
      title: Text(item,
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyle(color: greyDarkColor, fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(title: 'Quality Inspection Form'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueAccent,
        onPressed: () {
          if (status != null)
            pushScreen(
                context,
                QiForm5(
                  date: widget.date,
                  inspectionType: widget.inspectionType,
                  referenceName: widget.referenceName,
                  referenceType: widget.referenceType,
                  itemCode: itemCode,
                  itemName: itemNameController.text,
                  qiTemplate: qualityInspectionTemplateController.text,
                  sampleSize: double.parse(sampleSizeController.text),
                  status: status,
                ));
          else
            fluttertoast(whiteColor, blueAccent, 'Status should not be empty');
        },
        child: Icon(
          Icons.arrow_forward,
          color: whiteColor,
        ),
      ),
      body: loading
          ? CircularProgress()
          : SingleChildScrollView(
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
                                height: 30,
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
                                height: 30,
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
                                height: 30,
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
                                height: 30,
                                child: Text(
                                  'Item Code',
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
                            SizedBox(
                              height: 10,
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
                            SizedBox(
                              height: 10,
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
                            SizedBox(
                              height: 10,
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
                            SizedBox(
                              height: 10,
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
                                  widget.date,
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
                                height: 30,
                                child: Text(
                                  widget.inspectionType,
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
                                height: 30,
                                child: Text(
                                  widget.referenceType,
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
                                height: 30,
                                child: Text(
                                  widget.referenceName,
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
                                height: 30,
                                child: Text(
                                  itemCode,
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
                    height: 13,
                  ),
                  itemNameField(),
                  SizedBox(
                    height: 13,
                  ),
                  qualityInspectionTemplateField(),
                  SizedBox(
                    height: 13,
                  ),
                  Row(
                    children: [
                      Expanded(child: sampleSizeField()),
                      statusField(),
                    ],
                  ),
                  SizedBox(
                    height: 13,
                  ),
                ],
              ),
            ),
    );
  }

  Widget statusField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        key: Key('status-field-form4'),
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Status'),
              value: status,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  status = newValue;
                });
              },
              items: <String>[
                "Accepted",
                "Rejected",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget sampleSizeField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        key: Key('sample-size-field-form4'),
        controller: sampleSizeController,
        validator: (value) {
          if (value.length == 0 || value == '') {
            return 'Sample Size should not be empty';
          }
          return null;
        },
        style: displayWidth(context) > 600
            ? TextStyle(fontSize: 28, color: blackColor)
            : TextStyles.t16Black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: blackColor,
                width: displayWidth(context) > 600 ? 3 : 1,
                style: BorderStyle.solid),
          ),
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600 ? 30 : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          labelText: 'Sample Size',
        ),
      ),
    );
  }

  Widget qualityInspectionTemplateField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        key: Key('quality-inspection-template-field-form4'),
        controller: qualityInspectionTemplateController,
        style: displayWidth(context) > 600
            ? TextStyle(fontSize: 28, color: blackColor)
            : TextStyles.t16Black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: blackColor,
                width: displayWidth(context) > 600 ? 3 : 1,
                style: BorderStyle.solid),
          ),
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600 ? 30 : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          labelText: 'Quality Inspection Template',
        ),
      ),
    );
  }

  Widget itemNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        key: Key('item-name-field-form4'),
        controller: itemNameController,
        validator: (value) {
          if (value.length == 0 || value == '') {
            return 'Item Name should not be empty';
          }
          return null;
        },
        style: displayWidth(context) > 600
            ? TextStyle(fontSize: 28, color: blackColor)
            : TextStyles.t16Black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: blackColor,
                width: displayWidth(context) > 600 ? 3 : 1,
                style: BorderStyle.solid),
          ),
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600 ? 30 : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          labelText: 'Item Name',
        ),
      ),
    );
  }
}
