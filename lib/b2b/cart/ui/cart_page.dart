import 'dart:convert';

import 'package:ebuzz/b2b/cart/model/cart.dart';
import 'package:ebuzz/b2b/cart/service/cart_service.dart';
import 'package:ebuzz/b2b/cart/state/state_manager.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/round_button.dart';
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
  bool _loading = false;

  CartService _cartService = CartService();

  void postQuotation(List<Cart> items, BuildContext context) async {
    setState(() {
      _loading = true;
    });
    await _cartService.postQuotation(items, context);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueAccent,
        title: Text('Cart Page'),
        actions: [],
      ),
      body: _loading
          ? CircularProgress()
          : Consumer(builder: (
              builder,
              watch,
              _,
            ) {
              var items = watch(cartListProvider.state);
              return Column(
                children: [
                  Expanded(
                    child: cartList(items),
                  ),
                  postQuotationWidget(items, context),
                  // IconButton(
                  //     onPressed: () async {
                  //       context.read(cartListProvider).removeAll(items);
                  //       await storage.write(
                  //           key: cartKey,
                  //           value: json
                  //               .encode(context.read(cartListProvider).state));
                  //     },
                  //     icon: Icon(Icons.delete)),
                ],
              );
            }),
    );
  }

  Widget cartList(List<Cart> items) {
    return ListView.builder(
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
                      value: json.encode(context.read(cartListProvider).state));
                },
              )
            ],
            child: Card(
              elevation: 8,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // cartItemImage(items, index),
                    cartItemName(items, index),
                    cartIncDecButton(items, index)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget cartItemImage(List<Cart> items, int index) {
    return Expanded(
        flex: 2,
        child: ClipRRect(
          child: Image(
            image: NetworkImage(items[index].imageUrl),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ));
  }

  Widget cartItemName(List<Cart> items, int index) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
    );
  }

  Widget cartIncDecButton(List<Cart> items, int index) {
    return Center(
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
          await storage.write(key: cartKey, value: json.encode(items));
          setState(() {});
        },
      ),
    );
  }

  Widget postQuotationWidget(List<Cart> items, BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        RoundButton(
          onPressed: () => postQuotation(items, context),
          child: Text('Post Quotation'),
          primaryColor: _loading ? greyColor : blueAccent,
          onPrimaryColor: whiteColor,
        ),
      ],
    );
  }
}
