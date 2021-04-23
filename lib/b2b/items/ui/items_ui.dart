import 'dart:convert';
import 'dart:ui';
import 'package:badges/badges.dart';
import 'package:ebuzz/b2b/cart/model/cart.dart';
import 'package:ebuzz/b2b/cart/state/state_manager.dart';
import 'package:ebuzz/b2b/cart/ui/cart_page.dart';
import 'package:ebuzz/b2b/items/model/brand_model.dart';
import 'package:ebuzz/b2b/items/model/item_group.dart';
import 'package:ebuzz/b2b/items/model/items_model.dart';
import 'package:ebuzz/b2b/items/service/items_api_service.dart';
import 'package:ebuzz/b2b/items/ui/items_detail_widget.dart';
import 'package:ebuzz/b2b/search/search_page.dart';
import 'package:ebuzz/common/circular_progress.dart';
import 'package:ebuzz/common/colors.dart';
import 'package:ebuzz/common/display_helper.dart';
import 'package:ebuzz/common/navigations.dart';
import 'package:ebuzz/common/round_button.dart';
import 'package:ebuzz/common/textstyles.dart';
import 'package:ebuzz/util/constants.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ItemsUi extends StatefulWidget {
  @override
  _ItemsUiState createState() => _ItemsUiState();
}

enum SortBy { itemNameAsc, itemNameDesc, itemCodeDesc, itemCodeAsc }

class _ItemsUiState extends State<ItemsUi> {
  List<ItemsModel> itemsList = [];
  ItemsApiService _itemsApiService = ItemsApiService();
  List<String> fullItemList = [];
  bool _loading = false;
  List<ItemGroupModel> itemGroupList = [];
  List<BrandModel> brandList = [];
  String groupText = '';
  String brandText = '';
  String weightText;
  bool reset = false;
  final weight1Controller = TextEditingController();
  final weight2Controller = TextEditingController();
  List<String> weightList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getItem(String item) async {
    itemsList.clear();
    itemsList = await _itemsApiService.getItem(item);
    setState(() {});
  }

