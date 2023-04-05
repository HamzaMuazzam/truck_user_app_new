class Hub {
  int? hubID;
  String? name;
  String? address;
  int? cityID;
  String? city;
  double? lat;
  double? long;

  Hub(
      {this.hubID,
      this.name,
      this.address,
      this.cityID,
      this.city,
      this.lat,
      this.long});

  Hub.fromJson(Map<String, dynamic> map) {
    hubID = map['hub_id'];
    name = map['name'];
    address = map['address'];
    cityID = map['city_id'];
    city = map['city'];
    lat = double.parse(map['lat']);
    long = double.parse(map['long']);
  }
}
