class GlobalDefaults {
  final String currency;
  final String company;
  final String distanceunit;

  GlobalDefaults({this.currency, this.company, this.distanceunit});

  factory GlobalDefaults.fromJson(Map<String, dynamic> json) {
    return GlobalDefaults(
      company: json['default_company'],
      currency: json['default_currency'],
      distanceunit: json['default_distance_unit'],
    );
  }
}
