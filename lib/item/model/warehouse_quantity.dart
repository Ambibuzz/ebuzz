//WarehouseQuantity class contains model to store data from stock ledger entry api
//All fields are  not been used only limited fields which were useful in app have been used
class WarehouseQuantity {
  WarehouseQuantity({
    this.actualQty,
    this.warehouse,
  });

  double actualQty;
  String warehouse;

  //For fetching json data from stock ledger entry api and storing it in warehouse quantity model
  factory WarehouseQuantity.fromJson(Map<String, dynamic> json) =>
      WarehouseQuantity(
        actualQty: json["qty_after_transaction"].toDouble() ?? 0.0,
        warehouse: json["warehouse"] ?? '',
      );
}
