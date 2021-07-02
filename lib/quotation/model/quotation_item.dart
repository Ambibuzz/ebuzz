class QuotationItem {
  final double? qty;
  final String? itemName;
  final String? itemCode;
  final String? itemGroup;
  final double? rate;
  final String? stockUom;
  final String? weightUom;
  final double? amount;
  final String description;

  QuotationItem({
    this.qty,
    this.itemName,
    this.itemCode,
    this.itemGroup,
    this.rate,
    this.stockUom,
    this.weightUom,
    this.amount,
    this.description='',
  });

  factory QuotationItem.fromJson(Map<String, dynamic> json) {
    return QuotationItem(
      amount: json['amount'] ?? 0,
      description: json['description'] ?? '',
      itemCode: json['item_code'] ?? '',
      itemGroup: json['item_group'] ?? '',
      itemName: json['item_name'] ?? '',
      qty: json['qty'] ?? 0,
      rate: json['rate'] ?? 0,
      stockUom: json['stock_uom'] ?? '',
      weightUom: json['weight_uom'] ?? '',
    );
  }
}
