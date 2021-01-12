//StockEntryModel class contains model to store data of stock entry api
//All fields are  not been used only limited fields which were useful in app have been used

class StockEntryModel {
  final String stockEntryType;
  final String postingDate;
  final String company;
  final String postingTime;
  final String workOrder;
  final String bomNo;
  final String purchaseOrder;
  final double forQuantity;
  final String defaultSourceWarehouse;
  final String defaultTargetWarehouse;
  final double totalIncomingValue;
  final double totalOutgoingValue;
  final double totalValueDifference;
  final double totalAdditionalCosts;
  final String name;
  final String workflowState;

  StockEntryModel({
    this.stockEntryType,
    this.postingDate,
    this.company,
    this.postingTime,
    this.workOrder,
    this.bomNo,
    this.forQuantity,
    this.defaultSourceWarehouse,
    this.defaultTargetWarehouse,
    this.totalIncomingValue,
    this.totalOutgoingValue,
    this.name,
    this.purchaseOrder,
    this.totalValueDifference,
    this.totalAdditionalCosts,
    this.workflowState,
  });

  //For fetching json data from stock entry api and storing it in stock entry model
  factory StockEntryModel.fromJson(Map<String, dynamic> json) {
    return StockEntryModel(
        bomNo: json['bom_no'] ?? '',
        company: json['company'] ?? '',
        defaultSourceWarehouse: json['from_warehouse'] ?? '',
        defaultTargetWarehouse: json['to_warehouse'] ?? '',
        forQuantity: json['fg_completed_qty'] ?? 0,
        postingDate: json['posting_date'] ?? '',
        postingTime: json['posting_time'] ?? '',
        stockEntryType: json['stock_entry_type'] ?? '',
        totalAdditionalCosts: json['total_additional_costs'] ?? 0,
        totalIncomingValue: json['total_incoming_value'] ?? 0,
        totalOutgoingValue: json['total_outgoing_value'] ?? 0,
        totalValueDifference: json['value_difference'] ?? 0,
        workOrder: json['work_order'] ?? '',
        purchaseOrder: json['purchase_order'] ?? '',
        name: json['name'] ?? '',
        workflowState: json['workflow_state'] ?? '');
  }
}

//StockEntryItem class contains model to store item data of stock entry api
class StockEntryItem {
  final String defaultSourceWarehouse;
  final String defaultTargetWarehouse;
  final String itemCode;
  final String itemName;
  final String itemGroup;
  final double quantity;

  StockEntryItem(
      {this.defaultSourceWarehouse,
      this.defaultTargetWarehouse,
      this.itemCode,
      this.itemName,
      this.itemGroup,
      this.quantity});

  //For fetching json data from stock entry api and storing it in stock entry item model
  factory StockEntryItem.fromJson(Map<String, dynamic> json) {
    return StockEntryItem(
      defaultSourceWarehouse: json['s_warehouse'] ?? '',
      defaultTargetWarehouse: json['t_warehouse'] ?? '',
      itemCode: json['item_code'] ?? '',
      itemGroup: json['item_group'] ?? '',
      itemName: json['item_name'] ?? '',
      quantity: json['qty'] ?? 0,
    );
  }
}
