import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/qualityinspection/model/quality_inspection_model.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:flutter/cupertino.dart';

//QualityInspectionService class contains function for fetching data or posting  data
class QualityInspectionService {
  //for fetching quality inpsection readings list
  Future<List<QualityInspectionReadings>> getQIReadingsList(
      String qiteplate,BuildContext context) async {
    List list = [];
    List<QualityInspectionReadings> qilist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String qi = qualityInspectionTemplateReadingsListUrl(qiteplate);
      final response = await _dio.get(qi);
      var data = response.data;
      list = data['data']['item_quality_inspection_parameter'];
      for (var listJson in list) {
        qilist.add(QualityInspectionReadings.fromJson(listJson));
      }
      return qilist;
    } catch (e) {
      exception(e,context);
    }
    return qilist;
  }

  //for posting data to quality inpsection api
  Future post(QualityInspectionModel qualityInspection,BuildContext context) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = qualityInspectionUrl();
      final response = await _dio.post(url, data: qualityInspection);
      if (response.statusCode == 200) {
        fluttertoast(whiteColor, blueAccent, 'Data posted successfully');
      }
    } catch (e) {
      exception(e,context);
    }
  }

  //for fetching quality inpsection template
  Future<String> getQITemplate(String text,BuildContext context) async {
    String qitemplate = '';
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = itemDataUrl(text);
      final response = await _dio.get(url);
      var data = response.data;
      qitemplate = data['data']['quality_inspection_template'] ?? '';
      return qitemplate;
    } catch (e) {
      exception(e,context);
    }
    return qitemplate;
  }

  //for fetching quality inpsection model list
  Future<List<QualityInspectionModel>> getQualityInspectionModelList(BuildContext context) async {
    List list = [];
    List<QualityInspectionModel> qilist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String qi = qualityInspectionListUrl();
      final response = await _dio.get(qi);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        qilist.add(QualityInspectionModel.fromJson(listJson));
      }
      return qilist;
    } catch (e) {
      exception(e,context);
    }
    return qilist;
  }

  //for fetching quality inpsection readings list
  Future<List<QualityInspectionReadings>> getQualityInspectionReadingList(
      String name,BuildContext context) async {
    List list = [];
    List<QualityInspectionReadings> qireadinglist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String qi = qualityInspectionDetailUrl(name);
      final response = await _dio.get(qi);
      var data = response.data;
      list = data['data']['readings'];
      for (var listJson in list) {
        qireadinglist.add(QualityInspectionReadings.fromJson(listJson));
      }
      return qireadinglist;
    } catch (e) {
      exception(e,context);
    }
    return qireadinglist;
  }

  //for fetching quality inspection template list
  Future<List<String>> qualityInspectionTemplateList(
      BuildContext context) async {
    List<String> salesInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = qualityinspectionTemplateUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        salesInvoiceList.add(listJson['name']);
      }
      return salesInvoiceList;
    } catch (e) {
      exception(e,context);
    }
    return salesInvoiceList;
  }
}
