import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/qualityinspection/ui/qiform2.dart';
import 'package:ebuzz/widgets/custom_dropdown.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Quality Inspection form 1
class QiForm1 extends StatefulWidget {
  @override
  _QiForm1State createState() => _QiForm1State();
}

class _QiForm1State extends State<QiForm1> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  TextEditingController inspectionTypeController = TextEditingController();
  TextEditingController referenceTypeController = TextEditingController();

  String inspectionType = 'Incoming';
  String referenceType = 'Purchase Receipt';
  List<String> inspectionTypeList = [
    'Incoming',
    'Outgoing',
    'In Process',
  ];
  List<String> referenceTypeList = [
    'Purchase Receipt',
    'Purchase Invoice',
    'Delivery Note',
    'Sales Invoice',
    'Stock Entry',
  ];
  String date = DateTime.now().day.toString();
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();
  bool loading = false;
  var _formKey = GlobalKey<FormState>();

  String username = '';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) if (!mounted) return;
    setState(() {
      selectedDate = picked!;
      dateController.text = DateFormat('d-M-y').format(picked).toString();
    });
  }

  @override
  void initState() {
    super.initState();
    dateController.text = '$date-$month-$year';
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
          if (_formKey.currentState!.validate()) {
            if ((inspectionType.isNotEmpty) && (referenceType.isNotEmpty)) {
              pushScreen(
                context,
                QiForm2(
                  date: dateController.text,
                  inspectionType: inspectionType,
                  referenceType: referenceType,
                ),
              );
            } else if (inspectionType.isEmpty) {
              fluttertoast(whiteColor, blueAccent,
                  'Inspection Type should not be empty');
            } else if (referenceType.isEmpty) {
              fluttertoast(
                  whiteColor, blueAccent, 'Reference Type should not be empty');
            } else {}
          }
        },
        child: Icon(
          Icons.arrow_forward,
          color: whiteColor,
        ),
      ),
      body: loading
          ? CircularProgress()
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dateField(),
                      SizedBox(height: 15),
                      inspectionTypeField(),
                      SizedBox(height: 15),
                      referenceTypeField(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget dateField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: CustomTextFormField(
          controller: dateController,
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
              fillColor: greyColor,
              filled: true,
              isDense: true,
              suffixIcon: GestureDetector(
                onTap: () => _selectDate(context),
                child: Icon(
                  Icons.date_range,
                  color: blackColor,
                  size: 25,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5),
              )),
          label: 'Date',
          labelStyle: TextStyle(color: blackColor),
          style: TextStyle(fontSize: 14, color: blackColor),
          validator: (val) =>
              val == '' || val == null ? 'Date should not be empty' : null,
        ),
      ),
    );
  }

  Widget inspectionTypeField() {
    return CustomDropDown(
      value: inspectionType,
      decoration: BoxDecoration(
          color: greyColor, borderRadius: BorderRadius.circular(5)),
      items: inspectionTypeList.map<DropdownMenuItem<String>>((value) {
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
          inspectionType = newValue!;
        });
      },
      label: 'Inspection Type',
      labelStyle: TextStyle(fontSize: 14),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    );
  }

  Widget referenceTypeField() {
    return CustomDropDown(
      value: referenceType,
      decoration: BoxDecoration(
          color: greyColor, borderRadius: BorderRadius.circular(5)),
      items: referenceTypeList.map<DropdownMenuItem<String>>((value) {
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
          referenceType = newValue!;
        });
      },
      label: 'Reference Type',
      labelStyle: TextStyle(fontSize: 14),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    );
  }
}
