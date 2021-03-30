import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:ebuzz/qualityinspection/ui/qiform3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//Quality Inspection form 2
class QiForm2 extends StatefulWidget {
  final String date;
  final String referenceType;
  final String inspectionType;

  QiForm2({this.date, this.referenceType, this.inspectionType});
  @override
  _QiForm2State createState() => _QiForm2State();
}

class _QiForm2State extends State<QiForm2> {
  TextEditingController referenceNameController = TextEditingController();
  bool loading = false;
  GlobalKey<AutoCompleteTextFieldState<String>> referenceNameKey = GlobalKey();

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

  Widget itemUi(String item) {
    return ListTile(
      title: Text(item,
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyle(color: greyDarkColor, fontSize: 16)),
    );
  }

  getData() async {
    if (!mounted) return;
    setState(() {
      loading = true;
    });
    if (widget.referenceType == 'Purchase Receipt') {
      list = await QualityInspectionService().getPurchaseRecieptStringList();
    }
    if (widget.referenceType == 'Purchase Invoice') {
      list = await QualityInspectionService().getPurchaseInvoiceStringList();
    }
    if (widget.referenceType == 'Delivery Note') {
      list = await QualityInspectionService().getDeliveryNoteStringList();
    }
    if (widget.referenceType == 'Sales Invoice') {
      list = await QualityInspectionService().getSalesInvoiceStringList();
    }
    if (widget.referenceType == 'Stock Entry') {
      list = await QualityInspectionService().getStockEntryStringList();
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
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'Quality Inspection Form',
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  referenceNameField(),
                ],
              ),
            ),
    );
  }

  List<String> _getSuggestionsReferenceName(String query) {
    List<String> matches = [];
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Widget referenceNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TypeAheadFormField(
        key: Key('reference-name-field-form2'),
                        hideSuggestionsOnKeyboardHide: false,

        textFieldConfiguration: TextFieldConfiguration(
          controller: referenceNameController,
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyle(color: blackColor, fontSize: 18),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: blackColor, width: 1, style: BorderStyle.solid),
            ),
            labelStyle: TextStyle(
              fontSize: displayWidth(context) > 600 ? 28 : 16,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: displayWidth(context) > 600 ? 30 : 20,
                horizontal: displayWidth(context) > 600 ? 20 : 10),
            labelText: 'Reference Name',
          ),
        ),
        onSuggestionSelected: (suggestion) {
          referenceNameController.text = suggestion;
        },
        itemBuilder: (context, item) {
          return itemUi(item);
        },
        suggestionsCallback: (pattern) {
          return _getSuggestionsReferenceName(pattern);
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        validator: (val) =>
            val.isEmpty ? 'Please enter reference name...' : null,
      ),
    );
  }
}
