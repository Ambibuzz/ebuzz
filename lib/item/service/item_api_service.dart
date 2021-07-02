
import 'package:dio/dio.dart';
import 'package:ebuzz/common_models/product.dart';

import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:flutter/cupertino.dart';

//ItemApiService class contains function for fetching data or posting  data
class ItemApiService {
  
  //For fetching data from item api in product model
  Future<Product> getData(String text,BuildContext context) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = itemDataUrl(text);
      final response = await _dio.get(
        url,
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e,context);
    }
    return Product();
  }

  

  
}
