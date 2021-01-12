//StockEntry class contains model to store data of stock entry api
//All fields are  not been used only limited fields which were useful in app have been used

class StockEntry {
  final String name;
  final String toWarehouse;
  final String fromWarehouse;
  final String postingDate;

  StockEntry(
      {this.name, this.toWarehouse, this.fromWarehouse, this.postingDate});
  //For fetching json data from stock entry api and storing it in stock entry model
  factory StockEntry.fromJson(Map<String, dynamic> json) {
    return StockEntry(
        name: json['name'] ?? '',
        fromWarehouse: json['from_warehouse'] ?? '',
        postingDate: json['posting_date'] ?? '',
        toWarehouse: json['to_warehouse'] ?? '');
  }
}

class PurchaseInvoice {
  final String name;
  final String supplierName;
  final double grandtotal;
  final double outstanding;

  PurchaseInvoice(
      {this.name, this.supplierName, this.grandtotal, this.outstanding});
  factory PurchaseInvoice.fromJson(Map<String, dynamic> json) {
    return PurchaseInvoice(
        name: json['name'] ?? '',
        grandtotal: json['base_grand_total'] ?? 0,
        outstanding: json['outstanding_amount'] ?? 0,
        supplierName: json['supplier_name'] ?? '');
  }
}

class PurchaseReciept {
  final String name;
  final String status;
  final String supplierName;
  final String postingDate;

  PurchaseReciept(
      {this.name, this.status, this.supplierName, this.postingDate});
  factory PurchaseReciept.fromJson(Map<String, dynamic> json) {
    return PurchaseReciept(
        name: json['name'] ?? '',
        supplierName: json['supplier_name'] ?? '',
        postingDate: json['posting_date'] ?? '',
        status: json['status'] ?? '');
  }
}

class SalesOrder {
  final String name;
  final String customer;
  final String postingDate;
  final String dueDate;
  final double baseTotal;
  final double roundedTotal;

  SalesOrder(
      {this.name,
      this.customer,
      this.postingDate,
      this.dueDate,
      this.baseTotal,
      this.roundedTotal});
  factory SalesOrder.fromJson(Map<String, dynamic> json) {
    return SalesOrder(
        name: json['name'] ?? '',
        postingDate: json['posting_date'] ?? '',
        dueDate: json['due_date'] ?? '',
        baseTotal: json['base_total'] ?? '',
        roundedTotal: json['rounded_total'] ?? '',
        customer: json['customer'] ?? '');
  }
}

class DeliveryNote {
  final String name;
  final String status;
  final String customerName;
  final double baseTotal;
  final String territories;

  DeliveryNote(
      {this.territories,
      this.name,
      this.status,
      this.customerName,
      this.baseTotal});
  factory DeliveryNote.fromJson(Map<String, dynamic> json) {
    return DeliveryNote(
        name: json['name'] ?? '',
        customerName: json['customer_name'] ?? '',
        baseTotal: json['base_total'] ?? '',
        territories: json['territory'] ?? '',
        status: json['status'] ?? '');
  }
}
