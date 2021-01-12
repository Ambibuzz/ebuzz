import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:ebuzz/qualityinspection/ui/qiform2.dart';
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

  String inspectionType;
  String referenceType;
  String date = DateTime.now().day.toString();
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();
  bool loading = false;
  GlobalKey<AutoCompleteTextFieldState<String>> referenceNameKey = GlobalKey();

  var _formKey = GlobalKey<FormState>();

  String username = '';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) if (!mounted) return;
    setState(() {
      selectedDate = picked;
      dateController.text = DateFormat('d-M-y').format(picked).toString();
    });
  }

  @override
  void initState() {
    super.initState();
    dateController.text = '$date-$month-$year';
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
        child: CustomAppBar(
          title: 'Quality Inspection Form',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueAccent,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            if ((inspectionType != null || inspectionType != '') &&
                (referenceType != null || referenceType != '')) {
              pushScreen(
                context,
                QiForm2(
                  date: dateController.text,
                  inspectionType: inspectionType,
                  referenceType: referenceType,
                ),
              );
            } else if (inspectionType == null || inspectionType == '') {
              fluttertoast(whiteColor, blueAccent,
                  'Inspection Type should not be empty');
            } else if (referenceType == null || referenceType == '') {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    dateField(),
                    SizedBox(
                      height: 20,
                    ),
                    inspectionTypeField(),
                    SizedBox(
                      height: 20,
                    ),
                    referenceTypeField(),
                    SizedBox(
                      height: 13,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget dateField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextFormField(
            key: Key('date-field-form1'),
            keyboardType: TextInputType.datetime,
            controller: dateController,
            validator: (value) {
              if (value.length == 0 || value == '') {
                return 'Date should not be empty';
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () => _selectDate(context),
                child: Icon(
                  Icons.date_range,
                  color: blackColor,
                  size: 25,
                ),
              ),
              labelText: 'Date',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: blackColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inspectionTypeField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        key: Key('inspection-type-field-form1'),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Inspection Type'),
              value: inspectionType,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  inspectionType = newValue;
                });
              },
              items: <String>[
                "Incoming",
                "Outgoing",
                "In Process",
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

  Widget referenceTypeField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        key: Key('reference-type-field-form1'),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1)),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              hint: Text('Reference Type'),
              value: referenceType,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String newValue) async {
                setState(() {
                  referenceType = newValue;
                });
              },
              items: <String>[
                "Purchase Receipt",
                "Purchase Invoice",
                "Delivery Note",
                "Sales Invoice",
                "Stock Entry",
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
}
