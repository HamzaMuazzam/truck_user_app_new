class VehicleDetailModel {
  String? success;
  String? message;
  Data? data;

  VehicleDetailModel({this.success, this.message, this.data});

  VehicleDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? vehicleId;
  String? brand;
  String? model;
  String? type;
  String? color;
  String? licensePlate;
  String? modelNumber;
  String? year;
  String? engineNumber;
  String? chassisNumber;
  String? registrationNumber;
  String? seatingCapacity;
  String? airBags;
  String? transmissionType;
  String? fuelType;
  List<dynamic>? images;

  Data(
      {this.vehicleId,
      this.brand,
      this.model,
      this.type,
      this.color,
      this.licensePlate,
      this.modelNumber,
      this.year,
      this.engineNumber,
      this.chassisNumber,
      this.registrationNumber,
      this.seatingCapacity,
      this.airBags,
      this.transmissionType,
      this.fuelType,
      this.images});

  Data.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicle_id'];
    brand = json['brand'];
    model = json['model'];
    type = json['type'];
    color = json['color'];
    licensePlate = json['license_plate'];
    modelNumber = json['model_number'];
    year = json['year'];
    engineNumber = json['engine_number'];
    chassisNumber = json['chassis_number'];
    registrationNumber = json['registration_number'];
    seatingCapacity = json['seating_capacity'];
    airBags = json['air_bags'];
    transmissionType = json['transmission_type'];
    fuelType = json['fuel_type'];
    images = json['images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicle_id'] = this.vehicleId;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['type'] = this.type;
    data['color'] = this.color;
    data['license_plate'] = this.licensePlate;
    data['model_number'] = this.modelNumber;
    data['year'] = this.year;
    data['engine_number'] = this.engineNumber;
    data['chassis_number'] = this.chassisNumber;
    data['registration_number'] = this.registrationNumber;
    data['seating_capacity'] = this.seatingCapacity;
    data['air_bags'] = this.airBags;
    data['transmission_type'] = this.transmissionType;
    data['fuel_type'] = this.fuelType;
    data['images'] = this.images;
    return data;
  }
}
