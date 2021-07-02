import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/qualityinspection/ui/qiform3.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:ebuzz/widgets/custom_typeahead_formfield.dart';
import 'package:ebuzz/widgets/typeahead_widgets.dart';
import 'package:flutter/material.dart';

//Quality Inspection form 2
class QiForm2 extends StatefulWidget {
  final String date;
  final String referenceType;
  final String inspectionType;

  QiForm2(
      {required this.date,
      required this.referenceType,
      required this.inspectionType});
  @override
  _QiForm2State createState() => _QiForm2State();
}

class _QiForm2State extends State<QiForm2> {
  TextEditingController referenceNameController = TextEditingController();
  bool loading = false;

  String username = '';
  List<String> purchaseRecieptList = [];
  List<String> purchaseInvoiceList = [];
  List<String> stockEntryList = [];
  List<String> salesInvoiceList = [];
  List<String> deliveryNoteList = [];
  List<String> list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    if (widget.referenceType == 'Purchase Receipt') {
      list = await CommonService().getPurchaseRecieptSubmittedList(context);
    }
    if (widget.referenceType == 'Purchase Invoice') {
      list = await CommonService().getPurchaseInvoiceSubmittedList(context);
    }
    if (widget.referenceType == 'Delivery Note') {
      list = await CommonService().getDeliveryNoteSubmittedList(context);
    }
    if (widget.referenceType == 'Sales Invoice') {
      list = await CommonService().getSalesInvoiceSubmittedList(context);
    }
    if (widget.referenceType == 'Stock Entry') {
      list = await CommonService().getStockEntrySubmittedList(context);
    }
    if (!mounted) return;
    setState(() {
      loading = false;
    });
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,
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
          if (referenceNameController.text.isNotEmpty)
            pushScreen(
                context,
                QiForm3(
                  date: widget.date,
                  inspectionType: widget.inspectionType,
                  referenceName: referenceNameController.text,
                  referenceType: widget.referenceType,
                ));
          else
            fluttertoast(
                whiteColor, blueAccent, 'Reference Name should not be empty');
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
                    referenceNameField(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget referenceNameField() {
    return CustomTypeAheadFormField(
      controller: referenceNameController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Reference Name',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item);
      },
      onSuggestionSelected: (suggestion) async {
        referenceNameController.text = suggestion;
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, list);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (val) => val == '' || val == null
          ? 'Reference name should not be empty'
          : null,
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
