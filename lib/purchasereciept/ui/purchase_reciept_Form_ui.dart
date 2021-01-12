import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/purchasereciept/model/purchase_reciept_model.dart';
import 'package:ebuzz/purchasereciept/service/purchase_reciept_service.dart';
import 'package:flutter/material.dart';

List<PRItem> items = [];

//PurchaseRecieptFormUi is a form for posting data to purchase receipt api
class PurchaseRecieptFormUi extends StatefulWidget {
  final String supplier;
  final String name;
  PurchaseRecieptFormUi({this.supplier, this.name});
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
    items =
        await _purchaseRecieptService.getPurchaseRecieptItemList(widget.name);
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
        items: items,
        supplier: widget.supplier,
      );
      setState(() {
        _postButtonDisabled = false;
      });
    }

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Purchase Reciept',
          )),
      body: items == null
          ? CircularProgress()
          : Form(
              child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: supplierController,
                  readOnly: true,
                  style: displayWidth(context) > 600
                      ? TextStyle(fontSize: 28, color: blackColor)
                      : TextStyles.t16Black,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: displayWidth(context) > 600 ? 28 : 16,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: displayWidth(context) > 600 ? 30 : 20,
                        horizontal: displayWidth(context) > 600 ? 20 : 10),
                    labelText: 'Supplier',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
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
        width: displayWidth(context) > 600 ? 100 : 50,
        height: displayWidth(context) > 600 ? 100 : 50,
        child: FittedBox(
          child: FloatingActionButton(
            child:
                Icon(Icons.save, size: displayWidth(context) > 600 ? 35 : 25),
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
  FormItemUi({Key key, this.item, this.i, this.onDelete}) : super(key: key);
  @override
  _FormItemUiState createState() => _FormItemUiState();
}

class _FormItemUiState extends State<FormItemUi> {
  TextEditingController itemCodeContoller;
  TextEditingController itemNameContoller;
  TextEditingController purchaseOrderContoller;
  TextEditingController quantityController;

  @override
  void initState() {
    super.initState();
    itemCodeContoller = TextEditingController();
    itemNameContoller = TextEditingController();
    purchaseOrderContoller = TextEditingController();
    quantityController = TextEditingController();
    quantityController.text =
        (widget.item.quantity - widget.item.quantityRecieved).toString();
    itemCodeContoller.text = widget.item.itemCode;
    itemNameContoller.text = widget.item.itemName;
    purchaseOrderContoller.text = widget.item.purchaseOrder;
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(displayWidth(context) > 600 ? 16 : 8),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: itemNameContoller,
                  readOnly: true,
                  style: displayWidth(context) > 600
                      ? TextStyle(
                          fontSize: 28,
                        )
                      : TextStyles.t16Black,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      fontSize: displayWidth(context) > 600 ? 28 : 16,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: displayWidth(context) > 600 ? 30 : 20,
                        horizontal: displayWidth(context) > 600 ? 20 : 10),
                    labelText: 'Item Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: quantityController,
                    style: displayWidth(context) > 600
                        ? TextStyle(
                            fontSize: 28,
                          )
                        : TextStyles.t16Black,
                    validator: (value) {
                      if (value == '0')
                        return 'Quantity cannot be zero';
                      else
                        return null;
                    },
                    onChanged: (value) {
                      if (value != '') {
                        items[widget.i].quantity = double.parse(value);
                        if (!mounted) return;
                        setState(() {});
                      }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: displayWidth(context) > 600 ? 28 : 16,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: displayWidth(context) > 600 ? 30 : 20,
                          horizontal: displayWidth(context) > 600 ? 20 : 10),
                      labelText: 'Quantity',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: blackColor, width: 1)),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.delete), onPressed: widget.onDelete),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: itemCodeContoller,
                    style: displayWidth(context) > 600
                        ? TextStyle(
                            fontSize: 28,
                          )
                        : TextStyles.t16Black,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: displayWidth(context) > 600 ? 28 : 16,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: displayWidth(context) > 600 ? 30 : 20,
                          horizontal: displayWidth(context) > 600 ? 20 : 10),
                      labelText: 'Item Code',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: purchaseOrderContoller,
                    readOnly: true,
                    style: displayWidth(context) > 600
                        ? TextStyle(
                            fontSize: 28,
                          )
                        : TextStyles.t16Black,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                        fontSize: displayWidth(context) > 600 ? 28 : 16,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: displayWidth(context) > 600 ? 30 : 20,
                          horizontal: displayWidth(context) > 600 ? 20 : 10),
                      labelText: 'Purchase Order',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: greyColor,
            height: 2,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
