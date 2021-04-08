import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ebuzz/b2b/items/model/brand_model.dart';
import 'package:ebuzz/b2b/items/model/item_group.dart';
import 'package:ebuzz/b2b/items/model/items_model.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';
import 'package:ebuzz/util/preference.dart';
import 'package:http/http.dart' as http;

class ItemsApiService {
  Future<List<ItemsModel>> itemsList() async {
    List<ItemsModel> itemsList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemList = itemListUrl();
      final response = await _dio.get(
        itemList,
      );
      var data = response.data;
      List listData = data['data'];
      listData.forEach((itemData) {
        itemsList.add(ItemsModel.fromJson(itemData));
      });
      return itemsList;
    } catch (e) {
      exception(e);
    }
    return itemsList;
  }

  Future<List<ItemGroupModel>> itemGroupList() async {
    List<ItemGroupModel> itemGroupList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemGroup = itemGroupUrl();
      final response = await _dio.get(itemGroup);
      var data = response.data;
      List listData = data['data'];
      itemGroupList.clear();
      itemGroupList.insert(0, ItemGroupModel(name: ''));
      listData.forEach((itemGroup) {
        itemGroupList.add(ItemGroupModel.fromJson(itemGroup));
      });
      return itemGroupList;
    } catch (e) {
      exception(e);
    }
    return itemGroupList;
  }

  Future<List<BrandModel>> brandList() async {
    List<BrandModel> brandList = [];
    try {
      Dio _dio = await BaseDio().getBaseDio();
      final String itemGroup = brandListUrl();
      final response = await _dio.get(itemGroup);
      var data = response.data;
      brandList.clear();
      List listData = data['data'];
      brandList.insert(0, BrandModel(name: ''));
      listData.forEach((itemGroup) {
        brandList.add(BrandModel.fromJson(itemGroup));
      });
      return brandList;
    } catch (e) {
      exception(e);
    }
    return brandList;
  }

  Future<List<String>> getAllItemsList() async {
    List<String> fullItemList = [];
    try {
      List<ItemsModel> itemList = await itemsList();
      for (ItemsModel itemCode in itemList) {
        fullItemList.add(itemCode.itemCode);
      }
      for (ItemsModel itemName in itemList) {
        fullItemList.add(itemName.itemName);
      }
      return fullItemList;
    } catch (e) {
      exception(e);
    }
    return fullItemList;
  }

  Future<List<ItemsModel>> getItemBrandWeight2Data(
      String brand, String weight2) async {
    List<ItemsModel> itemsList = [];
    print('itembrandweight2');
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String weight1InKg = convertWeightInGramsToKg(weight2);
    String baseurl = await getApiUrl();
    final String itemweight = itemBrandandWeight2DataUrl(brand, weight1InKg);
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
    return itemsList;
  }

  Future<List<ItemsModel>> getItemBrandWeight1Data(
      String brand, String weight1) async {
    List<ItemsModel> itemsList = [];
    try {
      print('itembrandweight1');
      itemsList.clear();
      final String cookie = await getCookie();
      Map<String, String> requestHeaders = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Cookie': cookie
      };
      String weight1InKg = convertWeightInGramsToKg(weight1);
      String baseurl = await getApiUrl();
      final String itemweight = itemBrandandWeight1DataUrl(brand, weight1InKg);
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
      return itemsList;
    } catch (e) {
      exception(e);
    }

    return itemsList;
  }

  Future<List<ItemsModel>> getItemGroupWeight2Data(
      String itemGroup, String weight2) async {
    List<ItemsModel> itemsList = [];
    print('itemgroupweight2');
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String weight1InKg = convertWeightInGramsToKg(weight2);
    String baseurl = await getApiUrl();
    final String itemweight =
        itemGroupandWeight2DataUrl(itemGroup, weight1InKg);
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
    return itemsList;
  }

  Future<List<ItemsModel>> getItemGroupWeight1Data(
      String itemGroup, String weight1) async {
    List<ItemsModel> itemsList = [];
    print('itemgroupweight1');
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String weight1InKg = convertWeightInGramsToKg(weight1);
    String baseurl = await getApiUrl();
    final String itemweight =
        itemGroupandWeight1DataUrl(itemGroup, weight1InKg);
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
    return itemsList;
  }

  Future<List<ItemsModel>> getItemBrandAndWeightData(
      String brand, String weight1, String weight2) async {
    List<ItemsModel> itemsList = [];
    print('itembrandandweight');
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String weight1InKg = convertWeightInGramsToKg(weight1);
    String weight2InKg = convertWeightInGramsToKg(weight2);
    String baseurl = await getApiUrl();
    final String itemweight =
        itemBrandAndWeightDataSeriesUrl(brand, weight1InKg, weight2InKg);
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
    return itemsList;
  }

  Future<List<ItemsModel>> getItemGroupAndWeightData(
      String itemGroup, String weight1, String weight2) async {
    List<ItemsModel> itemsList = [];
    print(itemGroup);
    print(weight1);
    print(weight2);
    print('itemgroupandweight');
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String weight1InKg = convertWeightInGramsToKg(weight1);
    String weight2InKg = convertWeightInGramsToKg(weight2);
    String baseurl = await getApiUrl();
    final String itemweight =
        itemGroupAndWeightDataSeriesUrl(itemGroup, weight1InKg, weight2InKg);
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
    return itemsList;
  }

  Future<List<ItemsModel>> getItemWeightData(
      String weight1, String weight2) async {
    List<ItemsModel> itemsList = [];
    itemsList.clear();
    final String cookie = await getCookie();
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Cookie': cookie
    };
    String weight1InKg = convertWeightInGramsToKg(weight1);
    String weight2InKg = convertWeightInGramsToKg(weight2);

    String baseurl = await getApiUrl();
    final String itemweight = itemWeightUrl(weight1InKg, weight2InKg);
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
    return itemsList;
  }

  Future<List<ItemsModel>> getItemBrandData(String brandName) async {
    List<ItemsModel> itemsList = [];
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
    return itemsList;
  }

  Future<List<ItemsModel>> getItemGroupData(String itemGroupName) async {
    List<ItemsModel> itemsList = [];
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
    return itemsList;
  }

  String convertWeightInGramsToKg(String weight) {
    double weightInGrams = double.parse(weight);
    String weight1InKg = (weightInGrams / 1000).toString();
    return weight1InKg;
  }

  Future<List<ItemsModel>> getItem(String item) async {
    List<ItemsModel> itemsList = [];
    itemsList.clear();
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
    if (itemCodeResponse.statusCode == 200) {
      print('Item Code');
      var data = jsonDecode(itemCodeResponse.body);
      String itemCode = data['data']['item_code'];
      String itemName = data['data']['item_name'];
      String image = data['data']['image'];
      itemsList.add(ItemsModel(itemName, itemCode, image));
      return itemsList;
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
        return itemsList;
      }
    }
    print(itemsList.length);
    return itemsList;
  }
}
