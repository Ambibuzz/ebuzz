
class Quotation {
  final String quotationTo;
  final String partyName;
  final String customerName;
  final String company;
  final String date;
  final String validTill;
  final String orderType;
  final String currency;
  final String priceList;
  final double totalQuantity;
  final double totalINR;
  final double totalNetWeight;
  final double grandTotal;
  final double roundedTotal;
  final String inWords;
  final String doctype;
  final String status;
  final String name;
  final String contactEmail;
  final String contactNumber;

  Quotation({
    this.quotationTo='',
    this.partyName='',
    this.customerName='',
    this.company='',
    this.date='',
    this.validTill='',
    this.orderType='',
    this.currency='',
    this.priceList='',
    this.totalQuantity=0,
    this.totalINR=0,
    this.totalNetWeight=0,
    this.grandTotal=0,
    this.roundedTotal=0,
    this.inWords='',
    this.doctype='',
    this.status='',
    this.name='',
     this.contactEmail='',
    this.contactNumber='',
  });

  factory Quotation.fromJson(Map<String, dynamic> json) {
    return Quotation(
        company: json['company'] ?? '',
        currency: json['currency'] ?? '',
        customerName: json['customer_name'] ?? '',
        date: json['transaction_date'] ?? '',
        doctype: json['doctype'] ?? '',
        grandTotal: json['grand_total'] ?? 0,
        inWords: json['in_words'] ?? '',
        orderType: json['order_type'] ?? '',
        partyName: json['party_name'] ?? '',
        priceList: json['selling_price_list'] ?? '',
        quotationTo: json['quotation_to'] ?? '',
        roundedTotal: json['rounded_total'] ?? 0,
        totalINR: json['total'] ?? 0,
        totalNetWeight: json['total_net_weight'] ?? 0,
        totalQuantity: json['total_qty'] ?? 0,
        validTill: json['valid_till'] ?? '',
        status: json['workflow_state'] ?? '',
        name: json['name'] ?? '',
        contactEmail: json['contact_email'] ?? '',
        contactNumber: json['contact_mobile'] ?? '');
  }
}
