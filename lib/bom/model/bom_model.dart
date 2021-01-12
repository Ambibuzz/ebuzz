//BomModel class contains model to store data of Bom api
//All fields are  not been used only limited fields which were useful in app have been used

class BomModel {
  final String itemCode;
  final String name;
  BomModel({this.itemCode, this.name});

  //For fetching json data from bom api and storing it in bom model
  factory BomModel.fromJson(Map<String, dynamic> json) {
    return BomModel(
      itemCode: json['item_code'] ?? '',
      name: json['item_name'] ?? '',
    );
  }
}
