class ItemPriceModel{
  final String doctype;
  final String company;
  final String itemcode;
  final double conversionrate;
  final String pricelist;
  final String customer;

  ItemPriceModel({this.doctype, this.company, this.itemcode, this.conversionrate, this.pricelist,this.customer});


  Map toJson() {
    return {
      "args": {
        "doctype": doctype,
        "item_code": itemcode,
        "customer": customer,
        "company": company,
        "conversion_rate": conversionrate,
        "price_list": pricelist
      }
    };
  }
}