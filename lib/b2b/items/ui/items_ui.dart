import 'package:ebuzz/b2b/items/model/items_model.dart';
import 'package:ebuzz/b2b/items/service/items_api_service.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:flutter/material.dart';

class ItemsUi extends StatefulWidget {
  @override
  _ItemsUiState createState() => _ItemsUiState();
}

class _ItemsUiState extends State<ItemsUi> {
  List<ItemsModel> itemsList = [];
  ItemsApiService _itemsApiService = ItemsApiService();
  String baseurl;

  @override
  void initState() {
    super.initState();
    getItemsList();
  }

  getItemsList() async {
    itemsList = await _itemsApiService.itemsList();
    baseurl = await getApiUrl();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueAccent,
        title: Text('Items'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: whiteColor,
            ),
          ),
        ],
      ),
      body: itemsList.length == 0
          ? CircularProgress()
          : ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading:
                          // itemsList[index].image == '' ||
                          //         itemsList[index].image == null
                          //     ?
                          CircleAvatar(
                        radius: 20,
                        child: Image.asset(
                          'assets/inf.jpg',
                          fit: BoxFit.cover,
                        ),
                        backgroundColor: whiteColor,
                      )
                      // : NetworkImage(baseurl + itemsList[index].image)
                      ,
                      title: Text(itemsList[index].itemCode),
                      subtitle: Text(itemsList[index].itemName),
                      trailing:
                          Icon(Icons.add_shopping_cart, color: blueAccent),
                    ),
                  ),
                );
              }),
    );
  }
}
