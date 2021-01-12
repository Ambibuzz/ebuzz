//PurchaseModel class contains model to store data of Purchase Order api
//All fields are  not been used only limited fields which were useful in app have been used

class PurchaseModel {
  final String supplier;
  final String date;
  final String requiredByDate;
  PurchaseModel({this.supplier, this.date, this.requiredByDate});

  //For fetching json data from purchase order api and storing it in purchase model
  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    return PurchaseModel(
      supplier: json['supplier'] ?? '',
      date: json['transaction_date'] ?? '',
      requiredByDate: json['schedule_date'] ?? '',
    );
  }
}

//ItemsModel class contains model to store data of Purchase Order api
class ItemsModel {
  final String itemCode;
  final String itemName;
  final double quantity;
  final double quantityRecieved;
  final String purchaseOrder;
  final String purchaseOrderModel;
  ItemsModel(
      {this.purchaseOrder,
      this.purchaseOrderModel,
      this.itemCode,
      this.itemName,
      this.quantity,
      this.quantityRecieved});

  //For fetching json data from purchase order api and storing it in items model
  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      itemCode: json['item_code'] ?? '',
      itemName: json['item_name'] ?? '',
      quantity: json['qty'] ?? 0,
      quantityRecieved: json['received_qty'] ?? 0,
      purchaseOrder: json['name'] ?? '',
      purchaseOrderModel: json['parent'] ?? '',
    );
  }
}
