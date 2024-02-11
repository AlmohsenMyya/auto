class MapModel {
  String? country;
  String? alpha2;
  String? alpha3;
  int? numeric;
  double? latitude;
  double? longitude;

  MapModel(
      {this.country,
      this.alpha2,
      this.alpha3,
      this.numeric,
      this.latitude,
      this.longitude});

  MapModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    alpha2 = json['alpha2'];
    alpha3 = json['alpha3'];
    numeric = json['numeric'];
    latitude = json['latitude'] is int
        ? double.parse(json['latitude'].toString())
        : json['latitude'];
    longitude = json['longitude'] is int
        ? double.parse(json['longitude'].toString())
        : json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['country'] = country;
    data['alpha2'] = alpha2;
    data['alpha3'] = alpha3;
    data['numeric'] = numeric;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}