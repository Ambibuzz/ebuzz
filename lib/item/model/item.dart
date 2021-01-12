//Item class contains model to store data of Item api
//All fields are  not been used only limited fields which were useful in app have been used
class Item {
  final String itemName;
  final String itemCode;

  Item({
    this.itemCode,
    this.itemName,
  });

  //For fetching json data from item api and storing it in item model
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      itemCode: json['item_code'] ?? '',
      itemName: json['item_name'] ?? '',
    );
  }
}
