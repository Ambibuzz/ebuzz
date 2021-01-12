import 'dart:async';
import 'package:dio/dio.dart';
import 'package:ebuzz/bom/model/bom_model.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:fluttertoast/fluttertoast.dart';

//BomApiService class contains function for fetching data or posting  data
class BomApiService {
  //For fetching list of itemcodes for bom
  Future<List<String>> getBomItemCodeList(String text) async {
    List<String> bomList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemList = itemDataUrl(text);
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      String bomName = data['data']['default_bom'];
      if (bomName != null) {
        final String bomurl = bomUrl(bomName);
        final bomResponse = await _dio.get(
          bomurl,
        );
        var bomData = bomResponse.data;
        List list = bomData['data']['items'];
        for (int i = 0; i < list.length; i++) {
          bomList.add(list[i]['item_code']);
        }
      }
      if (bomName == null) {
        Fluttertoast.showToast(
            msg: 'No Bom Data Found',
            textColor: whiteColor,
            backgroundColor: blueAccent,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
      }
      return bomList;
    } catch (e) {
      exception(e);
    }
    return bomList;
  }

  //For fetching list of itemcodes and itemnames for bom
  Future<List<BomModel>> getBomItemCodeAndNameList(String text) async {
    List<BomModel> bomNameAndCodeList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemList = itemDataUrl(text);
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      String bomName = data['data']['default_bom'];
      if (bomName != null) {
        final String bomurl = bomUrl(bomName);
        final bomResponse = await _dio.get(
          bomurl,
        );
        var bomData = bomResponse.data;
        List list = bomData['data']['items'];
        bomNameAndCodeList =
            list.map((item) => BomModel.fromJson(item)).toList();
      }
      if (bomName == null) {
        Fluttertoast.showToast(
            msg: 'No Bom Data Found',
            textColor: whiteColor,
            backgroundColor: blueAccent,
            gravity: ToastGravity.BOTTOM,
            toastLength: Toast.LENGTH_LONG);
      }
      return bomNameAndCodeList;
    } catch (e) {
      exception(e);
    }
    return bomNameAndCodeList;
  }

  //For fetching itemcode list
  Future<List> getItemCodeList() async {
    List listData = [];
    try {
      final String itemList = itemListUrl();
      Dio _dio = await BaseDio().getBaseDio();
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      listData = data['data'];
      return listData;
    } catch (e) {
      exception(e);
    }
    return listData;
  }
}
