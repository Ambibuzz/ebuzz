class SalesOrder {
  final String name;
  final int docstatus;
  final double perbilled;
  final double perdelivered;
  final String customer;
  final String company;
  final String ordertype;
  final String transactiondate;
  final String deliverydate;
  final double advancepaid;
  final double grandtotal;
  final double basegrandtotal;
  final String portofdischarge;
  final double totalnetweight;
  final double totalqty;
  final String status;
  final String podate;
  final String pono;
  final String setwarehouse;
  final List<SalesOrderItems> salesOrderItems;

  SalesOrder(
      {this.docstatus,
      this.salesOrderItems,
      this.setwarehouse,
      this.podate,
      this.pono,
      this.perdelivered,
      this.perbilled,
      this.status,
      this.customer,
      this.company,
      this.ordertype,
      this.transactiondate,
      this.deliverydate,
      this.advancepaid,
      this.grandtotal,
      this.basegrandtotal,
      this.portofdischarge,
      this.totalnetweight,
      this.totalqty,
      this.name});
  factory SalesOrder.fromJson(Map<String, dynamic> json) {
    return SalesOrder(
      advancepaid: json['advance_paid'] ?? 0,
      basegrandtotal: json['base_grand_total'] ?? 0,
      company: json['company'] ?? '',
      customer: json['customer'] ?? '',
      deliverydate: json['delivery_date'] ?? '',
      grandtotal: json['grand_total'] ?? 0,
      ordertype: json['order_type'] ?? '',
      portofdischarge: json['port_of_discharge'] ?? '',
      totalnetweight: json['total_net_weight'] ?? 0,
      totalqty: json['total_qty'] ?? 0,
      transactiondate: json['transaction_date'] ?? '',
      status: json['status'] ?? 'Draft',
      name: json['name'] ?? '',
      perbilled: json['per_billed'] ?? 0,
      podate: json['podate'] ?? '',
      pono: json['pono'] ?? '',
      perdelivered: json['per_delivered'] ?? 0,
      setwarehouse: json['set_warehouse'] ?? '',
      salesOrderItems: json['items'] ?? null,
    );
  }

  //For converting model to json format for storing it in quality inspection model
  Map toJson() {
    List<Map> salesOrderItemsList = this.salesOrderItems != null
        ? this.salesOrderItems.map((i) => i.toJson()).toList()
        : null;
    return {
      'docstatus': docstatus,
      'company': company,
      'customer': customer,
      'set_warehouse': setwarehouse,
      'delivery_date': deliverydate,
      'items': salesOrderItemsList
    };
  }
}

class SalesOrderItems {
  double qty;
  String deliverydate;
  String itemcode;
  String itemname;
  double amount;
  double rate;

  SalesOrderItems({
    this.qty,
    this.deliverydate,
    this.itemcode,
    this.itemname,
    this.amount,
    this.rate,
  });

  factory SalesOrderItems.fromJson(Map<String, dynamic> json) {
    return SalesOrderItems(
      amount: json['amount'] ?? 0,
      deliverydate: json['delivery_date'] ?? '',
      itemcode: json['item_code'] ?? '',
      itemname: json['item_name'] ?? '',
      qty: json['qty'] ?? 0,
      rate: json['rate'] ?? 0,
    );
  }

  //For converting model to json format for storing it in quality inspection readings
  Map toJson() => {
        'delivery_date': deliverydate,
        'item_code': itemcode,
        'qty': qty,
      };
      // Map toJson() => {
      //   // 'amount': amount,
      //   'delivery_date': deliverydate,
      //   'item_code': itemcode,
      //   'qty': qty,
      //   // 'rate': rate,
      // };
}

class SalesOrderPaymentSchedule {
  final String paymentterm;
  final double paymentamount;
  final String duedate;
  final double invoiceportion;
  final String description;

  SalesOrderPaymentSchedule(
      {this.paymentterm,
      this.paymentamount,
      this.duedate,
      this.invoiceportion,
      this.description});
  factory SalesOrderPaymentSchedule.fromJson(Map<String, dynamic> json) {
    return SalesOrderPaymentSchedule(
      description: json['description'] ?? '',
      duedate: json['due_date'] ?? '',
      invoiceportion: json['invoice_portion'] ?? 0,
      paymentamount: json['payment_amount'] ?? 0,
      paymentterm: json['payment_term'] ?? '',
    );
  }
}
