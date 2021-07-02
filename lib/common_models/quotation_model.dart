class QuotationModel {
  final String? currency;
  final List<QuotationItems>? quotationitems;
  final String customerName;
  final String? quotationTo;
  final String partyName;
  final String contactDisplay;
  final String contactEmail;
  final String contactPerson;
  final String contactMobile;
  final String customerAddress;
  final String territory;

  QuotationModel({
    this.currency,
    this.quotationitems,
    this.customerName='',
    this.quotationTo,
    this.partyName='',
    this.contactDisplay='',
    this.contactEmail='',
    this.contactMobile='',
    this.contactPerson='',
    this.customerAddress='',
    this.territory='',
  });

  Map toJson() {
    List<Map>? qoitems = this.quotationitems == null
        ? null
        : this.quotationitems!.map((i) => i.toJson()).toList();
    return {
      'currency': this.currency,
      'items': qoitems,
      'customer_name': this.customerName,
      'party_name': this.partyName,
      'quotation_to': this.quotationTo,
      'contact_display': this.contactDisplay,
      'contact_email': this.contactEmail,
      'contact_mobile': this.contactMobile,
      'contact_person': this.contactPerson,
      'customer_address': this.customerAddress,
      'territory': this.territory
    };
  }
}

class QuotationItems {
  final String itemcode;
  final int quantity;
  final double rate;

  QuotationItems(
      {required this.itemcode, required this.quantity, required this.rate});

  Map toJson() {
    return {'item_code': itemcode, 'qty': quantity, 'rate': rate};
  }
}
