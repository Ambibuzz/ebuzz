import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ebuzz/b2b/cart/model/cart.dart';
import 'package:ebuzz/b2b/cart/model/quotation_model.dart';
import 'package:ebuzz/b2b/cart/state/state_manager.dart';
import 'package:ebuzz/b2b/quotationplaced/quotation_placed.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_alert_dailog.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/login/ui/login.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/util/constants.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class CartService {
  Future postQuotation(List<Cart> items, BuildContext context) async {
    var storage = FlutterSecureStorage();
    List<QuotationItems> qoitems = [];
    String name;
    double price;
    double qty;
    int qtyInt;
    int priceInt;
    items.map((cart) {
      qoitems.add(QuotationItems(
          itemcode: cart.itemCode, quantity: cart.quantity, rate: cart.rate));
    }).toList();
    QuotationModel _quotationModel =
        QuotationModel(currency: 'INR', quotationitems: qoitems);
    final String url = quotationUrl();
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final response = await _dio.post(url, data: _quotationModel);
      if (response.statusCode == 200) {
        var data = response.data;
        print(response.data);
        name = data['data']['name'];
        price = data['data']['base_rounded_total'];
        qty = data['data']['total_qty'];
        qtyInt = qty.toInt();
        priceInt = price.toInt();
        context.read(cartListProvider).removeAll(items);
        await storage.write(
            key: cartKey,
            value: json.encode(context.read(cartListProvider).state));
        pushReplacementScreen(
            context,
            QuotationPlaced(
              icon: Icons.check_circle_rounded,
              name: name,
              statusText: 'Your Quotation has been placed successfully',
              iconColor: blueAccent,
              qty: qtyInt,
              totalPrice: priceInt,
            ));
        // Navigator.pop(context);
      } else if (response.statusCode == 417) {
        pushReplacementScreen(
          context,
          QuotationPlaced(
            icon: Icons.cancel,
            name: null,
            statusText: 'Your Quotation has not been placed',
            iconColor: redColor,
          ),
        );
      }
    } catch (e) {
      // exception(e);
      if (e is Exception) {
        if (e is DioError) {
          switch (e.type) {
            case DioErrorType.SEND_TIMEOUT:
              fluttertoast(
                whiteColor,
                blueAccent,
                'Send Timeout',
              );
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
                case 417:
                  customAlertDialog(
                      context: context,
                      content: Text(
                          'Your Quotation has not been placed please try again after sometime'),
                      title: Text(
                        'Something went wrong!',
                        style: TextStyles.t18BlackBold,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'OK',
                              style: TextStyles.t18Blue,
                            ))
                      ]);
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
  }
}
