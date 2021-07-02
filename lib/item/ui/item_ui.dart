import 'dart:convert';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/custom_appbar.dart';
import 'package:ebuzz/common/custom_toast.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/common_models/product.dart';
import 'package:ebuzz/common_service/common_service.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/item/service/item_api_service.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:ebuzz/widgets/custom_typeahead_formfield.dart';
import 'package:ebuzz/widgets/item_detail_widget.dart';
import 'package:ebuzz/widgets/typeahead_widgets.dart';
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
  String itemCode = '';
  List<String> warehouseName = [];
  List<double> warehouseQty = [];
  ItemApiService _itemApiService = ItemApiService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String? apiurl;
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
      List listData = await CommonService().getItemList(context);
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
      final String? cookie = await getCookie();
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie!
      };
      String? baseurl = await getApiUrl();
      final String url = itemDataUrl(searchController.text);
      final String itemCodeUrl = baseurl! + url;
      var uri = Uri.parse(itemCodeUrl);
      final response = await http.get(uri, headers: requestHeaders);
      final String itemName = specificItemNameSearchUrl(searchController.text);
      final String itemNameUrl = baseurl + itemName;
      setState(() {
        searchButtonDisabled = true;
      });
      var itemNameUri = Uri.parse(itemNameUrl);

      final itemNameResponse = await http.get(
        itemNameUri,
        headers: requestHeaders,
      );
      if (itemNameResponse.statusCode == 200) {
        var data = jsonDecode(itemNameResponse.body);
        var list = data['data'];
        if (list.length == 1) {
          itemCode = data['data'][0]['item_code'];
          warehouseName =
              await CommonService().getWareHouseNameData(itemCode, context);
          warehouseQty =
              await CommonService().getWareHouseQtyData(itemCode, context);
          apiCall = true;
          setState(() {});
        }
      }
      if (response.statusCode == 200) {
        itemCode = searchController.text;
        warehouseName =
            await CommonService().getWareHouseNameData(itemCode, context);
        warehouseQty =
            await CommonService().getWareHouseQtyData(itemCode, context);
        apiCall = true;
        setState(() {});
      }
      setState(() {
        searchButtonDisabled = false;
      });
    } catch (e) {
      exception(e, context);
    }
  }

  Widget itemUi(String item) {
    return ListTile(
      title: Text(item,
          style:  TextStyle(color: greyDarkColor, fontSize: 16)),
    );
  }

  //For scanning barcode and storing result of it as string
  scanBarCode() async {
    String result = await FlutterBarcodeScanner.scanBarcode(
        '#004297', 'Cancel', true, ScanMode.BARCODE);
    String itemCode =
        await CommonService().getItemCodeFromBarcode(result, context);
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
          preferredSize: Size.fromHeight( 55),
          child: CustomAppBar(
            title: Text('Item', style: TextStyle(color: whiteColor)),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              ),
            ),
          )),
      body: loading
          ? CircularProgress()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
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
                            padding: EdgeInsets.only(top: 30, left: 10),
                            child: Icon(
                              Icons.camera_alt,
                              color: blackColor,
                              size: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    searchButton(),
                    apiCall
                        ? FutureBuilder<Product>(
                            future: _itemApiService.getData(itemCode, context),
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
                                      apiurl: apiurl!,
                                    ),
                                    warehouseName.isEmpty ||
                                            warehouseName.length == 0
                                        ? Text('No Warehouse data found',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: blackColor))
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
            ),
    );
  }

  Widget searchField() {
    return CustomTypeAheadFormField(
      controller: searchController,
      decoration: InputDecoration(
          fillColor: greyColor,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          )),
      label: 'Search',
      labelStyle: TextStyle(color: blackColor),
      required: true,
      style: TextStyle(fontSize: 14, color: blackColor),
      itemBuilder: (context, item) {
        return TypeAheadWidgets.itemUi(item);
      },
      onSuggestionSelected: (suggestion) async {
        searchController.text = suggestion;
      },
      suggestionsCallback: (pattern) {
        return TypeAheadWidgets.getSuggestions(pattern, listItems);
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      validator: (val) =>
          val == '' || val == null ? 'Search field should not be empty' : null,
    );
  }

  Widget searchButton() {
    return Container(
      width: displayWidth(context),
      height: 50,
      child: RoundButton(
        child:
            Text("Search", style: TextStyle(fontSize: 16, color: whiteColor)),
        onPressed: searchButtonDisabled ? null : search,
        primaryColor: blueAccent,
        onPrimaryColor: whiteColor,
      ),
    );
  }
}
