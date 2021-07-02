import 'package:dio/dio.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/quotation/model/quotation.dart';
import 'package:ebuzz/quotation/model/quotation_item.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:flutter/cupertino.dart';

class QuotationService {
  Future<List<Quotation>> getQuotationList(BuildContext context) async {
    List<Quotation> qolist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String qo = quotationListUrl();
      final response = await _dio.get(qo);
      var data = response.data;
      var list = data['data'] as List;
      qolist = list.map((qo) => Quotation.fromJson(qo)).toList();
      return qolist;
    } catch (e) {
      exception(e, context);
    }
    return qolist;
  }

  Future<List<QuotationItem>> getQuotationItemsList(
      String quotation, BuildContext context) async {
    List<QuotationItem> qolist = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String qo = quotationIndividualUrl(quotation);
      final response = await _dio.get(qo);
      var data = response.data;
      var list = data['data']['items'] as List;
      qolist = list.map((qo) => QuotationItem.fromJson(qo)).toList();
      return qolist;
    } catch (e) {
      exception(e, context);
    }
    return qolist;
  }
}
