import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/purchasereciept/model/purchase_reciept_model.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:flutter/cupertino.dart';

//PurchaseReceiptService class contains function for fetching data or posting  data
class PurchaseRecieptService {
  //for fetching purchase receipt item list
  Future<List<PRItem>> getPurchaseRecieptItemList(String name,BuildContext context) async {
    List<PRItem> items = [];

    try {
      Dio _dio = await BaseDio().getBaseDio();

      final String itemList = purchaseOrderDetailUrl(name);
      var response = await _dio.get(
        itemList,
      );
      var data = response.data;
      List list = data['data']['items'];
      for (var listJson in list) {
        items.add(PRItem.fromJson(listJson));
      }
      return items;
    } catch (e) {
      exception(e,context);
    }
    return items;
  }

  //for posting data to purchase receipt item api
  Future post({required List<PRItem> items,required String supplier,required BuildContext context}) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      PurchaseReceiptModel purchaseRecieptModel = PurchaseReceiptModel(
          docStatus: 0,
          prItems: items,
          supplier: supplier,
          workflowState: 'Draft');
      final String url = purchaseRecieptUrl();
      final response = await _dio.post(url, data: purchaseRecieptModel);
      if (response.statusCode == 200) {
        fluttertoast(whiteColor, blueAccent, 'Data posted successfully');
      }
    } catch (e) {
      exception(e,context);
    }
  }
}
