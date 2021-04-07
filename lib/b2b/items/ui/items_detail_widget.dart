import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/item/model/product.dart';
import 'package:ebuzz/item/service/item_api_service.dart';
import 'package:ebuzz/widgets/item_detail_widget.dart';
import 'package:flutter/material.dart';

class ItemsDetailWidget extends StatelessWidget {
  final String itemCode;
  final String apiurl;

  const ItemsDetailWidget({this.itemCode, this.apiurl});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
        child: CustomAppBar(
          title: 'Item Detail',
        ),
      ),
      body: FutureBuilder<Product>(
        future: ItemApiService().getData(itemCode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgress();
          }
          if (snapshot.hasError) {
            return Container(
                height: displayHeight(context) * 0.9,
                child: Center(
                    child: Text(
                  'No Data Found',
                  style: TextStyle(fontSize: 20),
                )));
          }
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ItemDetailWidget(
                    snapshot: snapshot,
                    apiurl: apiurl,
                  ),
                 
                ],
              ),
            );
          }
          return 
                CircularProgress();
        },
      ),
    );
  }
}
