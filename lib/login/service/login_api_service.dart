import 'dart:convert';
import 'dart:io';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/home/ui/home.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ebuzz/util/apiurls.dart';

//LoginApiService class contains function login
class LoginApiService {

  //For doing login based on the username and password
  Future login(
      {required String username,
      required String password,
      required BuildContext context,
      required String baseUrl}) async {
    try {
      List<String>? baseurllist = await getBaseUrlList();
      // HomeService _homeService=HomeService();
      final String url = loginUrl(baseUrl);
      var uri=Uri.parse(url);
      final response = await http.post(
        uri,
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
        setUserName(username);
        setLoggedIn(true);
        setName(fullname);
        var cookie = response.headers['set-cookie'];
        String cookieSid = cookie!.split(';').first.toString();
        setCookie(cookieSid);
        await CommonService().setGlobalDefaults(context);
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

  
}
