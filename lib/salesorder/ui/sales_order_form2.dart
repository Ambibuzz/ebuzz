import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/item/model/product.dart';
import 'package:ebuzz/item/service/item_api_service.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/salesorder/model/sales_order.dart';
import 'package:ebuzz/salesorder/service/sales_order_service.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

List<SalesOrderItems> soilist = [];
List<String> itemCodeList = [];

class SalesOrderForm2 extends StatefulWidget {
  final String date;
  final String company;
  final String customer;
  final String warehouse;
  final String purchaseorder;
  final String portOfDischarge;
  final String orderType;
  SalesOrderForm2(
      {this.date,
      this.company,
      this.customer,
      this.warehouse,
      this.purchaseorder,
      this.portOfDischarge,
      this.orderType});
  @override
  _SalesOrderForm2State createState() => _SalesOrderForm2State();
}

class _SalesOrderForm2State extends State<SalesOrderForm2> {
  bool _postButtonDisabled = false;
  // double total;
  // double totalQuantity;
  @override
  void initState() {
    super.initState();
    getItemList();
    print(widget.date);
    print(widget.company);
    print(widget.customer);
    print(widget.warehouse);
    print(widget.purchaseorder);
  }

  getItemList() async {
    try {
      List listData = await ItemApiService().getItemList(context);
      for (int i = 0; i < listData.length; i++) {
        itemCodeList.add(listData[i]['item_code']);
      }
      print(itemCodeList.length);
    } catch (e) {
      throw Exception(e.toString());
    }
    setState(() {});
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
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'Add Button',
            backgroundColor: blueAccent,
            onPressed: () {
              soilist.add(SalesOrderItems(
                  amount: 0,
                  deliverydate: '',
                  itemcode: '',
                  itemname: '',
                  qty: 0,
                  rate: 0));
              setState(() {});
            },
            child: Icon(
              Icons.add,
              color: whiteColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          FloatingActionButton(
            heroTag: 'Next Button',
            backgroundColor: _postButtonDisabled ? greyColor : blueAccent,
            onPressed: _postButtonDisabled ? null : onSave,
            child: Icon(
              Icons.save,
              color: whiteColor,
            ),
          ),
        ],
      ),
      body: soilist.length == 0
          ? Center(
              child: Text(
              'List is empty',
              style: TextStyles.t18Black,
            ))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: soilist.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = soilist[index];
                        return Column(
                          children: [
                            SOItemsForm(
                              key: ObjectKey(item),
                              soi: item,
                              i: index,
                              onDelete: () => onDelete(index),
                            ),
                          ],
                        );
                      }),
                ),
                soilist.length >= 8
                    ? SizedBox(
                        height: 120,
                      )
                    : Container()
              ],
            ),
    );
  }

  onSave() async {
    // total = 0.0;
    // totalQuantity = 0;
    // for (int i = 0; i < soilist.length; i++) {
    //   total += soilist[i].amount;
    //   totalQuantity += soilist[i].qty;
    // }
    // print(total);
    // print(totalQuantity);

    SalesOrder salesOrderModel = SalesOrder(
      docstatus: 0,
      company: widget.company,
      customer: widget.customer,
      deliverydate: widget.date,
      setwarehouse: widget.warehouse,
      salesOrderItems: soilist,
      // basegrandtotal: total,
      // totalqty: totalQuantity,
      // totalnetweight: totalQuantity,
    );
    print(salesOrderModel);
    if (!mounted) return;
    setState(() {
      _postButtonDisabled = true;
    });
    await SalesOrderService().post(salesOrderModel,context);
    if (!mounted) return;
    setState(() {
      _postButtonDisabled = false;
    });
  }

  void onDelete(int index) {
    soilist.removeAt(index);
    if (!mounted) return;
    setState(() {});
  }
}

typedef OnDelete();

class SOItemsForm extends StatefulWidget {
  final SalesOrderItems soi;
  final OnDelete onDelete;
  final int i;

  SOItemsForm({Key key, this.soi, this.onDelete, this.i}) : super(key: key);
  @override
  _SOItemsFormState createState() => _SOItemsFormState();
}

