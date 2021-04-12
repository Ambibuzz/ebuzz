import 'dart:convert';
import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/item/service/item_api_service.dart';

import 'package:ebuzz/item/model/product.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:ebuzz/widgets/item_detail_widget.dart';
import 'package:ebuzz/widgets/unique_warehouse_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:http/http.dart' as http;

//ItemUi class contains ui for displaying details of particular product based on itemname,itemcode,barcode choosen by user
class ItemUi extends StatefulWidget {
  @override
  _ItemUiState createState() => _ItemUiState();
}

class _ItemUiState extends State<ItemUi> {
  List<String> listItems = [];
  List<String> listItemName = [];
  List<String> listItemCode = [];
  bool apiCall = false;
  String itemCode;
  List<String> warehouseName = [];
  List<double> warehouseQty = [];
  ItemApiService _itemApiService = ItemApiService();
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String apiurl;
  bool loading = false;
  bool searchButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    getItemList();
  }

  //For storing itemcode and itemname in list
  getItemList() async {
    apiurl = await getApiUrl();
    try {
      setState(() {
        loading = true;
      });
      List listData = await _itemApiService.getItemList();
      for (int i = 0; i < listData.length; i++) {
        listItems.add(listData[i]['item_name']);
        listItemName.add(listData[i]['item_name']);
      }
      for (int i = 0; i < listData.length; i++) {
        listItems.add(listData[i]['item_code']);
        listItemCode.add(listData[i]['item_code']);
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      throw Exception(e.toString());
    }
    setState(() {});
  }

  //For fetching item data
  fetchItem() async {
    try {
      final String cookie = await getCookie();
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie
      };
      String baseurl = await getApiUrl();
      final String url = itemDataUrl(searchController.text);
      final String itemCodeUrl = baseurl + url;
      final response = await http.get(itemCodeUrl, headers: requestHeaders);
      final String itemName = specificItemNameSearchUrl(searchController.text);
      final String itemNameUrl = baseurl + itemName;
      setState(() {
        searchButtonDisabled = true;
      });
      final itemNameResponse = await http.get(
        itemNameUrl,
        headers: requestHeaders,
      );
      if (itemNameResponse.statusCode == 200) {
        var data = jsonDecode(itemNameResponse.body);
        var list = data['data'];
        if (list.length == 1) {
          itemCode = data['data'][0]['item_code'];
          warehouseName = await _itemApiService.getWareHouseNameData(itemCode);
          warehouseQty = await _itemApiService.getWareHouseQtyData(itemCode);
          apiCall = true;
          setState(() {});
        }
      }
      if (response.statusCode == 200) {
        itemCode = searchController.text;
        warehouseName = await _itemApiService.getWareHouseNameData(itemCode);
        warehouseQty = await _itemApiService.getWareHouseQtyData(itemCode);
        apiCall = true;
        setState(() {});
      }
      setState(() {
        searchButtonDisabled = false;
      });
    } catch (e) {
      exception(e);
      
    }
  }

  Widget itemUi(String item) {
    return ListTile(
      title: Text(item,
          style: displayWidth(context) > 600
              ? TextStyle(fontSize: 28, color: blackColor)
              : TextStyle(color: greyDarkColor, fontSize: 16)),
    );
  }

  //For scanning barcode and storing result of it as string
  scanBarCode() async {
    String result = await FlutterBarcodeScanner.scanBarcode(
        '#004297', 'Cancel', true, ScanMode.BARCODE);
    String itemCode = await _itemApiService.getItemCodeFromBarcode(result);
    searchController.text = itemCode;
    setState(() {});
  }

  search() async {
    if (searchController.text.isNotEmpty) {
      fetchItem();
    }
    if (searchController.text.isEmpty) {
      fluttertoast(whiteColor, blueAccent, 'Search field should not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(displayWidth(context) > 600 ? 80 : 55),
          child: CustomAppBar(
            title: 'Item',
          )),
      body: loading
          ? CircularProgress()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: searchField(),
                      ),
                      GestureDetector(
                        onTap: scanBarCode,
                        child: Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.camera_alt,
                            color: blackColor,
                            size: displayWidth(context) > 600 ? 45 : 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  searchButton(),
                  apiCall
                      ? FutureBuilder<Product>(
                          future: _itemApiService.getData(itemCode),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                  height: displayHeight(context) * 0.55,
                                  child: CircularProgress());
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
                              return Column(
                                children: [
                                  ItemDetailWidget(
                                    snapshot: snapshot,
                                    apiurl: apiurl,
                                  ),
                                  warehouseName == null ||
                                          warehouseName.length == 0
                                      ? Text('No Warehouse data found',
                                          style: displayWidth(context) > 600
                                              ? TextStyles.t24Black
                                              : TextStyles.t18Black)
                                      : Column(
                                          children: [
                                            UniqueWarehouseList(
                                              warehouseName: warehouseName,
                                              warehouseQty: warehouseQty,
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.05,
                                  ),
                                ],
                              );
                            }
                            return Container(
                                height: displayHeight(context) * 0.55,
                                child: CircularProgress());
                          },
                        )
                      : Container(),
                ],
              ),
            ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: AutoCompleteTextField<String>(
        controller: searchController,
        itemSubmitted: (item) {
          searchController.text = item;
        },
        key: key,
        clearOnSubmit: false,
        style: displayWidth(context) > 600
            ? TextStyle(fontSize: 28, color: blackColor)
            : TextStyle(color: blackColor, fontSize: 18),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: blackColor, width: 1, style: BorderStyle.solid),
          ),
          labelStyle: TextStyle(
            fontSize: displayWidth(context) > 600 ? 28 : 16,
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: displayWidth(context) > 600 ? 30 : 20,
              horizontal: displayWidth(context) > 600 ? 20 : 10),
          labelText: 'Search Item',
        ),
        suggestions: listItems,
        itemBuilder: (context, item) {
          return itemUi(item);
        },
        itemSorter: (a, b) {
          return a.compareTo(b);
        },
        itemFilter: (item, query) {
          return item.toLowerCase().startsWith(query.toLowerCase());
        },
      ),
    );
  }

  Widget searchButton() {
    return Container(
      height: displayWidth(context) > 600 ? 80 : 50,
      child:
      RoundButton(
          child: Text("Search", style: TextStyles.t16WhiteBold),
          onPressed: searchButtonDisabled ? null : search,
          primaryColor: blueAccent,
          onPrimaryColor: whiteColor,
        ),
    );
  }
}