  void navigateToSearchPage() async {
    String item;
    var list = await _itemsApiService.getAllItemsList();
    item = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => SearchPage(itemsList: list)));
    if (item.isNotEmpty) {
      getItem(item);
    }
  }

  void getData() async {
    setState(() {
      _loading = true;
    });
    await getItemsList();
    // sortByItemNameAsc();
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
    itemsList = await _itemsApiService.getItemGroupData(itemGroupName);
    setState(() {});
  }

  void getItemBrandData(String brandName) async {
    itemsList.clear();
    itemsList = await _itemsApiService.getItemBrandData(brandName);
    setState(() {});
  }

  void getItemWeightData() async {
    itemsList.clear();
    itemsList = await _itemsApiService.getItemWeightData(
        weight1Controller.text, weight2Controller.text);
    setState(() {});
  }

  setItemList() async {
    itemsList = await _itemsApiService.itemsList();
    setState(() {});
  }

  void getItemGroupAndWeightData(
      String itemGroup, String weight1, String weight2) async {
    itemsList.clear();
    itemsList = await _itemsApiService.getItemGroupAndWeightData(
        itemGroup, weight1, weight2);
    setState(() {});
  }

  void getItemBrandAndWeightData(
      String brand, String weight1, String weight2) async {
    itemsList.clear();
    itemsList = await _itemsApiService.getItemBrandAndWeightData(
        brand, weight1, weight2);
    setState(() {});
  }

  void getItemGroupWeight1Data(String itemGroup, String weight1) async {
    itemsList.clear();
    itemsList =
        await _itemsApiService.getItemGroupWeight1Data(itemGroup, weight1);
    setState(() {});
  }

  void getItemGroupWeight2Data(String itemGroup, String weight2) async {
    itemsList.clear();
    itemsList =
        await _itemsApiService.getItemGroupWeight2Data(itemGroup, weight2);
    setState(() {});
  }

  void getItemBrandWeight1Data(String brand, String weight1) async {
    itemsList.clear();
    itemsList = await _itemsApiService.getItemBrandWeight1Data(brand, weight1);
    setState(() {});
  }

  void getItemBrandWeight2Data(String brand, String weight2) async {
    itemsList.clear();
    itemsList = await _itemsApiService.getItemBrandWeight2Data(brand, weight2);
    setState(() {});
  }

  void addFilter(BuildContext dialogContext) async {
    reset
        ? print('reset initiated')
        : groupText.isNotEmpty &&
                weight1Controller.text.isNotEmpty &&
                weight2Controller.text.isNotEmpty
            ? getItemGroupAndWeightData(
                groupText, weight1Controller.text, weight2Controller.text)
            : brandText.isNotEmpty &&
                    weight1Controller.text.isNotEmpty &&
                    weight2Controller.text.isNotEmpty
                ? getItemBrandAndWeightData(
                    brandText, weight1Controller.text, weight2Controller.text)
                : groupText.isNotEmpty &&
                        weight1Controller.text.isNotEmpty &&
                        weight2Controller.text.isEmpty
                    ? getItemGroupWeight1Data(groupText, weight1Controller.text)
                    : groupText.isNotEmpty &&
                            weight1Controller.text.isEmpty &&
                            weight2Controller.text.isNotEmpty
                        ? getItemGroupWeight2Data(
                            groupText, weight2Controller.text)
                        : brandText.isNotEmpty &&
                                weight1Controller.text.isNotEmpty &&
                                weight2Controller.text.isEmpty
                            ? getItemBrandWeight1Data(
                                brandText, weight1Controller.text)
                            : brandText.isNotEmpty &&
                                    weight1Controller.text.isEmpty &&
                                    weight2Controller.text.isNotEmpty
                                ? getItemBrandWeight2Data(
                                    brandText, weight2Controller.text)
                                : groupText.isNotEmpty
                                    ? getItemGroupData(groupText)
                                    : brandText.isNotEmpty
                                        ? getItemBrandData(brandText)
                                        : getItemWeightData();
    Navigator.pop(dialogContext);
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
                                reset = false;
                              });
                            },
                            items: brandList
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
                        SizedBox(
                          height: displayHeight(context) * 0.015,
                        ),
                        Text('Search by Weight (Grams)'),
                        SizedBox(
                          height: displayHeight(context) * 0.015,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: weight1Controller,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  reset = false;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Weight (From)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: weight2Controller,
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  reset = false;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Weight (To)',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                                setState(() {
                                  reset = true;
                                  groupText = itemGroupList[0].name;
                                  brandText = brandList[0].name;
                                  weight1Controller.text = '';
                                  weight2Controller.text = '';
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
                onPressed: () => addFilter(dialogContext),
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
        },
      ),
    );
  }

  Future getItemsList() async {
    fullItemList = await _itemsApiService.getAllItemsList();
    itemGroupList = await _itemsApiService.itemGroupList();
    itemsList = await _itemsApiService.itemsList();
    // itemsListCopy = itemsList;
    brandList = await _itemsApiService.brandList();
    setState(() {});
  }

  bool isExistsInCart(List<Cart> state, Cart cartItem) {
    bool found = false;
    state.forEach((element) {
      if (element.id == cartItem.id) found = true;
    });
    return found;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueAccent,
        title: Text('Items'),
        actions: [
          search(),
          cart(),
          filter(),
          // sortby(),
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
              : itemsListView(),
    );
  }

  Widget search() {
    return Padding(
      padding: EdgeInsets.only(right: 0),
      child: IconButton(
          icon: Icon(
            Icons.search,
            color: whiteColor,
          ),
          onPressed: navigateToSearchPage),
    );
  }

  Widget itemsListView() {
    return ListView.builder(
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          ItemsModel item = itemsList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
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
                title: Text(item.itemName),
                subtitle: Text(item.itemCode),
                trailing: GestureDetector(
                  onTap: () => addToCart(item),
                  child: Icon(Icons.add_shopping_cart, color: blueAccent),
                ),
                onTap: () => navigateToItemDetailPage(item),
              ),
            ),
          );
        });
  }

  void addToCart(ItemsModel item) async {
    var storage = FlutterSecureStorage();
    double rate =
        await _itemsApiService.getPriceForItem(item.itemCode, context);
    print(rate);
    final cartItem = Cart(
        id: item.itemCode,
        imageUrl: item.image,
        itemName: item.itemName,
        quantity: item.quantity,
        itemCode: item.itemCode,
        rate: rate);
    var cartInstance = context.read(cartListProvider);
    if (rate != null) {
      if (isExistsInCart(cartInstance.state, cartItem))
        context.read(cartListProvider).edit(cartItem, 1);
      else {
        context.read(cartListProvider).add(cartItem);
        var string = json.encode(context.read(cartListProvider).state);
        await storage.write(key: cartKey, value: string);
      }
    }
  }

  void navigateToItemDetailPage(ItemsModel item) async {
    String baseurl = await getApiUrl();
    pushScreen(
        context,
        ItemsDetailWidget(
          itemCode: item.itemCode,
          apiurl: baseurl,
        ));
  }

  Widget cart() {
    return Consumer(builder: (context, watch, _) {
      return Badge(
        position: BadgePosition(top: 0, end: 1),
        animationDuration: Duration(
          milliseconds: 500,
        ),
        animationType: BadgeAnimationType.scale,
        showBadge: true,
        badgeColor: Colors.red,
        child: IconButton(
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: whiteColor,
            ),
            onPressed: () {
              pushScreen(context, CartPage());
            }),
        badgeContent: Text(
          '${watch(cartListProvider.state).length}',
          style: TextStyle(color: whiteColor),
        ),
      );
    });
  }

  // Widget sortby() {
  //   return IconButton(
  //     onPressed: () => displayBottomSheet(context),
  //     icon: Icon(Icons.sort),
  //   );
  // }

  Widget filter() {
    return IconButton(
        icon: Icon(
          Icons.filter_list,
          color: whiteColor,
        ),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (dialogContext) => filterDialog(dialogContext),
          );
        });
  }
}
