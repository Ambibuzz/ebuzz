import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_alert_dailog.dart';
import 'package:ebuzz/login/ui/login.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

//Exception handling code
exception(e, BuildContext context) {
  if (e is Exception) {
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.sendTimeout:
          customAlertDialog(
              context: context,
              content: Text('Send Timeout'),
              title: Text(
                'Something went wrong!',
                style: TextStyle(fontSize: 18, color: blackColor),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 18, color: blueAccent),
                    ))
              ]);
          // fluttertoast(whiteColor, blueAccent, 'Send Timeout');
          break;
        case DioErrorType.cancel:
          customAlertDialog(
              context: context,
              content: Text('Request Cancelled'),
              title: Text(
                'Something went wrong!',
                style: TextStyle(fontSize: 18, color: blackColor),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 18, color: blueAccent),
                    ))
              ]);
          // fluttertoast(whiteColor, blueAccent, 'Request Cancelled');
          break;
        case DioErrorType.connectTimeout:
          customAlertDialog(
              context: context,
              content: Text('Connection Timeout'),
              title: Text(
                'Something went wrong!',
                style: TextStyle(fontSize: 18, color: blackColor),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 18, color: blueAccent),
                    ))
              ]);
          // fluttertoast(whiteColor, blueAccent, 'Connection Timeout');
          break;
        case DioErrorType.other:
          customAlertDialog(
              context: context,
              content: Text(
                  'Make sure that wifi or mobile data is turned on,then try again'),
              title: Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 18, color: blackColor),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 18, color: blueAccent),
                    ))
              ]);
          // fluttertoast(whiteColor, blueAccent, 'No Internet Connection');
          break;
        case DioErrorType.receiveTimeout:
          customAlertDialog(
              context: context,
              content: Text('Timeout'),
              title: Text(
                'Something went wrong!',
                style: TextStyle(fontSize: 18, color: blackColor),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: 18, color: blueAccent),
                    ))
              ]);
          // fluttertoast(whiteColor, blueAccent, 'Timeout');
          break;
        case DioErrorType.response:
          switch (e.response?.statusCode) {
            case 400:
              customAlertDialog(
                  context: context,
                  content: Text('Unauthorized Request'),
                  title: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 18, color: blueAccent),
                        ))
                  ]);
              // fluttertoast(whiteColor, blueAccent, 'Unauthorized Request');
              removeLoggedIn();
              break;
            case 401:
              customAlertDialog(
                  context: context,
                  content: Text('Unauthorized Request'),
                  title: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 18, color: blueAccent),
                        ))
                  ]);
              // fluttertoast(whiteColor, blueAccent, 'Unauthorized Request');
              removeLoggedIn();
              break;
            case 403:
              Get.off(Login());
              removeLoggedIn();
              break;
            case 404:
              customAlertDialog(
                  context: context,
                  content: Text('Not found'),
                  title: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 18, color: blueAccent),
                        ))
                  ]);
              // fluttertoast(whiteColor, blueAccent, 'Not found');
              break;
            case 408:
              customAlertDialog(
                  context: context,
                  content: Text('CRequest Timed Out'),
                  title: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 18, color: blueAccent),
                        ))
                  ]);
              // fluttertoast(whiteColor, blueAccent, 'Request Timed Out');
              break;
            case 409:
              customAlertDialog(
                  context: context,
                  content: Text('Conflict'),
                  title: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 18, color: blueAccent),
                        ))
                  ]);
              // fluttertoast(whiteColor, blueAccent, 'Conflict');
              break;
            case 500:
              customAlertDialog(
                  context: context,
                  content: Text('Internal Server Error'),
                  title: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 18, color: blueAccent),
                        ))
                  ]);
              // fluttertoast(whiteColor, blueAccent, 'Internal Server Error');
              break;
            case 503:
              customAlertDialog(
                  context: context,
                  content: Text('Service Unavailable'),
                  title: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 18, color: blueAccent),
                        ))
                  ]);
              // fluttertoast(whiteColor, blueAccent, 'Service Unavailable');
              break;
            default:
              var responseCode = e.response?.statusCode;
              customAlertDialog(
                  context: context,
                  content: Text('Received invalid status code: $responseCode'),
                  title: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 18, color: blackColor),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style: TextStyle(fontSize: 18, color: blueAccent),
                        ))
                  ]);
            // fluttertoast(whiteColor, blueAccent,
            //     'Received invalid status code: $responseCode');
          }
      }
    } else if (e is SocketException) {
      customAlertDialog(
          context: context,
          content: Text(
              'Make sure that wifi or mobile data is turned on,then try again'),
          title: Text(
            'No Internet Connection',
            style: TextStyle(fontSize: 18, color: blackColor),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 18, color: blueAccent),
                ))
          ]);
      // fluttertoast(whiteColor, blueAccent, 'No Internet Connection');
    } else {
      customAlertDialog(
          context: context,
          content: Text('Unexpected Error'),
          title: Text(
            'Something went wrong!',
            style: TextStyle(fontSize: 18, color: blackColor),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 18, color: blueAccent),
                ))
          ]);
      // fluttertoast(whiteColor, blueAccent, 'Unexpected Error');
    }
  }
}
