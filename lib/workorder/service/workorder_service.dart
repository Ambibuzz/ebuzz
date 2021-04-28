import 'package:dio/dio.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/workorder/model/workorder_model.dart';
import 'package:flutter/cupertino.dart';

//WorkOrderService class contains function for fetching data or posting  data
class WorkOrderService {
  //For fetching list of work orders
  Future<List<WorkOrderModel>> getWorkOrderModelList(
      BuildContext context) async {
    List list = [];
    List<WorkOrderModel> workorderlist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String workOrder = workOrderListUrl();
      final response = await _dio.get(workOrder);
      var data = response.data;
      list = data['data'];
      for (var listJson in list) {
        workorderlist.add(WorkOrderModel.fromJson(listJson));
      }
      return workorderlist;
    } catch (e) {
      exception(e,context);
    }
    return workorderlist;
  }

  //For fetching list of workorderitems in particular work order
  Future<List<WorkOrderItems>> getWorkOrderItemList(String name, BuildContext context) async {
    List list = [];
    List<WorkOrderItems> workorderlist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String workOrder = workOrderUrl(name);
      final response = await _dio.get(workOrder);
      var data = response.data;
      list = data['data']['required_items'];
      for (var listJson in list) {
        workorderlist.add(WorkOrderItems.fromJson(listJson));
      }
      return workorderlist;
    } catch (e) {
      exception(e,context);
    }
    return workorderlist;
  }
}
