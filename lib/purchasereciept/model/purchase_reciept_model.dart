//PRItem class contains model to store data of purchase receipt api
//All fields are  not been used only limited fields which were useful in app have been used

class PRItem {
  String itemName;
  String itemCode;
  double quantity;
  double quantityRecieved;
  String purchaseOrder;
  String purchaseOrderItem;

  PRItem(
      {this.itemName,
      this.itemCode,
      this.quantity,
      this.purchaseOrder,
      this.purchaseOrderItem,
      this.quantityRecieved});

  //For fetching json data from purchase receipt api and storing it in purchase receipt item model
  factory PRItem.fromJson(Map<String, dynamic> json) {
    return PRItem(
        itemCode: json['item_code'] ?? '',
        itemName: json['item_name'] ?? '',
        purchaseOrderItem: json['name'] ?? '',
        purchaseOrder: json['parent'] ?? '',
        quantity: json['qty'] ?? 0,
        quantityRecieved: json['received_qty'] ?? 0);
  }

  //For converting model to json format for storing it in purchase receipt item model
  Map toJson() => {
        'item_name': itemName,
        'item_code': itemCode,
        'qty': quantity,
        'purchase_order': purchaseOrder,
        'purchase_order_item': purchaseOrderItem
      };
}

//PurchaseRecieptModel class contains model to store data of purchase receipt api
class PurchaseReceiptModel {
  int docStatus;
  String workflowState;
  String supplier;
  List<PRItem> prItems;

  PurchaseReceiptModel(
      {this.docStatus, this.workflowState, this.supplier, this.prItems});

  //For converting model to json format for storing it in purchase receipt model
  Map toJson() {
    List<Map> prItems = this.prItems != null
        ? this.prItems.map((i) => i.toJson()).toList()
        : null;
    return {
      'docstatus': docStatus,
      'workflow_state': workflowState,
      'supplier': supplier,
      'items': prItems
    };
  }
}
