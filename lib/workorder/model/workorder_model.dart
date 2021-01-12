//WorkOrderModel class contains model to store data of work order api
//All fields are  not been used only limited fields which were useful in app have been used

class WorkOrderModel {
  final String status;
  final String company;
  final String productionItem;
  final String description;
  final double qtyToManufacture;
  final String itemName;
  final double materialTransfForManuf;
  final String bomNo;
  final double manufacturedQty;
  final String salesOrder;
  final String workInProgressWarehouse;
  final String targetWarehouse;
  final String plannedStartDate;
  final String expectedDeliveryDate;
  final String name;

  WorkOrderModel(
      {this.productionItem,
      this.name,
      this.description,
      this.status,
      this.company,
      this.qtyToManufacture,
      this.itemName,
      this.materialTransfForManuf,
      this.bomNo,
      this.manufacturedQty,
      this.salesOrder,
      this.workInProgressWarehouse,
      this.targetWarehouse,
      this.plannedStartDate,
      this.expectedDeliveryDate});

  //For fetching json data from work order api and storing it in work order model
  factory WorkOrderModel.fromJson(Map<String, dynamic> json) {
    return WorkOrderModel(
      bomNo: json['bom_no'] ?? '',
      name: json['name'] ?? '',
      company: json['company'] ?? '',
      expectedDeliveryDate: json['expected_delivery_date'] ?? '',
      itemName: json['item_name'] ?? '',
      description: json['description'] ?? '',
      productionItem: json['production_item'] ?? '',
      manufacturedQty: json['produced_qty'] ?? 0,
      materialTransfForManuf:
          json['material_transferred_for_manufacturing'] ?? 0,
      plannedStartDate: json['planned_start_date'] ?? '',
      qtyToManufacture: json['qty'] ?? 0,
      salesOrder: json['sales_order'] ?? '',
      status: json['status'] ?? '',
      targetWarehouse: json['fg_warehouse'] ?? '',
      workInProgressWarehouse: json['wip_warehouse'] ?? '',
    );
  }
}

//WorkOrderItems class contains model to store item data of work order api
class WorkOrderItems {
  final String itemCode;
  final String itemName;
  final String sourceWarehouse;
  final double requiredQty;
  final double transferedQuantity;
  final double consumedQuantity;

  WorkOrderItems(
      {this.itemCode,
      this.itemName,
      this.sourceWarehouse,
      this.requiredQty,
      this.transferedQuantity,
      this.consumedQuantity});
  factory WorkOrderItems.fromJson(Map<String, dynamic> json) {
    return WorkOrderItems(
      consumedQuantity: json['consumed_qty'] ?? 0,
      itemCode: json['item_code'] ?? '',
      itemName: json['item_name'] ?? '',
      requiredQty: json['required_qty'] ?? 0,
      sourceWarehouse: json['source_warehouse'] ?? '',
      transferedQuantity: json['transferred_qty'] ?? 0,
    );
  }
}
