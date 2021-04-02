class BrandModel{
  final String name;
  BrandModel({this.name});
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(name: json['name'] ?? '');
  }
}