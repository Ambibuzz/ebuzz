import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/salesorder/ui/sales_order_form2.dart';
import 'package:ebuzz/widgets/custom_dropdown.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:ebuzz/widgets/custom_typeahead_formfield.dart';
import 'package:ebuzz/widgets/typeahead_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesOrderForm1 extends StatefulWidget {
  @override
  _SalesOrderForm1State createState() => _SalesOrderForm1State();
}

class _SalesOrderForm1State extends State<SalesOrderForm1> {
  DateTime selectedDate = DateTime.now();
  String ordertype = 'Sales';
  String portOfDischarge = 'Yokohama, Japan';
  List<String> portList = [
    'Yokohama, Japan',
    'Tokyo, Japan',
    'Nagoya, Japan',
    'Kobe, Japan',
    'Oakland, California, USA',
    'Narita, Japan',
    'Botswana',
    'Sydney, Australia'
  ];
  List<String> orderTypeList = [
    'Sales',
    'Maintenance',
    'Shopping Cart',
  ];
  List<String> companyList = [];
  List<String> customerList = [];
  List<String> warehouseList = [];

  TextEditingController dateController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController warehouseController = TextEditingController();
  TextEditingController purchaseOrderController = TextEditingController();

  bool loading = false;

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
    companyList = await CommonService().getCompanyList(context);
    customerList = await CommonService().getCustomerList(context);
    print(customerList.length);
    print(companyList.length);
    setState(() {});
  }

  getWarehouseList(String company) async {
    warehouseList =
        await CommonService().getWarehouseList(company, context);
    print(warehouseList.length);
    setState(() {});
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) if (!mounted) return;
    setState(() {
      selectedDate = picked!;
      dateController.text = DateFormat('y-M-d').format(picked).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: Text('Sales Order Form', style: TextStyle(color: whiteColor)),
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
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              dateField(),
              SizedBox(height: 15),
              companyField(),
              SizedBox(height: 15),
              customerField(),
              SizedBox(height: 15),
              orderTypeField(),
              SizedBox(height: 15),
              purchaseOrderField(),
              SizedBox(height: 15),
              warehouseField(),
              SizedBox(height: 15),
              portOfDischargeField(),
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

  Widget companyField() {
    return CustomTypeAheadFormField(
      controller: companyController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Company',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item);
      },
      onSuggestionSelected: (suggestion) async {
        companyController.text = suggestion;
        //after selecting company fetch warehuselist
        getWarehouseList(companyController.text);
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, companyList);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (val) =>
          val == '' || val == null ? 'Company name should not be empty' : null,
    );
  }

  Widget customerField() {
    return CustomTypeAheadFormField(
      controller: customerController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Customer',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item);
      },
      onSuggestionSelected: (suggestion) async {
        customerController.text = suggestion;
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, customerList);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (val) =>
          val == '' || val == null ? 'Customer name should not be empty' : null,
    );
  }

  Widget warehouseField() {
    return CustomTypeAheadFormField(
      controller: warehouseController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Warehouse',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item);
      },
      onSuggestionSelected: (suggestion) async {
        warehouseController.text = suggestion;
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, warehouseList);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (val) => val == '' || val == null
          ? 'Warehouse name should not be empty'
          : null,
    );
  }

  Widget orderTypeField() {
    return CustomDropDown(
      value: ordertype,
      decoration: BoxDecoration(
          color: greyColor, borderRadius: BorderRadius.circular(5)),
      items: orderTypeList.map<DropdownMenuItem<String>>((value) {
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
          ordertype = newValue!;
        });
      },
      label: 'Order Type',
      labelStyle: TextStyle(fontSize: 14),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    );
  }

  Widget portOfDischargeField() {
    return CustomDropDown(
      value: portOfDischarge,
      decoration: BoxDecoration(
          color: greyColor, borderRadius: BorderRadius.circular(5)),
      items: portList.map<DropdownMenuItem<String>>((value) {
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
          portOfDischarge = newValue!;
        });
      },
      label: 'Port Of Discharge',
      labelStyle: TextStyle(fontSize: 14),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    );
  }

  Widget purchaseOrderField() {
    return CustomTextFormField(
      controller: purchaseOrderController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Customer Purchase Order',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }
}
