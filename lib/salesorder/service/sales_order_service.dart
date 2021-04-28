import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/salesorder/model/sales_order.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:flutter/cupertino.dart';

class SalesOrderService {

  //for posting data to quality inpsection api
  Future post(SalesOrder salesOrder, BuildContext context) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = salesOrderUrl();
      final response = await _dio.post(url, data: salesOrder);
      if (response.statusCode == 200) {
        fluttertoast(whiteColor, blueAccent, 'Data posted successfully');
      }
    } catch (e) {
      exception(e,context);
    }
  }

  //for fetching company list
  Future<List<String>> getCompanyList(BuildContext context) async {
    List<String> companylist = [];
    List list;
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String so = companyListUrl();
      final response = await _dio.get(so);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        companylist.add(listJson['name']);
      }
      return companylist;
    } catch (e) {
      exception(e,context);
    }
    return companylist;
  }

  //for fetching warehouse list
  Future<List<String>> getWarehouseList(String company, BuildContext context) async {
    List<String> warehouselist = [];
    List list;
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String so = warehouseList(company);
      final response = await _dio.get(so);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        warehouselist.add(listJson['name']);
      }
      return warehouselist;
    } catch (e) {
      exception(e,context);
    }
    return warehouselist;
  }

  //for fetching customer list
  Future<List<String>> getCustomerList(BuildContext context) async {
    List<String> customerlist = [];
    List list;
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String so = customerListUrl();
      final response = await _dio.get(so);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        customerlist.add(listJson['name']);
      }
      return customerlist;
    } catch (e) {
      exception(e,context);
    }
    return customerlist;
  }


  //for fetching sales order list
  Future<List<SalesOrder>> getSalesOrderList(BuildContext context) async {
    List list = [];
    List<SalesOrder> solist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String so = salesOrderListUrl();
      final response = await _dio.get(so);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        solist.add(SalesOrder.fromJson(listJson));
      }
      return solist;
    } catch (e) {
      exception(e,context);
    }
    return solist;
  }

  //for fetching sales order item list
  Future<List<SalesOrderItems>> getSalesOrderItemList(String name, BuildContext context) async {
    List<SalesOrderItems> items = [];

    try {
      Dio _dio = await BaseDio().getBaseDio();

      final String itemList = salesOrderDetailUrl(name);
      var response = await _dio.get(
        itemList,
      );
      var data = response.data;
      List list = data['data']['items'];
      for (var listJson in list) {
        items.add(SalesOrderItems.fromJson(listJson));
      }
      return items;
    } catch (e) {
      exception(e,context);
    }
    return items;
  }

  //for fetching sales order payment schedule list
  Future<List<SalesOrderPaymentSchedule>> getSalesOrderPaymentScheduleList(
      String name, BuildContext context) async {
    List<SalesOrderPaymentSchedule> ps = [];

    try {
      Dio _dio = await BaseDio().getBaseDio();

      final String itemList = salesOrderDetailUrl(name);
      var response = await _dio.get(
        itemList,
      );
      var data = response.data;
      List list = data['data']['payment_schedule'];
      for (var listJson in list) {
        ps.add(SalesOrderPaymentSchedule.fromJson(listJson));
      }
      return ps;
    } catch (e) {
      exception(e,context);
    }
    return ps;
  }
}
