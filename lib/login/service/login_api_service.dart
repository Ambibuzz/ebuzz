import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/home/model/globaldefaultsmodel.dart';
import 'package:ebuzz/home/service/home_service.dart';
import 'package:ebuzz/home/ui/home.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ebuzz/util/apiurls.dart';

//LoginApiService class contains function login
class LoginApiService {
  // String aToken = '';

  // final BaseOptions options = new BaseOptions(
  //   baseUrl: '',
  //   connectTimeout: 500000,
  //   receiveTimeout: 500000,
  // );

  // Future getItemDioData({String apiurl}) async {
  //   final String cookie = await getCookie();
  //   final String url = '$apiurl/api/resource/Item/11019';
  //   Map<String, String> requestHeaders = {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Cookie': cookie
  //   };
  //   final response = await http.get(url, headers: requestHeaders);
  // }

  //For doing login based on the username and password
  Future login(
      {String username,
      String password,
      BuildContext context,
      String baseUrl}) async {
    try {
      List<String> baseurllist = await getBaseUrlList();
      HomeService _homeService=HomeService();
      final String url = loginUrl(baseUrl);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'usr': username,
          'pwd': password,
        }),
      );
      if (response.statusCode == 200) {
        if (baseurllist != null) {
          if (!baseurllist.contains(baseUrl)) {
            baseurllist.add(baseUrl);
            setBaseUrlList(baseurllist);
          }
        }
        if (baseurllist == null) {
          List<String> list = [];
          list.add(baseUrl);
          setBaseUrlList(list);
        }
        var data = jsonDecode(response.body);
        String fullname = data['full_name'];
        setApiUrl(baseUrl);
        setLoggedIn(true);
        setName(fullname);
        var cookie = response.headers['set-cookie'];
        String cookieSid = cookie.split(';').first.toString();
        setCookie(cookieSid);
        await setGlobalDefaults(context);
        pushReplacementScreen(context, Home());
      }
      if (response.statusCode == 400) {
        fluttertoast(whiteColor, redColor, 'Incorrect username or password');
      }
      if (response.statusCode == 401) {
        fluttertoast(whiteColor, redColor, 'Incorrect username or password');
      }
    } catch (e) {
      if (e is SocketException) {
        fluttertoast(whiteColor, blueAccent, 'No Internet Connection');
      } else {
        fluttertoast(whiteColor, blueAccent, 'Unexpected Error');
      }
    }
  }

  Future setGlobalDefaults(BuildContext context) async {
    GlobalDefaults globalDefaultsData;
    try {
      Dio dio = await BaseDio().getBaseDio();
      final String globaldefaults = globalDefaultsUrl();
      final response = await dio.get(globaldefaults);
      if (response.statusCode == 200) {
        var data = response.data;
        var listData = data['data'];
        globalDefaultsData = GlobalDefaults.fromJson(listData);
        setCompany(globalDefaultsData.company);
        setCurrency(globalDefaultsData.currency);
      }
    } catch (e) {
      exception(e,context);
    }
  }
}
