import 'package:dio/dio.dart';
import 'package:ebuzz/b2b/items/model/brand_model.dart';
import 'package:ebuzz/b2b/items/model/item_group.dart';
import 'package:ebuzz/b2b/items/model/items_model.dart';
import 'package:ebuzz/exception/custom_exception.dart';
import 'package:ebuzz/network/base_dio.dart';
import 'package:ebuzz/util/apiurls.dart';

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
    List<ItemsModel> itemList = await itemsList();
    // List<ItemGroupModel> itemGroupList = await _itemsApiService.itemGroupList();
    for (ItemsModel itemCode in itemList) {
      fullItemList.add(itemCode.itemCode);
    }
    for (ItemsModel itemName in itemList) {
      fullItemList.add(itemName.itemName);
    }
    // for (ItemGroupModel itemGroup in itemGroupList) {
    //   fullItemList.add(itemGroup.name);
    //   setState(() {});
    // }
    print(fullItemList.length);
    return fullItemList;
  }
}
