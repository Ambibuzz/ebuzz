//Product class contains model to store data of Item api
//All fields are  not been used only limited fields which were useful in app have been used
class Product {
  final String? itemName;
  final String? itemGroup;
  final String hsn;
  final String brand;
  final String description;
  final int shellLife;
  final String slideShow;
  final String image;
  final String? itemCode;
  final int sampleSize;
  final double valuationRate;
  final String defaultUnitOfMeasure;

  Product({
    this.valuationRate=0,
    this.itemCode,
    this.image='',
    this.slideShow='',
    this.itemName,
    this.itemGroup,
    this.hsn='',
    this.brand='',
    this.description='',
    this.shellLife=0,
    this.sampleSize=0,
    this.defaultUnitOfMeasure=''
  });

  //For fetching json data from item api and storing it in Product model
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      itemCode: json['item_code'] ?? '',
      brand: json['brand'] ?? '',
      itemName: json['item_name'] ?? '',
      itemGroup: json['item_group'] ?? '',
      hsn: json['gst_hsn_code'] ?? '',
      description: json['description'] ?? '',
      shellLife: json['shelf_life_in_days'] ?? 0,
      slideShow: json['slideshow'] ?? '',
      image: json['image'],
      sampleSize: json['sample_quantity'] ?? 0,
      valuationRate: json['valuation_rate'] ?? 0,
      defaultUnitOfMeasure: json['stock_uom'] ?? 0

    );
  }
}
