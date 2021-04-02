import 'dart:convert';
import 'dart:ui';
import 'package:ebuzz/b2b/items/model/brand_model.dart';
import 'package:ebuzz/b2b/items/model/item_group.dart';
import 'package:ebuzz/b2b/items/model/items_model.dart';
import 'package:ebuzz/b2b/items/service/items_api_service.dart';
import 'package:ebuzz/b2b/search/search_page.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemsUi extends StatefulWidget {
  @override
  _ItemsUiState createState() => _ItemsUiState();
}

class _ItemsUiState extends State<ItemsUi> {
  List<ItemsModel> itemsList = [];
  ItemsApiService _itemsApiService = ItemsApiService();
  String baseurl;
  List<String> fullItemList = [];
  bool _loading = false;
  List<ItemGroupModel> itemGroupList = [];
  List<BrandModel> brandList = [];
  String groupText = '';
  String brandText = '';
  bool reset = false;
  final weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getItem(String item) async {
    itemsList.clear();
    // Dio _dio = await BaseDio().getBaseDio();
    // String itemCodeUrl = itemDataUrl(item);
    // String itemNameUrl = itemNameSearchUrl(item);
    // var itemCodeResponse = await _dio.get(itemCodeUrl);
    // var itemNameResponse = await _dio.get(itemNameUrl);
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String baseurl = await getApiUrl();
    final String codeurl = itemDataUrl(item);
    final String nameurl = specificItemNameSearchUrl(item);
    final String itemCodeUrl = baseurl + codeurl;
    final String itemNameUrl = baseurl + nameurl;

    final itemCodeResponse =
        await http.get(itemCodeUrl, headers: requestHeaders);

    // final String itemgroup = itemGroupDataUrl(item);
    // final String itemGroupUrl = baseurl + itemgroup;
    // final itemGroupResponse =
    //     await http.get(itemGroupUrl, headers: requestHeaders);
    if (itemCodeResponse.statusCode == 200) {
      print('Item Code');
      var data = jsonDecode(itemCodeResponse.body);
      String itemCode = data['data']['item_code'];
      String itemName = data['data']['item_name'];
      String image = data['data']['image'];
      itemsList.add(ItemsModel(itemName, itemCode, image));
      setState(() {});
    } else {
      print("Item Name");
      final itemNameResponse =
          await http.get(itemNameUrl, headers: requestHeaders);
      if (itemNameResponse.statusCode == 200) {
        var data = jsonDecode(itemNameResponse.body);
        String itemName = data['data'][0]['item_name'];
        String itemCode = data['data'][0]['item_code'];
        String image = data['data'][0]['image'];
        itemsList.add(ItemsModel(itemName, itemCode, image));
        setState(() {});
      }

      // print("Item Group");
      // var data = jsonDecode(itemGroupResponse.body);
      // List list = data['data'];
      // list.forEach((item) {
      //   String itemName = item['item_name'];
      //   String itemCode = item['item_code'];
      //   String image = item['image'];
      //   itemsList.add(ItemsModel(itemName, itemCode, image));
      //   setState(() {});
      // });
    }
  }

