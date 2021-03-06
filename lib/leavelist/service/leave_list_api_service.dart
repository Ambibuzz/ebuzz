import 'package:dio/dio.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/leavelist/model/employee_leave.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:flutter/cupertino.dart';

//EmployeeApiService class contains function for fetching data or posting  data
class EmployeeApiService {
  //For fetching employee leave list from leave application api
  Future<List<EmployeeLeave>> fetchEmployeeLeavelist(String text,BuildContext context) async {
    List<EmployeeLeave> list = [];
    try {
      Dio dio = await BaseDio().getBaseDio();
      final String employeeleavelisturl = particularEmployeeListUrl(text);
      final response = await dio.get(
        employeeleavelisturl,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var listData = data['data'];
        for (var listJson in listData) {
          list.add(EmployeeLeave.fromJson(listJson));
        }
      } else {
        return [];
      }
      return list;
    } catch (e) {
      exception(e,context);
    }
    return list;
  }
}
