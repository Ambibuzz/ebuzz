import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/salesorder/service/sales_order_service.dart';
import 'package:ebuzz/salesorder/ui/sales_order_form2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

class SalesOrderForm1 extends StatefulWidget {
  @override
  _SalesOrderForm1State createState() => _SalesOrderForm1State();
}

class _SalesOrderForm1State extends State<SalesOrderForm1> {
  DateTime selectedDate = DateTime.now();
  String ordertype;
  String portOfDischarge;
  List<String> companyList = [];
  List<String> customerList = [];
  List<String> warehouseList = [];

  TextEditingController dateController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController warehouseController = TextEditingController();
  TextEditingController purchaseOrderController = TextEditingController();

  bool loading = false;
  GlobalKey<AutoCompleteTextFieldState<String>> companyKey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> customerKey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> warehouseKey = GlobalKey();

  String date = DateTime.now().day.toString();
  String month = DateTime.now().month.toString();
  String year = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();
    getCustomerAndCompanyList();
    dateController.text = '$year-$month-$date';
  }

  getCustomerAndCompanyList() async {
    companyList = await SalesOrderService().getCompanyList();
    customerList = await SalesOrderService().getCustomerList();
    print(customerList.length);
    print(companyList.length);
    setState(() {});
  }

  getWarehouseList(String company) async {
    warehouseList = await SalesOrderService().getWarehouseList(company);
    print(warehouseList.length);
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

  List<String> _getSuggestions(String query, List<String> list) {
    List<String> matches = List();
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) if (!mounted) return;
    setState(() {
      selectedDate = picked;
      dateController.text = DateFormat('y-M-d').format(picked).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'Sales Order Form',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blueAccent,
        onPressed: () {
          if (customerController.text.isNotEmpty &&
              companyController.text.isNotEmpty &&
              dateController.text.isNotEmpty) {
            pushScreen(
                context,
                SalesOrderForm2(
                  company: companyController.text,
                  customer: customerController.text,
                  date: dateController.text,
                  purchaseorder: purchaseOrderController.text,
                  warehouse: warehouseController.text,
                  orderType: ordertype,
                  portOfDischarge: portOfDischarge,
                ));
          }
        },
        child: Icon(
          Icons.arrow_forward,
          color: whiteColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            dateField(),
            companyField(),
            customerField(),
            orderTypeField(),
            purchaseOrderField(),
            warehouseField(),
            portOfDischargeField(),
          ],
        ),
      ),
    );
  }

  Widget dateField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: TextFormField(
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

  Widget companyField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TypeAheadFormField(
        key: Key('company-field'),
        hideSuggestionsOnKeyboardHide: false,
        textFieldConfiguration: TextFieldConfiguration(
          controller: companyController,
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
            labelText: 'Company',
          ),
        ),
        onSuggestionSelected: (suggestion) {
          companyController.text = suggestion;
          //after selecting company fetch warehuselist
          getWarehouseList(companyController.text);
        },
        itemBuilder: (context, item) {
          return itemUi(item);
        },
        suggestionsCallback: (pattern) {
          return _getSuggestions(pattern, companyList);
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        validator: (val) => val.isEmpty ? 'Please enter company name...' : null,
      ),
    );
  }

  Widget customerField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TypeAheadFormField(
        key: Key('customer-field'),
        hideSuggestionsOnKeyboardHide: false,
        textFieldConfiguration: TextFieldConfiguration(
          controller: customerController,
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
            labelText: 'Customer',
          ),
        ),
        onSuggestionSelected: (suggestion) {
          customerController.text = suggestion;
        },
        itemBuilder: (context, item) {
          return itemUi(item);
        },
        suggestionsCallback: (pattern) {
          return _getSuggestions(pattern, customerList);
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        validator: (val) =>
            val.isEmpty ? 'Please enter customer name...' : null,
      ),
    );
  }

  Widget warehouseField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TypeAheadFormField(
        key: Key('warehouse-field'),
        hideSuggestionsOnKeyboardHide: false,
        textFieldConfiguration: TextFieldConfiguration(
          controller: warehouseController,
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
            labelText: 'Warehouse Name',
          ),
        ),
        onSuggestionSelected: (suggestion) {
          warehouseController.text = suggestion;
        },
        itemBuilder: (context, item) {
          return itemUi(item);
        },
        suggestionsCallback: (pattern) {
          return _getSuggestions(pattern, warehouseList);
        },
        transitionBuilder: (context, suggestionsBox, controller) {
          return suggestionsBox;
        },
        validator: (val) =>
            val.isEmpty ? 'Please enter warehouse name...' : null,
      ),
    );
  }

  Widget orderTypeField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        key: Key('order-type-field'),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1)),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              hint: Text('Order Type'),
              value: ordertype,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String newValue) async {
                setState(() {
                  ordertype = newValue;
                });
              },
              items: <String>[
                "Sales",
                "Maintenance",
                "Shopping Cart",
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

  Widget portOfDischargeField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        key: Key('port-of-discharge-field'),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey, width: 1)),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton<String>(
              hint: Text('Port Of Discharge'),
              value: portOfDischarge,
              icon: Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.blueAccent,
              ),
              onChanged: (String newValue) async {
                setState(() {
                  portOfDischarge = newValue;
                });
              },
              items: <String>[
                "Yokohama, Japan",
                "Tokyo, Japan",
                "Nagoya, Japan",
                "Kobe, Japan",
                "Oakland, California, USA",
                "Narita, Japan",
                "Botswana",
                "Sydney, Australia",
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

  Widget purchaseOrderField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextFormField(
        key: Key('purchase-order-field'),
        controller: purchaseOrderController,
        style: displayWidth(context) > 600
            ? TextStyle(fontSize: 28, color: blackColor)
            : TextStyles.t16Black,
        decoration: InputDecoration(
            labelStyle: TextStyle(
              fontSize: displayWidth(context) > 600 ? 28 : 16,
            ),
            contentPadding: EdgeInsets.symmetric(
                vertical: displayWidth(context) > 600
                    ? 30
                    : displayWidth(context) < 380
                        ? 15
                        : 20,
                horizontal: displayWidth(context) > 600 ? 20 : 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: blackColor, width: 1),
            ),
            labelText: 'Customer Purchase Order'),
      ),
    );
  }
}
