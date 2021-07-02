import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common_models/product.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/item/service/item_api_service.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:ebuzz/qualityinspection/ui/qiform5.dart';
import 'package:ebuzz/widgets/custom_dropdown.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:flutter/material.dart';

//Quality Inspection form 4
class QiForm4 extends StatefulWidget {
  final String date;
  final String referenceType;
  final String inspectionType;
  final String referenceName;
  final String itemCode;

  QiForm4(
      {required this.date,
      required this.referenceType,
      required this.inspectionType,
      required this.itemCode,
      required this.referenceName});
  @override
  _QiForm4State createState() => _QiForm4State();
}

class _QiForm4State extends State<QiForm4> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController qualityInspectionTemplateController =
      TextEditingController();
  TextEditingController sampleSizeController = TextEditingController();
  bool loading = false;

  String status = 'Accepted';
  String qitemplate = '';
  String itemCode = '';
  List<String> statusList = [
    'Accepted',
    'Rejected',
  ];

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
    itemCode =
        await CommonService().getItemCodeFromItemName(widget.itemCode, context);
    item = await ItemApiService().getData(itemCode, context);
    qitemplate =
        await QualityInspectionService().getQITemplate(itemCode, context);
    qualityInspectionTemplateController.text = qitemplate;
    itemNameController.text = item.itemName!;
    sampleSizeController.text = item.sampleSize.toString();
    setState(() {
      loading = false;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title: Text('Quality Inspection Form',
              style: TextStyle(color: whiteColor)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueAccent,
        onPressed: () {
          if (status.isNotEmpty)
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
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    qualityInspectionDetailWidget('Report Date', widget.date),
                    SizedBox(height: 15),
                    qualityInspectionDetailWidget(
                        'Inspection Type', widget.inspectionType),
                    SizedBox(height: 15),
                    qualityInspectionDetailWidget(
                        'Reference Type', widget.referenceType),
                    SizedBox(height: 15),
                    qualityInspectionDetailWidget(
                        'Reference Name', widget.referenceName),
                    SizedBox(height: 15),
                    qualityInspectionDetailWidget('Item Code', itemCode),
                    SizedBox(height: 15),
                    itemNameField(),
                    SizedBox(height: 15),
                    qualityInspectionTemplateField(),
                    SizedBox(height: 15),
                    sampleSizeField(),
                    SizedBox(height: 15),
                    statusField(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget statusField() {
    return CustomDropDown(
      value: status,
      decoration: BoxDecoration(
          color: greyColor, borderRadius: BorderRadius.circular(5)),
      items: statusList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value.toString(),
            style: TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
      alignment: CrossAxisAlignment.start,
      onChanged: (String? newValue) {
        setState(() {
          status = newValue!;
        });
      },
      label: 'Status',
      labelStyle: TextStyle(fontSize: 14),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    );
  }

  Widget sampleSizeField() {
    return CustomTextFormField(
      controller: sampleSizeController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Sample Size',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 14, color: blackColor),
      validator: (val) =>
          val == '' || val == null ? 'Sample size should not be empty' : null,
    );
  }

  Widget qualityInspectionTemplateField() {
    return CustomTextFormField(
      controller: qualityInspectionTemplateController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Quality Inspection Template',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  Widget itemNameField() {
    return CustomTextFormField(
      controller: itemNameController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Item Name',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
      validator: (val) =>
          val == '' || val == null ? 'Item Name should not be empty' : null,
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
