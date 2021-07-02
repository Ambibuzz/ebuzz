import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/purchaseorder/model/purchase_model.dart';
import 'package:ebuzz/purchaseorder/service/purchase_api_service.dart';
import 'package:ebuzz/purchaseorder/ui/purchase_order_detail.dart';
import 'package:flutter/material.dart';

//PurchaseOrderUi class contains ui of purchase order list
class PurchaseOrderUi extends StatefulWidget {
  @override
  _PurchaseOrderUiState createState() => _PurchaseOrderUiState();
}

class _PurchaseOrderUiState extends State<PurchaseOrderUi> {
  List<String> unsortedName = [];
  List<String> name = [];
  bool loading = false;

  PurchaseApiService _purchaseApiService = PurchaseApiService();
  @override
  void initState() {
    super.initState();
    getNameList();
  }

  //For fetching list of sorted purchase order names
  void getNameList() async {
    setState(() {
      loading = true;
    });
    name = await _purchaseApiService.getNameList(context);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: CustomAppBar(
          title: Text('Purchase Order', style: TextStyle(color: whiteColor)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
        ),
      ),
      body: loading
          ? CircularProgress()
          : name.length == 0
              ? CircularProgress()
              : ListView.builder(
                  itemCount: name.length,
                  itemBuilder: (context, index) {
                    return PurchaseOrderInfo(
                      name: name[index],
                    );
                  },
                ),
    );
  }
}

//PurchaseOrderInfo class is a reusble widget which contains ui of purchase order list
class PurchaseOrderInfo extends StatefulWidget {
  final String name;
  const PurchaseOrderInfo({required this.name});
  @override
  _PurchaseOrderInfoState createState() => _PurchaseOrderInfoState();
}

class _PurchaseOrderInfoState extends State<PurchaseOrderInfo> {
  PurchaseModel purchaseModelData =
      PurchaseModel(date: '', requiredByDate: '', supplier: '');
  PurchaseApiService _purchaseApiService = PurchaseApiService();

  @override
  void initState() {
    super.initState();
    getPurchaseOrderData();
  }

  getPurchaseOrderData() async {
    purchaseModelData =
        await _purchaseApiService.getPurchaseOrderData(widget.name, context);
    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: () {
          pushScreen(
            context,
            PurchaseOrderDetail(
              name: widget.name,
              date: purchaseModelData.date,
              requiredDate: purchaseModelData.requiredByDate,
              supplier: purchaseModelData.supplier,
            ),
          );
        },
        title: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(purchaseModelData.supplier,
              style: TextStyle(fontSize: 14, color: blackColor)),
        ),
        subtitle: Text(widget.name,
            style: TextStyle(fontSize: 14, color: blackColor)),
      ),
    );
  }
}
