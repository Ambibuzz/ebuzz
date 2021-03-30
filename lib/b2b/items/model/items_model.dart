class ItemsModel {
  final String itemName;
  final String itemCode;
  final int quantity;
  final String image;

  ItemsModel(this.itemName, this.itemCode, this.image, {this.quantity});

  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(json['item_name'] ?? '', json['item_code'] ?? '',json['image']??'',quantity:1);
  }
}
