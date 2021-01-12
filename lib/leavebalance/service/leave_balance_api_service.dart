import 'package:dio/dio.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/util/preference.dart';

//LeaveApiService class contains function for fetching data or posting  data
class LeaveApiService {
  //For fetching leaves based on username
  Future<List> fetchLeave() async {
    List list = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      String name = await getName();
      final String itemList = leaveLedgerEntryUrl(name);
      final response = await _dio.get(itemList);
      var data = response.data;
      list = data['data'];
      return list;
    } catch (e) {
      exception(e);
    }
    return list;
  }
}
