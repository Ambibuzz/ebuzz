import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/qualityinspection/service/quality_inspection_service.dart';
import 'package:ebuzz/qualityinspection/ui/qiform4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//Quality Inspection form 3
class QiForm3 extends StatefulWidget {
  final String date;
  final String referenceType;
  final String inspectionType;
  final String referenceName;

  QiForm3(
      {this.date, this.referenceType, this.inspectionType, this.referenceName});
  @override
  _QiForm3State createState() => _QiForm3State();
}

class _QiForm3State extends State<QiForm3> {
  TextEditingController itemCodeController = TextEditingController();
  bool loading = false;
  List<String> listItemCode = [];
  GlobalKey<AutoCompleteTextFieldState<String>> itemCodeKey = GlobalKey();
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
      listItemCode = await QualityInspectionService()
          .getPurchaseRecieptData(widget.referenceName);
      setState(() {});
    }
    if (widget.referenceType == 'Purchase Invoice') {
      listItemCode = await QualityInspectionService()
          .getPurchaseInvoiceData(widget.referenceName);
      if (!mounted) return;
      setState(() {});
    }
    if (widget.referenceType == 'Delivery Note') {
      listItemCode = await QualityInspectionService()
          .getDeliveryNoteData(widget.referenceName);
      if (!mounted) return;
      setState(() {});
    }
    if (widget.referenceType == 'Sales Invoice') {
      listItemCode = await QualityInspectionService()
          .getSalesInvoiceData(widget.referenceName);
      if (!mounted) return;
      setState(() {});
    }
    if (widget.referenceType == 'Stock Entry') {
      listItemCode = await QualityInspectionService()
          .getStockEntryData(widget.referenceName);
      if (!mounted) return;
      setState(() {});
    }
    setState(() {
      loading = false;
    });
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    itemNameField(),
                  ],
                ),
              ),
            ),
    );
  }

  List<String> _getSuggestions(String query, List<String> list) {
    List<String> matches = List();
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Widget itemNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TypeAheadFormField(
        key: Key('item-name-field-form3'),
                        hideSuggestionsOnKeyboardHide: false,

        textFieldConfiguration: TextFieldConfiguration(
          controller: itemCodeController,
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
            labelText: 'Item Name',
          ),
        ),
        onSuggestionSelected: (suggestion) {
          itemCodeController.text = suggestion;
        },
        itemBuilder: (context, item) {
          return itemUi(item);
        },
        suggestionsCallback: (pattern) {
          return _getSuggestions(pattern, listItemCode);
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        validator: (val) => val.isEmpty ? 'Please enter itemcode...' : null,
      ),
    );
  }
}
