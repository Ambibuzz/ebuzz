import 'package:dio/dio.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';

//HomeService class contains function to check login status
class HomeService {
  //For checking login status
  Future checkLoginStatus(String text) async {
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String url = sampleApiCheckUrl(text);
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      exception(e);
    }
    return null;
  }

  
}
