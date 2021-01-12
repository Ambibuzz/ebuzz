import 'package:dio/dio.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/stockentry/model/stockentry.dart';
import 'package:ebuzz/util/apiurls.dart';

//StockEntryService class contains function for fetching data or posting  data
class StockEntryService {
  //for fetching stock entry list
  Future<List<StockEntryModel>> getStockEntryList() async {
    List list = [];
    List<StockEntryModel> selist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String qi = stockEntryUrl();
      final response = await _dio.get(qi);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        selist.add(StockEntryModel.fromJson(listJson));
      }
      return selist;
    } catch (e) {
      exception(e);
    }
    return selist;
  }

  //for fetching stock entry item list
  Future<List<StockEntryItem>> getStockEntryitemList(String name) async {
    List list = [];
    List<StockEntryItem> qilist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String qi = stockEntryDetailUrl(name);
      final response = await _dio.get(qi);
      var data = response.data;
      list = data['data']['items'];
      for (var listJson in list) {
        qilist.add(StockEntryItem.fromJson(listJson));
      }
      return qilist;
    } catch (e) {
      exception(e);
    }
    return qilist;
  }
}