class _SOItemsFormState extends State<SOItemsForm> {
  TextEditingController itemcodeController;
  // TextEditingController itemnameController;
  // TextEditingController amountController;
  // TextEditingController rateController;
  TextEditingController quantityController;
  TextEditingController deliveryDateController;
  int count = 0;
  Product product = Product();
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    itemcodeController = TextEditingController();
    // itemnameController = TextEditingController();
    // amountController = TextEditingController();
    // rateController = TextEditingController();
    quantityController = TextEditingController();
    deliveryDateController = TextEditingController();
  }

  Widget itemUi(String item) {
    return ListTile(
      title: Text(item,
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyle(color: greyDarkColor, fontSize: 16)),
    );
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
      deliveryDateController.text =
          DateFormat('y-M-d').format(picked).toString();
      soilist[widget.i].deliverydate =
          DateFormat('y-M-d').format(picked).toString();
    });
  }

  List<String> _getSuggestions(String query, List<String> list) {
    List<String> matches = [];
    matches.addAll(list);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  setItemData(String itemCode, int index) async {
    product = await getData(itemCode);
    // rateController.text = product.valuationRate.toString();
    quantityController.text = 1.0.toString();
    soilist[index].rate = double.parse(product.valuationRate.toString());
    soilist[index].qty = 1.0;
    soilist[index].amount = soilist[index].rate * soilist[index].qty;
    // amountController.text = soilist[index].amount.toString();
    setState(() {});
  }

  //For fetching data from item api in product model
  Future<Product> getData(String text) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();

      final String url = itemDataUrl(text);
      final response = await _dio.get(
        url,
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e,context);
    }
    return Product();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Container(
                //   width: displayWidth(context) * 0.25,
                //   child: TextFormField(
                //     controller: itemcodeController,
                //     decoration: InputDecoration(
                //       hintText: 'ItemCode',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onChanged: (value) {
                //       if (!mounted) return;
                //       setState(() {
                //         soilist[widget.i].itemcode = value;
                //       });
                //     },
                //   ),
                // ),
                Container(
                  width: displayWidth(context) * 0.3,
                  child: TypeAheadFormField(
                    key: Key('item-code-field'),
                    hideSuggestionsOnKeyboardHide: false,
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: itemcodeController,
                      style: displayWidth(context) > 600
                          ? TextStyle(fontSize: 28, color: blackColor)
                          : TextStyle(color: blackColor, fontSize: 18),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: blackColor,
                              width: 1,
                              style: BorderStyle.solid),
                        ),
                        labelStyle: TextStyle(
                          fontSize: displayWidth(context) > 600 ? 28 : 16,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: displayWidth(context) > 600 ? 30 : 20,
                            horizontal: displayWidth(context) > 600 ? 20 : 10),
                        hintText: 'Item Code',
                      ),
                    ),
                    onSuggestionSelected: (suggestion) {
                      itemcodeController.text = suggestion;
                      setItemData(suggestion, widget.i);
                      if (!mounted) return;
                      setState(() {
                        soilist[widget.i].itemcode = suggestion;
                      });
                    },
                    itemBuilder: (context, item) {
                      return itemUi(item);
                    },
                    suggestionsCallback: (pattern) {
                      return _getSuggestions(pattern, itemCodeList);
                    },
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    validator: (val) =>
                        val.isEmpty ? 'Please enter item code...' : null,
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                // Container(
                //   width: displayWidth(context) * 0.25,
                //   child: TextFormField(
                //     controller: itemnameController,
                //     decoration: InputDecoration(
                //       hintText: 'ItemName',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onChanged: (value) {
                //       setState(() {
                //         soilist[widget.i].itemname = value;
                //       });
                //     },
                //   ),
                // ),
                // SizedBox(
                //   width: 3,
                // ),
                // Container(
                //   width: displayWidth(context) * 0.24,
                //   child: TextFormField(
                //     controller: deliveryDateController,
                //     decoration: InputDecoration(
                //       hintText: 'Delivery Date',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onChanged: (value) {
                //       if (value != '') {
                //         soilist[widget.i].deliverydate = value;
                //         if (!mounted) return;
                //         setState(() {});
                //       }
                //     },
                //   ),
                // ),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: Container(
                      width: displayWidth(context) * 0.35,
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        controller: deliveryDateController,
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
                          hintText: 'Date',
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
                ),
                SizedBox(
                  width: 3,
                ),
                Container(
                  width: displayWidth(context) * 0.2,
                  child: TextFormField(
                    controller: quantityController,
                    decoration: InputDecoration(
                      hintText: 'Quantity',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value != '') {
                        soilist[widget.i].qty = double.parse(value);
                        // soilist[widget.i].amount =
                        //     double.parse(value) * soilist[widget.i].rate;
                        // quantityController.text = value;
                        // amountController.text =
                        //     (double.parse(value) * soilist[widget.i].rate)
                        //         .toString();
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                  ),
                ),
                // SizedBox(
                //   width: 3,
                // ),
                // Container(
                //   width: displayWidth(context) * 0.24,
                //   child: TextFormField(
                //     controller: rateController,
                //     decoration: InputDecoration(
                //       hintText: 'Rate',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onChanged: (value) {
                //       if (value != '') {
                //         soilist[widget.i].rate = double.parse(value);
                //         rateController.text = value;
                //         if (!mounted) return;
                //         setState(() {});
                //       }
                //     },
                //   ),
                // ),
                // SizedBox(
                //   width: 3,
                // ),
                // Container(
                //   width: displayWidth(context) * 0.24,
                //   child: TextFormField(
                //     controller: amountController,
                //     decoration: InputDecoration(
                //       hintText: 'Amount',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //     ),
                //     onChanged: (value) {
                //       soilist[widget.i].amount =
                //           soilist[widget.i].rate * soilist[widget.i].qty;
                //       amountController.text =
                //           (double.parse(value) * soilist[widget.i].rate)
                //               .toString();
                //       if (value != '') {
                //         soilist[widget.i].amount = double.parse(value);
                //         if (!mounted) return;
                //         setState(() {});
                //       }
                //     },
                //   ),
                // ),
                SizedBox(
                  width: 0,
                ),
                IconButton(
                    icon: Icon(Icons.delete), onPressed: widget.onDelete),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
