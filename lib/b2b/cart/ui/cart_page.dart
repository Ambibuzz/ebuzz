import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ebuzz/b2b/cart/model/quotation_model.dart';
import 'package:ebuzz/b2b/cart/state/state_manager.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var storage = FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'Cart Page',
        ),
      ),
      body: Consumer(builder: (
        builder,
        watch,
        _,
      ) {
        var items = watch(cartListProvider.state);
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    print('item $index is ${items[index].quantity}');
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Delete',
                          icon: Icons.delete,
                          color: Colors.red,
                          onTap: () async {
                            context.read(cartListProvider).remove(items[index]);
                            await storage.write(
                                key: cartKey,
                                value: json.encode(
                                    context.read(cartListProvider).state));
                          },
                        )
                      ],
                      child: Card(
                        elevation: 8,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Expanded(
                              //     flex: 2,
                              //     child: ClipRRect(
                              //       child: Image(
                              //         image:
                              //             NetworkImage(items[index].imageUrl),
                              //         fit: BoxFit.fill,
                              //       ),
                              //       borderRadius: BorderRadius.all(
                              //         Radius.circular(10),
                              //       ),
                              //     )),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Text(
                                          items[index].itemName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                flex: 6,
                              ),
                              Center(
                                child: ElegantNumberButton(
                                  initialValue: items[index].quantity,
                                  buttonSizeWidth: 25,
                                  buttonSizeHeight: 20,
                                  color: whiteColor,
                                  minValue: 0,
                                  maxValue: 1000,
                                  decimalPlaces: 0,
                                  onChanged: (value) async {
                                    //update quantity
                                    items[index].quantity = value;
                                    var string = json.encode(items);
                                    print(string);
                                    await storage.write(
                                        key: cartKey,
                                        value: json.encode(items));
                                    setState(() {});
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                RoundButton(
                    onPressed: () async {
                      List<QuotationItems> qoitems = [];
                      items.map((cart) {
                        qoitems.add(QuotationItems(
                            itemcode: cart.itemCode,
                            quantity: cart.quantity,
                            rate: cart.rate));
                      }).toList();
                      QuotationModel _quotationModel = QuotationModel(
                          currency: 'INR', quotationitems: qoitems);
                      final String url = quotationUrl();
                      Dio _dio = await BaseDio().getBaseDio();
                      final response =
                          await _dio.post(url, data: _quotationModel);
                      if (response.statusCode == 200) {
                        print(response.data);
                        fluttertoast(whiteColor, blueAccent,
                            'Quotation Posted Successfully');
                      }
                    },
                    child: Text('Get Quotation'),
                    primaryColor: blueAccent,
                    onPrimaryColor: whiteColor),
              ],
            ),
          ],
        );
      }),
    );
  }
}
