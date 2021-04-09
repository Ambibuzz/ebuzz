class QuotationModel{
  final String currency;
  final List<QuotationItems> quotationitems;

  QuotationModel({this.currency, this.quotationitems});

  Map toJson() {
    List<Map> quotationitems = this.quotationitems != null
        ? this.quotationitems.map((i) => i.toJson()).toList()
        : null;
    return {
      'currency': currency,
      'items':quotationitems
    };
  }
}

class QuotationItems {
  final String itemcode;
  final int quantity;
  final double rate;

  QuotationItems({this.itemcode, this.quantity, this.rate});

  Map toJson(){
    return {
      'item_code':itemcode,
      'qty':quantity,
      'rate':rate
    };
  }

}