import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common_models/product.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/config/color_palette.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/salesorder/model/sales_order.dart';
import 'package:ebuzz/salesorder/service/sales_order_service.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/widgets/custom_card.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:ebuzz/widgets/custom_typeahead_formfield.dart';
import 'package:ebuzz/widgets/typeahead_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<SalesOrderItems> soilist = [];
List<String> itemCodeList = [];
List<TextEditingController> itemcodecontrollerlist = <TextEditingController>[];
List<TextEditingController> quantitycontrollerlist = <TextEditingController>[];
List<TextEditingController> datecontrollerlist = <TextEditingController>[];

class SalesOrderForm2 extends StatefulWidget {
  final String? date;
  final String? company;
  final String? customer;
  final String? warehouse;
  final String? purchaseorder;
  final String? portOfDischarge;
  final String? orderType;
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
      List listData = await CommonService().getItemList(context);
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
        preferredSize: Size.fromHeight(55),
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
              itemcodecontrollerlist.add(TextEditingController());
              quantitycontrollerlist.add(TextEditingController());
              datecontrollerlist.add(TextEditingController());
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
              style: TextStyle(fontSize: 18, color: blackColor),
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
                        int lastElement = soilist.length - 1;
                        return Column(
                          children: [
                            SOItemsForm(
                              key: ObjectKey(item),
                              soi: item,
                              i: index,
                              onDelete: () => onDelete(index, lastElement),
                            ),
                          ],
                        );
                      }),
                ),
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
    await SalesOrderService().post(salesOrderModel, context);
    if (!mounted) return;
    setState(() {
      _postButtonDisabled = false;
    });
  }

  void assignIndex(int index, int lastElement) {
    for (int i = index; i < lastElement; i++) {
      setState(() {
        soilist[i].itemcode = soilist[i + 1].itemcode;
        soilist[i].deliverydate = soilist[i + 1].deliverydate;
        soilist[i].qty = soilist[i + 1].qty;

        itemcodecontrollerlist[i].text = soilist[i + 1].itemcode!;
        datecontrollerlist[i].text = soilist[i + 1].deliverydate!;
        quantitycontrollerlist[i].text = soilist[i + 1].qty!.toString();
      });
    }
  }

  void onDelete(int index, int lastElement) {
    if (index != lastElement) {
      assignIndex(index, lastElement);
    }
    soilist.removeAt(index);
    itemcodecontrollerlist.removeAt(index);
    quantitycontrollerlist.removeAt(index);
    datecontrollerlist.removeAt(index);
    if (!mounted) return;
    setState(() {});
  }
}

typedef OnDelete();

class SOItemsForm extends StatefulWidget {
  final SalesOrderItems soi;
  final OnDelete onDelete;
  final int i;

  SOItemsForm(
      {required Key key,
      required this.soi,
      required this.onDelete,
      required this.i})
      : super(key: key);
  @override
  _SOItemsFormState createState() => _SOItemsFormState();
}

class _SOItemsFormState extends State<SOItemsForm>
    with AutomaticKeepAliveClientMixin {
  int count = 0;
  Product product = Product();
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
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
      String date = DateFormat('y-M-d').format(picked).toString();
      soilist[widget.i].deliverydate = date;
      datecontrollerlist[widget.i].text = date;
    });
  }

  setItemData(String itemCode, int index) async {
    product = await getData(itemCode);
    soilist[index].rate = double.parse(product.valuationRate.toString());
    soilist[index].qty = 1.0;
    soilist[index].amount = soilist[index].rate! * soilist[index].qty!;
    quantitycontrollerlist[index].text = 1.0.toString();
    itemcodecontrollerlist[index].text = itemCode;
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
        return Product.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e, context);
    }
    return Product();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.only(left: 6, top: 4, right: 6, bottom: 4),
      child: CustomCard(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: deleteWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 25),
              child: Column(
                children: [
                  itemCodeField(),
                  Row(
                    children: [
                      Expanded(child: dateField()),
                      SizedBox(width: 5),
                      Expanded(child: quantityField()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateField() {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: CustomTextFormField(
          controller: datecontrollerlist[widget.i],
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

  Widget deleteWidget() {
    return IconButton(
        icon: Icon(Icons.cancel_sharp, color: ColorPalette.red),
        onPressed: widget.onDelete);
  }

  Widget itemCodeField() {
    return CustomTypeAheadFormField(
      controller: itemcodecontrollerlist[widget.i],
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Item Code',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item);
      },
      onSuggestionSelected: (suggestion) async {
        setItemData(suggestion, widget.i);
        if (!mounted) return;
        setState(() {
          soilist[widget.i].itemcode = suggestion;
        });
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, itemCodeList);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (val) =>
          val == '' || val == null ? 'Item Code should not be empty' : null,
    );
  }

  Widget quantityField() {
    return CustomTextFormField(
      controller: quantitycontrollerlist[widget.i],
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
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Quantity',
      labelStyle: TextStyle(color: blackColor),
      style: TextStyle(fontSize: 14, color: blackColor),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
