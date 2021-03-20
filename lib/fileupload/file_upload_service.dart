import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/item/model/product.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';

class FileUploadService {
  String doctype = 'Image Upload';
  String cmd = 'uploadfile';
  String fromform = '1';
  //for posting data to api
  Future postFileData(File image) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = fileUploadUrl();
      String fileName = image.path.split('/').last;
      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
        ),
      });
      final response = await _dio.post(url, data: data);
      print(response.statusMessage);
      if (response.statusCode == 200) {
        var data = response.data;
        print(data['message']);
        final String _url = fileUploadUrl2();
        final response1 = await _dio.post(_url, data: {
          'image_nameid': data['message']['file_name'],
          'image': data['message']['file_url'],
        });
        if (response1.statusCode == 200) {
          fluttertoast(whiteColor, blueAccent, 'File uploaded successfully');
        }
      }
    } catch (e) {
      exception(e);
    }
  }

  Future<Product> getData(String text) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = itemDataUrl(text);
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      exception(e);
    }
    return Product();
  }
}
