class AllTaxi {
  int? statuscode;
  List<Body>? body;
  String? message;

  AllTaxi({this.statuscode, this.body, this.message});

  AllTaxi.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    if (json['body'] != null) {
      body = <Body>[];
      json['body'].forEach((v) {
        body!.add(new Body.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Body {
  String? id;
  String? brandName;
  String? vehicleType;
  String? vehicleTypeId;
  String? modelName;
  String? modelNumber;
  int? seatingCapacity;
  String? transmissionType;
  bool? airBag;
  String? fuelType;
  List<VehiclePhotos>? vehiclePhotos;
  String? status;
  String? createdAt;
  String? updatedAt;

  Body(
      {this.id,
      this.brandName,
      this.vehicleType,
      this.vehicleTypeId,
      this.modelName,
      this.modelNumber,
      this.seatingCapacity,
      this.transmissionType,
      this.airBag,
      this.fuelType,
      this.vehiclePhotos,
      this.status,
      this.createdAt,
      this.updatedAt});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brandName'];
    vehicleType = json['vehicleType'];
    vehicleTypeId = json['vehicleTypeId'];
    modelName = json['modelName'];
    modelNumber = json['modelNumber'];
    seatingCapacity = json['seatingCapacity'];
    transmissionType = json['transmissionType'];
    airBag = json['airBag'];
    fuelType = json['fuelType'];
    if (json['vehiclePhotos'] != null) {
      vehiclePhotos = <VehiclePhotos>[];
      json['vehiclePhotos'].forEach((v) {
        vehiclePhotos!.add(new VehiclePhotos.fromJson(v));
      });
    }
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brandName'] = this.brandName;
    data['vehicleType'] = this.vehicleType;
    data['vehicleTypeId'] = this.vehicleTypeId;
    data['modelName'] = this.modelName;
    data['modelNumber'] = this.modelNumber;
    data['seatingCapacity'] = this.seatingCapacity;
    data['transmissionType'] = this.transmissionType;
    data['airBag'] = this.airBag;
    data['fuelType'] = this.fuelType;
    if (this.vehiclePhotos != null) {
      data['vehiclePhotos'] =
          this.vehiclePhotos!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class VehiclePhotos {
  String? id;
  String? imageUrl;
  String? caption;
  String? mimeType;
  String? dateCreated;

  VehiclePhotos(
      {this.id, this.imageUrl, this.caption, this.mimeType, this.dateCreated});

  VehiclePhotos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    caption = json['caption'];
    mimeType = json['mimeType'];
    dateCreated = json['dateCreated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageUrl'] = this.imageUrl;
    data['caption'] = this.caption;
    data['mimeType'] = this.mimeType;
    data['dateCreated'] = this.dateCreated;
    return data;
  }
}