  void navigateToSearchPage() async {
    String item;
    var list = await _itemsApiService.getAllItemsList();
    item = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SearchPage(itemsList: list)));
    print(item);
    if (item.isNotEmpty) {
      print('not empty');
      getItem(item);
    }
  }

  void getData() async {
    setState(() {
      _loading = true;
    });
    await getItemsList();
    setState(() {
      _loading = false;
    });
  }

  Future resetAll() async {
    itemsList = await _itemsApiService.itemsList();
    setState(() {
      reset = true;
      groupText = itemGroupList[0].name;
      brandText = brandList[0].name;
    });
  }

  void getItemGroupData(String itemGroupName) async {
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String baseurl = await getApiUrl();
    final String itemgroup = itemGroupDataUrl(itemGroupName);
    final String itemGroupUrl = baseurl + itemgroup;
    final itemGroupResponse =
        await http.get(itemGroupUrl, headers: requestHeaders);
    var data = jsonDecode(itemGroupResponse.body);
    List list = data['data'];
    list.forEach((item) {
      String itemName = item['item_name'];
      String itemCode = item['item_code'];
      String image = item['image'];
      itemsList.add(ItemsModel(itemName, itemCode, image));
    });
    print(itemsList.length);
    setState(() {});
  }

  void getItemBrandData(String brandName) async {
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String baseurl = await getApiUrl();
    final String itemBrand = brandDataUrl(brandName);
    final String brandUrl = baseurl + itemBrand;
    final itemBrandResponse = await http.get(brandUrl, headers: requestHeaders);
    var data = jsonDecode(itemBrandResponse.body);
    List list = data['data'];
    list.forEach((item) {
      String itemName = item['item_name'];
      String itemCode = item['item_code'];
      String image = item['image'];
      itemsList.add(ItemsModel(itemName, itemCode, image));
    });
    print(itemsList.length);
    setState(() {});
  }

  void getItemWeightData() async {
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    double weightInGrams = double.parse(weightController.text.toString());
    String weightInKg = (weightInGrams / 1000).toString();
    String baseurl = await getApiUrl();
    final String itemweight = itemWeightUrl(weightInKg);
    final String weightUrl = baseurl + itemweight;
    final itemWeightResponse =
        await http.get(weightUrl, headers: requestHeaders);
    var data = jsonDecode(itemWeightResponse.body);
    List list = data['data'];
    list.forEach((item) {
      String itemName = item['item_name'];
      String itemCode = item['item_code'];
      String image = item['image'];
      itemsList.add(ItemsModel(itemName, itemCode, image));
    });
    print(itemsList.length);
    setState(() {});
  }

  setItemList() async {
    itemsList = await _itemsApiService.itemsList();
    setState(() {});
  }

  void getItemGroupAndWeightData(String itemGroup, String weight) async {
    print(itemGroup);
    print(weight);
    print('itemgroupandweight');
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    double weightInGrams = double.parse(weight.toString());
    String weightInKg = (weightInGrams / 1000).toString();
    String baseurl = await getApiUrl();
    final String itemweight = itemGroupandWeightDataUrl(itemGroup, weightInKg);
    final String weightUrl = baseurl + itemweight;
    final itemWeightResponse =
        await http.get(weightUrl, headers: requestHeaders);
    var data = jsonDecode(itemWeightResponse.body);
    List list = data['data'];
    list.forEach((item) {
      String itemName = item['item_name'];
      String itemCode = item['item_code'];
      String image = item['image'];
      itemsList.add(ItemsModel(itemName, itemCode, image));
    });
    print(itemsList.length);
    setState(() {});
  }

  void getItemBrandAndWeightData(String brand, String weight) async {
    print(brand);
    print(weight);
    print('itembrandandweight');
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    double weightInGrams = double.parse(weight.toString());
    String weightInKg = (weightInGrams / 1000).toString();
    String baseurl = await getApiUrl();
    final String itemweight = itemBrandandWeightDataUrl(brand, weightInKg);
    final String weightUrl = baseurl + itemweight;
    final itemWeightResponse =
        await http.get(weightUrl, headers: requestHeaders);
    var data = jsonDecode(itemWeightResponse.body);
    List list = data['data'];
    list.forEach((item) {
      String itemName = item['item_name'];
      String itemCode = item['item_code'];
      String image = item['image'];
      itemsList.add(ItemsModel(itemName, itemCode, image));
    });
    print(itemsList.length);
    setState(() {});
  }

  Widget filterDialog(BuildContext dialogContext) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return AlertDialog(
          title: Text(
            'Search Filter',
            style: displayWidth(context) > 600
                ? TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Container(
              height: displayHeight(context) * 0.46,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: displayHeight(context) * 0.015,
                      ),
                      Text('Search by Group'),
                      SizedBox(
                        height: displayHeight(context) * 0.015,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text('Item Group'),
                          value: groupText.isNotEmpty ? groupText : null,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              groupText = newValue;
                              brandText = brandList[0].name;
                              // weightController.text = '';
                              reset = false;
                            });
                          },
                          items: itemGroupList
                              .map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Text(
                                value.name.toString(),
                                style: TextStyles.t14Black,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Text('Search by Brand'),
                      SizedBox(
                        height: displayHeight(context) * 0.015,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text('Brand'),
                          value: brandText.isNotEmpty ? brandText : null,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              brandText = newValue;
                              groupText = itemGroupList[0].name;
                              // weightController.text = '';
                              reset = false;
                            });
                          },
                          items:
                              brandList.map<DropdownMenuItem<String>>((value) {
                            return DropdownMenuItem<String>(
                              value: value.name,
                              child: Text(
                                value.name.toString(),
                                style: TextStyles.t14Black,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.015,
                      ),
                      Text('Search by Weight (Grams)'),
                      SizedBox(
                        height: displayHeight(context) * 0.015,
                      ),
                      TextFormField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // groupText = itemGroupList[0].name;
                          // brandText = brandList[0].name;

                          reset = false;
                        },
                        decoration: InputDecoration(
                            labelText: 'Weight in Grams',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.015,
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RoundButton(
                            onPressed: () async {
                              setItemList();
                              // itemsList = await _itemsApiService.itemsList();
                              // setState(() {});
                              // print(itemsList.length);
                              setState(() {
                                reset = true;
                                groupText = itemGroupList[0].name;
                                brandText = brandList[0].name;
                                weightController.text = '';
                              });
                            },
                            child: Text(
                              'Reset all',
                              style: TextStyles.t16WhiteBold,
                            ),
                            primaryColor: blueAccent,
                            onPrimaryColor: whiteColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                reset
                    ? print('reset initiated')
                    : groupText.isNotEmpty && weightController.text.isNotEmpty
                        ? getItemGroupAndWeightData(
                            groupText, weightController.text)
                        : brandText.isNotEmpty &&
                                weightController.text.isNotEmpty
                            ? getItemBrandAndWeightData(
                                brandText, weightController.text)
                            : groupText.isNotEmpty
                                ? getItemGroupData(groupText)
                                : brandText.isNotEmpty
                                    ? getItemBrandData(brandText)
                                    : getItemWeightData();
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Ok',
                style: displayWidth(context) > 600
                    ? TextStyle(fontSize: 26, color: blueAccent)
                    : TextStyle(fontSize: 16, color: blueAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: displayWidth(context) > 600
                    ? TextStyle(fontSize: 26, color: blueAccent)
                    : TextStyle(fontSize: 16, color: blueAccent),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future getItemsList() async {
    fullItemList = await _itemsApiService.getAllItemsList();
    print(fullItemList.length);
    itemGroupList = await _itemsApiService.itemGroupList();
    print(itemGroupList.length);
    itemsList = await _itemsApiService.itemsList();
    brandList = await _itemsApiService.brandList();
    print(brandList.length);
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
            padding: EdgeInsets.only(right: 0),
            child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: whiteColor,
                ),
                onPressed: navigateToSearchPage),
          ),
          IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                color: whiteColor,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.filter_list,
                color: whiteColor,
              ),
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (dialogContext) => filterDialog(dialogContext),
                );
              }),
        ],
      ),
      body: _loading
          ? CircularProgress()
          : itemsList.isEmpty
              ? Center(
                  child: Text(
                    'No Data',
                    style: TextStyles.t18BlackBold,
                  ),
                )
              : ListView.builder(
                  itemCount: itemsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          // leading:
                          // itemsList[index].image == '' ||
                          //         itemsList[index].image == null
                          //     ?
                          //     CircleAvatar(
                          //   radius: 20,
                          //   child: Image.asset(
                          //     'assets/inf.jpg',
                          //     fit: BoxFit.cover,
                          //   ),
                          //   backgroundColor: whiteColor,
                          // )
                          // : NetworkImage(baseurl + itemsList[index].image)
                          // ,
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
