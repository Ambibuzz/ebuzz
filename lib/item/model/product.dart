//Product class contains model to store data of Item api
//All fields are  not been used only limited fields which were useful in app have been used
class Product {
  final String itemName;
  final String itemGroup;
  final String hsn;
  final String brand;
  final String description;
  final int shellLife;
  final String slideShow;
  final String image;
  final String itemCode;
  final int sampleSize;
  final double valuationRate;

  Product({
    this.valuationRate,
    this.itemCode,
    this.image,
    this.slideShow,
    this.itemName,
    this.itemGroup,
    this.hsn,
    this.brand,
    this.description,
    this.shellLife,
    this.sampleSize,
  });

  //For fetching json data from item api and storing it in Product model
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      itemCode: json['data']['item_code'] ?? '',
      brand: json['data']['brand'] ?? '',
      itemName: json['data']['item_name'] ?? '',
      itemGroup: json['data']['item_group'] ?? '',
      hsn: json['data']['gst_hsn_code'] ?? '',
      description: json['data']['description'] ?? '',
      shellLife: json['data']['shelf_life_in_days'] ?? 0,
      slideShow: json['data']['slideshow'] ?? '',
      image: json['data']['image'],
      sampleSize: json['data']['sample_quantity'] ?? 0,
      valuationRate: json['data']['valuation_rate'] ?? 0,
    );
  }
}
