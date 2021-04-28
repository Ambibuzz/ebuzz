import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/qualityinspection/model/quality_inspection_model.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/qualityinspection/model/reference_type_model.dart';
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

  //for fetching batch list
  Future<List<String>> getbatchList(String itemcode,BuildContext context) async {
    List<String> batchList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String dn = batchListUrl(itemcode);
      final response = await _dio.get(dn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        batchList.add(listJson['batch_id']);
      }
      return batchList;
    } catch (e) {
      exception(e,context);
    }
    return batchList;
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

  //for fetching username
  Future<String> getUsername(BuildContext context) async {
    String username = '';
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = usernameUrl();
      final response = await _dio.get(url);
      var data = response.data;
      username = data['message'];
      return username;
    } catch (e) {
      exception(e,context);
    }
    return username;
  }

  //for fetching delivery note list
  Future<List<DeliveryNote>> getDeliveryNoteList(BuildContext context) async {
    List<DeliveryNote> deliveryNoteList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String dn = deliveryNoteUrl();
      final response = await _dio.get(dn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        deliveryNoteList.add(DeliveryNote.fromJson(listJson));
      }
      return deliveryNoteList;
    } catch (e) {
      exception(e,context);
    }
    return deliveryNoteList;
  }

  //for fetching stock entry list
  Future<List<StockEntry>> getStockEntryList(BuildContext context) async {
    List<StockEntry> stockEntryList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = stockEntrySubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        stockEntryList.add(StockEntry.fromJson(listJson));
      }
      return stockEntryList;
    } catch (e) {
      exception(e,context);
    }
    return stockEntryList;
  }

  //for fetching purchase invoice list
  Future<List<PurchaseInvoice>> getPurchaseInvoiceList(BuildContext context) async {
    List<PurchaseInvoice> purchaseInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseInvoiceSubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        purchaseInvoiceList.add(PurchaseInvoice.fromJson(listJson));
      }
      return purchaseInvoiceList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseInvoiceList;
  }

  //for fetching purchase receipt list
  Future<List<PurchaseReciept>> getPurchaseRecieptList(BuildContext context) async {
    List<PurchaseReciept> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseRecieptSubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        purchaseRecieptList.add(PurchaseReciept.fromJson(listJson));
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseRecieptList;
  }

  //for fetching sales invoice list
  Future<List<SalesOrder>> getSalesInvoiceList(BuildContext context) async {
    List<SalesOrder> salesInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = salesInvoiceSubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        salesInvoiceList.add(SalesOrder.fromJson(listJson));
      }
      return salesInvoiceList;
    } catch (e) {
      exception(e,context);
    }
    return salesInvoiceList;
  }

  //for fetching delivery note string list
  Future<List<String>> getDeliveryNoteStringList(BuildContext context) async {
    List<String> deliveryNoteList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String dn = deliveryNoteUrl();
      final response = await _dio.get(dn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        deliveryNoteList.add(listJson['name']);
      }
      return deliveryNoteList;
    } catch (e) {
      exception(e,context);
    }
    return deliveryNoteList;
  }

  //for fetching stock entry string list
  Future<List<String>> getStockEntryStringList(BuildContext context) async {
    List<String> stockEntryList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = stockEntrySubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        stockEntryList.add(listJson['name']);
      }
      return stockEntryList;
    } catch (e) {
      exception(e,context);
    }
    return stockEntryList;
  }

  //for fetching purchase invoice string list
  Future<List<String>> getPurchaseInvoiceStringList(BuildContext context) async {
    List<String> purchaseInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseInvoiceSubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        purchaseInvoiceList.add(listJson['name']);
      }
      return purchaseInvoiceList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseInvoiceList;
  }

  //for fetching purchase receipt string list
  Future<List<String>> getPurchaseRecieptStringList(BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseRecieptSubmittedUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseRecieptList;
  }

  //for fetching sales invoice string list
  Future<List<String>> getSalesInvoiceStringList(BuildContext context) async {
    List<String> salesInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = salesInvoiceSubmittedUrl();
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

  //for fetching batch list
  Future<List<String>> getBatchList(BuildContext context) async {
    List<String> salesInvoiceList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = batchUrl();
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data'];
      for (var listJson in list) {
        salesInvoiceList.add(listJson['batch_id']);
      }
      return salesInvoiceList;
    } catch (e) {
      exception(e,context);
    }
    return salesInvoiceList;
  }

  //for fetching purchase receipt string list
  Future<List<String>> getPurchaseRecieptData(String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseRecieptDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseRecieptList;
  }

  //for fetching purchase invoice string list
  Future<List<String>> getPurchaseInvoiceData(String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = purchaseInvoiceDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseRecieptList;
  }

  //for fetching delivery note string list
  Future<List<String>> getDeliveryNoteData(String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = deliveryNoteDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseRecieptList;
  }

  //for fetching sales invoice string list
  Future<List<String>> getSalesInvoiceData(String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = salesInvoiceDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseRecieptList;
  }

  //for fetching stock entry string list
  Future<List<String>> getStockEntryData(String name, BuildContext context) async {
    List<String> purchaseRecieptList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String sn = stockEntryDataUrl(name);
      final response = await _dio.get(sn);
      var data = response.data;
      var list = data['data']['items'];
      for (var listJson in list) {
        purchaseRecieptList.add(listJson['item_name']);
      }
      return purchaseRecieptList;
    } catch (e) {
      exception(e,context);
    }
    return purchaseRecieptList;
  }
}
