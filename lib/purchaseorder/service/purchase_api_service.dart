import 'package:dio/dio.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/purchaseorder/model/purchase_model.dart';
import 'package:ebuzz/util/apiurls.dart';

//PurchaseApiService class contains function for fetching data or posting  data
class PurchaseApiService {
  //For fetching purchase order data
  Future<PurchaseModel> getPurchaseOrderData(String name) async {
    PurchaseModel purchaseModelData;
    try {
      Dio dio = await BaseDio().getBaseDio();
      final String pourl = purchaseOrderDetailUrl(name);
      final response = await dio.get(pourl);
      var decData = response.data;

      var data = decData['data'];
      purchaseModelData = PurchaseModel.fromJson(data);
      return purchaseModelData;
    } catch (e) {
      exception(e);
    }
    return purchaseModelData;
  }

  //For fetching purchase order item list
  Future<List<ItemsModel>> getPurchaseOrderItemList(String name) async {
    List<ItemsModel> items = [];
    try {
      Dio dio = await BaseDio().getBaseDio();

      final String itemList = purchaseOrderDetailUrl(name);
      final response = await dio.get(itemList);
      var data = response.data;
      List list = data['data']['items'];
      for (var listJson in list) {
        items.add(ItemsModel.fromJson(listJson));
      }
      return items;
    } catch (e) {
      exception(e);
    }
    return items;
  }

  //For fetching names list
  Future<List> getNameList() async {
    List list = [];
    try {
      final String itemList = purchaseOrderListUrl();

      Dio dio = await BaseDio().getBaseDio();

      var response = await dio.get(itemList);
      var data = response.data;
      list = data['data'];
      return list;
    } catch (e) {
      exception(e);
    }
    return list;
  }
}
