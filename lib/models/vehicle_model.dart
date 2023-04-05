class VehicleModel {
  int? vehicleId;
  int? modelId;
  int? typeId;
  String? photo;
  String? vehicleName;
  String? limitedPrice;
  String? unlimitedPrice;
  String? seater;
  String? fuelType;
  String? transmission;
  String? year;
  String? airBags;
  String? isLimited;
  String? isUnlimited;

  VehicleModel(
      {this.vehicleId,
      this.modelId,
      this.typeId,
      this.photo,
      this.vehicleName,
      this.limitedPrice,
      this.unlimitedPrice,
      this.seater,
      this.fuelType,
      this.transmission,
      this.year,
      this.airBags,
      this.isLimited,
      this.isUnlimited});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicle_id'];
    modelId = json['model_id'];
    typeId = json['type_id'];
    photo = json['photo'];
    vehicleName = json['vehicle_name'];
    limitedPrice = json['limited_price'];
    unlimitedPrice = json['unlimited_price'];
    seater = json['seater'];
    fuelType = json['fuel_type'];
    transmission = json['transmission'];
    year = json['year'];
    airBags = json['air_bags'];
    isLimited = json['is_limited'];
    isUnlimited = json['is_unlimited'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_id'] = this.vehicleId;
    data['model_id'] = this.modelId;
    data['type_id'] = this.typeId;
    data['photo'] = this.photo;
    data['vehicle_name'] = this.vehicleName;
    data['limited_price'] = this.limitedPrice;
    data['unlimited_price'] = this.unlimitedPrice;
    data['seater'] = this.seater;
    data['fuel_type'] = this.fuelType;
    data['transmission'] = this.transmission;
    data['year'] = this.year;
    data['air_bags'] = this.airBags;
    data['is_limited'] = this.isLimited;
    data['is_unlimited'] = this.isUnlimited;
    return data;
  }
}
