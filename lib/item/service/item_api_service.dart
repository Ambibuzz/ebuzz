import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/item/model/product.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:http/http.dart' as http;

//ItemApiService class contains function for fetching data or posting  data
class ItemApiService {
  List<String> unique = [];
  List<String> warehouseName = [];
  List<double> warehouseQty = [];

  //For fetching warehousename data from stock ledger entry api
  Future<List<String>> getWareHouseNameData(String itemCode) async {
    unique.clear();
    warehouseName.clear();
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String dateCreationUrl = stockLedgerUrl(itemCode);
      var dateCreationResponse = await _dio.get(
        dateCreationUrl,
      );
      List<String> warehouseList = [];

      var decData = await dateCreationResponse.data;
      for (int i = 0; i < decData['data'].length; i++) {
        warehouseList.add(decData['data'][i]['warehouse']);
      }
      for (int i = 0; i < warehouseList.length; i++) {
        if (!unique.contains(warehouseList[i])) {
          unique.add(warehouseList[i]);
          warehouseName.add(decData['data'][i]['warehouse']);
        }
      }
    } catch (e) {
      exception(e);
    }
    return warehouseName;
  }

  //For fetching itemcode data from barcode api
  Future<String> getItemCodeFromBarcode(String barcode) async {
    String itemCode = '';
    try {
      final String cookie = await getCookie();
      final String baseurl = await getApiUrl();
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie
      };
      final String url = barcodeUrl(barcode);
      final barcodeurl = baseurl + url;
      final response = await http.get(barcodeurl, headers: requestHeaders);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        itemCode = data['message']['item'];
        return itemCode;
      }
      if (response.statusCode == 417) {
        fluttertoast(whiteColor, blueAccent, 'Invalid Barcode');
        return '';
      }
    } catch (e) {}
    return itemCode;
  }

  //For fetching warehousequantity data from stock ledger entry api
  Future<List<double>> getWareHouseQtyData(String itemCode) async {
    unique.clear();
    warehouseQty.clear();
    try {
      Dio _dio = await BaseDio().getBaseDio();

      final String dateCreationUrl = stockLedgerUrl(
        itemCode,
      );
      final dateCreationResponse = await _dio.get(
        dateCreationUrl,
      );
      List<String> warehouseList = [];
      var decData = await dateCreationResponse.data;
      for (int i = 0; i < decData['data'].length; i++) {
        warehouseList.add(decData['data'][i]['warehouse']);
      }
      for (int i = 0; i < warehouseList.length; i++) {
        if (!unique.contains(warehouseList[i])) {
          unique.add(warehouseList[i]);
          warehouseQty.add(decData['data'][i]['qty_after_transaction']);
        }
      }
    } catch (e) {
      exception(e);
    }
    return warehouseQty;
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
      exception(e);
    }
    return Product();
  }

  //For fetching itemcode from itemname
  Future<String> getItemCodeFromItemName(String text) async {
    String itemCode;
    try {
      Dio _dio = await BaseDio().getBaseDio();

      final String url = specificItemNameDataUrl(text);
      final response = await _dio.get(
        url,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        itemCode = data['data'][0]['name'];
        return itemCode;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e);
    }
    return itemCode;
  }

  //For fetching data for specific itemname from item api
  Future<Product> getDataFromItemName(String text) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = specificItemNameDataUrl(text);
      final response = await _dio.get(
        url,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e);
    }
    return Product();
  }

  //For fetching list of items (itemname,itemcode) data from item api
  Future<List> getItemList() async {
    List listData = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemList = itemListUrl();
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      listData = data['data'];
    } catch (e) {
      exception(e);
    }
    return listData;
  }
}
