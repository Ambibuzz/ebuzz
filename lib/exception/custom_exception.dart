import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/login/ui/login.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:get/get.dart';

//Exception handling code
exception(e) {
  if (e is Exception) {
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.SEND_TIMEOUT:
          fluttertoast(whiteColor, blueAccent, 'Send Timeout');
          break;
        case DioErrorType.CANCEL:
          fluttertoast(whiteColor, blueAccent, 'Request Cancelled');
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          fluttertoast(whiteColor, blueAccent, 'Connection Timeout');
          break;
        case DioErrorType.DEFAULT:
          fluttertoast(whiteColor, blueAccent, 'No Internet Connection');
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          fluttertoast(whiteColor, blueAccent, 'Timeout');
          break;
        case DioErrorType.RESPONSE:
          switch (e.response.statusCode) {
            case 400:
              fluttertoast(whiteColor, blueAccent, 'Unauthorized Request');
              removeLoggedIn();
              break;
            case 401:
              fluttertoast(whiteColor, blueAccent, 'Unauthorized Request');
              removeLoggedIn();
              break;
            case 403:
              fluttertoast(whiteColor, blueAccent,
                  'Cookie expired or access is denied...');
              Get.off(Login());
              removeLoggedIn();
              break;
            case 404:
              fluttertoast(whiteColor, blueAccent, 'Not found');
              break;
            case 408:
              fluttertoast(whiteColor, blueAccent, 'Request Timed Out');
              break;
            case 409:
              fluttertoast(whiteColor, blueAccent, 'Conflict');
              break;
            case 500:
              fluttertoast(whiteColor, blueAccent, 'Internal Server Error');
              break;
            case 503:
              fluttertoast(whiteColor, blueAccent, 'Service Unavailable');
              break;
            default:
              var responseCode = e.response.statusCode;
              fluttertoast(whiteColor, blueAccent,
                  'Received invalid status code: $responseCode');
          }
      }
    } else if (e is SocketException) {
      fluttertoast(whiteColor, blueAccent, 'No Internet Connection');
    } else {
      fluttertoast(whiteColor, blueAccent, 'Unexpected Error');
    }
  }
}
