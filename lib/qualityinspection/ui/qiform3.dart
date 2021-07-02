import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/qualityinspection/ui/qiform4.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:ebuzz/widgets/custom_typeahead_formfield.dart';
import 'package:ebuzz/widgets/typeahead_widgets.dart';
import 'package:flutter/material.dart';

//Quality Inspection form 3
class QiForm3 extends StatefulWidget {
  final String date;
  final String referenceType;
  final String inspectionType;
  final String referenceName;

  QiForm3(
      {required this.date,
      required this.referenceType,
      required this.inspectionType,
      required this.referenceName});
  @override
  _QiForm3State createState() => _QiForm3State();
}

class _QiForm3State extends State<QiForm3> {
  TextEditingController itemCodeController = TextEditingController();
  bool loading = false;
  List<String> listItemCode = [];
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fetchItemCode();
  }

  fetchItemCode() async {
    setState(() {
      loading = true;
    });
    if (widget.referenceType == 'Purchase Receipt') {
      listItemCode = await CommonService()
          .getPurchaseRecieptListFromReference(widget.referenceName, context);
      setState(() {});
    }
    if (widget.referenceType == 'Purchase Invoice') {
      listItemCode = await CommonService()
          .getPurchaseInvoiceListFromReference(widget.referenceName, context);
      if (!mounted) return;
      setState(() {});
    }
    if (widget.referenceType == 'Delivery Note') {
      listItemCode = await CommonService()
          .getDeliveryNoteListFromRefernce(widget.referenceName, context);
      if (!mounted) return;
      setState(() {});
    }
    if (widget.referenceType == 'Sales Invoice') {
      listItemCode = await CommonService()
          .getSalesInvoiceList(widget.referenceName, context);
      if (!mounted) return;
      setState(() {});
    }
    if (widget.referenceType == 'Stock Entry') {
      listItemCode = await CommonService()
          .getStockEntryListFromReference(widget.referenceName, context);
      if (!mounted) return;
      setState(() {});
    }
    setState(() {
      loading = false;
    });
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
          if (itemCodeController.text.isNotEmpty)
            pushScreen(
                context,
                QiForm4(
                  date: widget.date,
                  inspectionType: widget.inspectionType,
                  referenceName: widget.referenceName,
                  referenceType: widget.referenceType,
                  itemCode: itemCodeController.text,
                ));
          else
            fluttertoast(
                whiteColor, blueAccent, 'Item Name should not be empty');
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
                      itemNameField(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget itemNameField() {
    return CustomTypeAheadFormField(
      controller: itemCodeController,
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
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item);
      },
      onSuggestionSelected: (suggestion) async {
        itemCodeController.text = suggestion;
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, listItemCode);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
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
