class BookingDetail {
  int? statuscode;
  Body? body;
  String? message;

  BookingDetail({this.statuscode, this.body, this.message});

  BookingDetail.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Body {
  String? id;
  String? customerId;
  String? vehicleTypeId;
  String? vehicleType;
  String? cityId;
  String? cityName;
  String? when;
  String? bookingTime;
  String? driverID;
  String? driver;
  String? driverAvatar;
  FleetAssigned? fleetAssigned;
  String? assignedAt;
  PickupCoordinates? pickupCoordinates;
  String? pickupAddress;
  String? pickupDatetime;
  String? dropAddress;
  PickupCoordinates? dropCoordinates;
  String? dropDatetime;
  String? totalKmJourney;
  String? fareApplied;
  int? excessKm;
  int? standardFarePerKm;
  int? baseFare;
  int? additonalFare;
  int? subTotalFare;
  String? discountApplicable;
  String? discountId;
  String? typeOfOffer;
  String? discountType;
  int? discountValue;
  int? maximumDiscount;
  int? totalDiscount;
  int? totalFare;
  String? paymentMode;
  String? paymentStatus;
  String? bookingStatus;
  String? cancellationReason;
  String? createdAt;
  String? updatedAt;

  Body(
      {this.id,
      this.customerId,
      this.vehicleTypeId,
      this.vehicleType,
      this.cityId,
      this.cityName,
      this.when,
      this.bookingTime,
      this.driverID,
      this.driver,
      this.driverAvatar,
      this.fleetAssigned,
      this.assignedAt,
      this.pickupCoordinates,
      this.pickupAddress,
      this.pickupDatetime,
      this.dropAddress,
      this.dropCoordinates,
      this.dropDatetime,
      this.totalKmJourney,
      this.fareApplied,
      this.excessKm,
      this.standardFarePerKm,
      this.baseFare,
      this.additonalFare,
      this.subTotalFare,
      this.discountApplicable,
      this.discountId,
      this.typeOfOffer,
      this.discountType,
      this.discountValue,
      this.maximumDiscount,
      this.totalDiscount,
      this.totalFare,
      this.paymentMode,
      this.paymentStatus,
      this.bookingStatus,
      this.cancellationReason,
      this.createdAt,
      this.updatedAt});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'];
    vehicleTypeId = json['vehicleTypeId'];
    vehicleType = json['vehicleType'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    when = json['when'];
    bookingTime = json['bookingTime'];
    driverID = json['driverID'];
    driver = json['driver'];
    driverAvatar = json['driverAvatar'];
    fleetAssigned = json['fleetAssigned'] != null
        ? new FleetAssigned.fromJson(json['fleetAssigned'])
        : null;
    assignedAt = json['assignedAt'];
    pickupCoordinates = json['pickupCoordinates'] != null
        ? new PickupCoordinates.fromJson(json['pickupCoordinates'])
        : null;
    pickupAddress = json['pickupAddress'];
    pickupDatetime = json['pickupDatetime'];
    dropAddress = json['dropAddress'];
    dropCoordinates = json['dropCoordinates'] != null
        ? new PickupCoordinates.fromJson(json['dropCoordinates'])
        : null;
    dropDatetime = json['dropDatetime'];
    totalKmJourney = json['totalKmJourney'];
    fareApplied = json['fareApplied'];
    excessKm = json['excessKm'];
    standardFarePerKm = json['standardFarePerKm'];
    baseFare = json['baseFare'];
    additonalFare = json['additonalFare'];
    subTotalFare = json['subTotalFare'];
    discountApplicable = json['discountApplicable'];
    discountId = json['discountId'];
    typeOfOffer = json['typeOfOffer'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    maximumDiscount = json['maximumDiscount'];
    totalDiscount = json['totalDiscount'];
    totalFare = json['totalFare'];
    paymentMode = json['paymentMode'];
    paymentStatus = json['paymentStatus'];
    bookingStatus = json['bookingStatus'];
    cancellationReason = json['cancellationReason'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerId'] = this.customerId;
    data['vehicleTypeId'] = this.vehicleTypeId;
    data['vehicleType'] = this.vehicleType;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['when'] = this.when;
    data['bookingTime'] = this.bookingTime;
    data['driverID'] = this.driverID;
    data['driver'] = this.driver;
    data['driverAvatar'] = this.driverAvatar;
    if (this.fleetAssigned != null) {
      data['fleetAssigned'] = this.fleetAssigned!.toJson();
    }
    data['assignedAt'] = this.assignedAt;
    if (this.pickupCoordinates != null) {
      data['pickupCoordinates'] = this.pickupCoordinates!.toJson();
    }
    data['pickupAddress'] = this.pickupAddress;
    data['pickupDatetime'] = this.pickupDatetime;
    data['dropAddress'] = this.dropAddress;
    if (this.dropCoordinates != null) {
      data['dropCoordinates'] = this.dropCoordinates!.toJson();
    }
    data['dropDatetime'] = this.dropDatetime;
    data['totalKmJourney'] = this.totalKmJourney;
    data['fareApplied'] = this.fareApplied;
    data['excessKm'] = this.excessKm;
    data['standardFarePerKm'] = this.standardFarePerKm;
    data['baseFare'] = this.baseFare;
    data['additonalFare'] = this.additonalFare;
    data['subTotalFare'] = this.subTotalFare;
    data['discountApplicable'] = this.discountApplicable;
    data['discountId'] = this.discountId;
    data['typeOfOffer'] = this.typeOfOffer;
    data['discountType'] = this.discountType;
    data['discountValue'] = this.discountValue;
    data['maximumDiscount'] = this.maximumDiscount;
    data['totalDiscount'] = this.totalDiscount;
    data['totalFare'] = this.totalFare;
    data['paymentMode'] = this.paymentMode;
    data['paymentStatus'] = this.paymentStatus;
    data['bookingStatus'] = this.bookingStatus;
    data['cancellationReason'] = this.cancellationReason;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class FleetAssigned {
  String? id;
  String? brandName;
  String? vehicleType;
  String? vehicleTypeId;
  String? modelId;
  String? modelName;
  String? modelNumber;
  int? seatingCapacity;
  String? transmissionType;
  bool? airBag;
  String? fuelType;
  List<VehiclePhotos>? vehiclePhotos;
  String? color;
  String? vehicleYear;
  String? enginerNumber;
  String? chasisNumber;
  String? registerationNumber;
  String? status;
  String? createdAt;
  String? updatedAt;

  FleetAssigned(
      {this.id,
      this.brandName,
      this.vehicleType,
      this.vehicleTypeId,
      this.modelId,
      this.modelName,
      this.modelNumber,
      this.seatingCapacity,
      this.transmissionType,
      this.airBag,
      this.fuelType,
      this.vehiclePhotos,
      this.color,
      this.vehicleYear,
      this.enginerNumber,
      this.chasisNumber,
      this.registerationNumber,
      this.status,
      this.createdAt,
      this.updatedAt});

  FleetAssigned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brandName'];
    vehicleType = json['vehicleType'];
    vehicleTypeId = json['vehicleTypeId'];
    modelId = json['modelId'];
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
    color = json['color'];
    vehicleYear = json['vehicleYear'];
    enginerNumber = json['enginerNumber'];
    chasisNumber = json['chasisNumber'];
    registerationNumber = json['registerationNumber'];
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
    data['modelId'] = this.modelId;
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
    data['color'] = this.color;
    data['vehicleYear'] = this.vehicleYear;
    data['enginerNumber'] = this.enginerNumber;
    data['chasisNumber'] = this.chasisNumber;
    data['registerationNumber'] = this.registerationNumber;
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

class PickupCoordinates {
  String? latitude;
  String? longitude;

  PickupCoordinates({this.latitude, this.longitude});

  PickupCoordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
