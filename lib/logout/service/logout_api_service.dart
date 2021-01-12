import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/login/ui/login.dart';

import 'package:ebuzz/util/preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/util/apiurls.dart';

//LogoutApiService class contains function for fetching data or posting  data
class LogOutApiService {
  Future logOut(BuildContext context, String apiurl) async {
    try {
      final String logOutUrl = logoutUrl(apiurl);
      var response = await http.get(
        logOutUrl,
      );
      if (response.statusCode == 200) {
        removeLoggedIn();
        removeApiUrl();
        removeCookie();
        removeName();
        pushReplacementScreen(context, Login());
      } else {
        if (response.statusCode == 400) {
          fluttertoast(whiteColor, redColor, 'Error Ocurred while LogOut');
        } else if (response.statusCode == 401) {
          fluttertoast(whiteColor, redColor, 'Error Ocurred while LogOut');
        } else {
          fluttertoast(whiteColor, redColor, 'Error Ocurred while LogOut');
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
