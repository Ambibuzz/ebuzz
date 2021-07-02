import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/config/color_palette.dart';
import 'package:ebuzz/purchasereciept/model/purchase_reciept_model.dart';
import 'package:ebuzz/purchasereciept/service/purchase_reciept_service.dart';
import 'package:ebuzz/widgets/custom_card.dart';
import 'package:ebuzz/widgets/custom_textformformfield.dart';
import 'package:flutter/material.dart';

List<PRItem> items = [];

//PurchaseRecieptFormUi is a form for posting data to purchase receipt api
class PurchaseRecieptFormUi extends StatefulWidget {
  final String supplier;
  final String name;
  PurchaseRecieptFormUi({required this.supplier, required this.name});
  @override
  _PurchaseRecieptFormUiState createState() => _PurchaseRecieptFormUiState();
}

class _PurchaseRecieptFormUiState extends State<PurchaseRecieptFormUi> {
  TextEditingController supplierController = TextEditingController();
  PurchaseRecieptService _purchaseRecieptService = PurchaseRecieptService();
  bool _postButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    supplierController.text = widget.supplier;
    getPurchaseRecieptItemList();
  }

  getPurchaseRecieptItemList() async {
    items = await _purchaseRecieptService.getPurchaseRecieptItemList(
        widget.name, context);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    postReciept() async {
      setState(() {
        _postButtonDisabled = true;
      });
      await _purchaseRecieptService.post(
          items: items, supplier: widget.supplier, context: context);
      setState(() {
        _postButtonDisabled = false;
      });
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: CustomAppBar(
            title:
                Text('Purchase Reciept', style: TextStyle(color: whiteColor)),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
            ),
          )),
      body: items.isEmpty
          ? CircularProgress()
          : Form(
              child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CustomTextFormField(
                    decoration: InputDecoration(
                        fillColor: greyColor,
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        )),
                    label: 'Supplier',
                    readOnly: true,
                    initialValue: supplierController.text,
                    labelStyle: TextStyle(color: blackColor),
                    style: TextStyle(fontSize: 14, color: blackColor),
                  ),
                ),
                items.length == 0
                    ? Container()
                    : Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: items.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final item = items[index];
                              return Column(
                                children: [
                                  FormItemUi(
                                    key: ObjectKey(item),
                                    item: item,
                                    i: index,
                                    onDelete: () => onDelete(index),
                                  ),
                                ],
                              );
                            }),
                      )
              ],
            )),
      floatingActionButton: Container(
        width: 50,
        height: 50,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(Icons.save, size: 25),
            backgroundColor: _postButtonDisabled ? greyColor : blueAccent,
            onPressed: _postButtonDisabled ? null : postReciept,
          ),
        ),
      ),
    );
  }

  void onDelete(int index) {
    items.removeAt(index);
    setState(() {});
  }
}

typedef OnDelete();

//FormItemUi class is ui for particular item in purchase receipt

class FormItemUi extends StatefulWidget {
  final PRItem item;
  final int i;
  final OnDelete onDelete;
  FormItemUi(
      {required Key key,
      required this.item,
      required this.i,
      required this.onDelete})
      : super(key: key);
  @override
  _FormItemUiState createState() => _FormItemUiState();
}

class _FormItemUiState extends State<FormItemUi> {
  late TextEditingController itemCodeContoller;
  late TextEditingController itemNameContoller;
  late TextEditingController purchaseOrderContoller;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    itemCodeContoller = TextEditingController();
    itemNameContoller = TextEditingController();
    purchaseOrderContoller = TextEditingController();
    quantityController = TextEditingController();
    quantityController.text =
        (widget.item.quantity! - widget.item.quantityRecieved!).toString();
    itemCodeContoller.text = widget.item.itemCode!;
    itemNameContoller.text = widget.item.itemName!;
    purchaseOrderContoller.text = widget.item.purchaseOrder!;
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6, top: 4, right: 6, bottom: 4),
      child: CustomCard(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                  purchaseRecieptWidget('Item Name', itemNameContoller.text),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    controller: quantityController,
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
                    required: true,
                    labelStyle: TextStyle(color: blackColor),
                    onChanged: (value) {
                      if (value != '') {
                        items[widget.i].quantity = double.parse(value);
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                    validator: (val) =>
                        val == '0' ? 'Quantity cannot be zero' : null,
                    style: TextStyle(fontSize: 14, color: blackColor),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: purchaseRecieptWidget(
                              'Item Code', itemCodeContoller.text)),
                      SizedBox(width: 5),
                      Expanded(
                          flex: 1,
                          child: purchaseRecieptWidget(
                              'Purchase Order', purchaseOrderContoller.text)),
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

  Widget deleteWidget() {
    return IconButton(
        icon: Icon(Icons.cancel_sharp, color: ColorPalette.red),
        onPressed: widget.onDelete);
  }

  Widget purchaseRecieptWidget(String label, String value) {
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
