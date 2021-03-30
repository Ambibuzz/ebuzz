import 'package:dio/dio.dart';
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
      print(listData);
      listData.forEach((itemData) {
        itemsList.add(ItemsModel.fromJson(itemData));
      });
      return itemsList;
    } catch (e) {
      exception(e);
    }
    return itemsList;
  }
}
