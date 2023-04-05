class AllTaxiFares {
  int? statuscode;
  Body? body;
  String? message;

  AllTaxiFares({this.statuscode, this.body, this.message});

  AllTaxiFares.fromJson(Map<String, dynamic> json) {
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
  String? vehicleTypeId;
  List<City>? city;
  String? vehicleType;
  Fare? fare;
  WeekendFare? weekendFare;
  NightFare? nightFare;
  CancellationCharges? cancellationCharges;
  String? status;
  String? createdAt;
  String? updatedAt;

  Body(
      {this.id,
      this.vehicleTypeId,
      this.city,
      this.vehicleType,
      this.fare,
      this.weekendFare,
      this.nightFare,
      this.cancellationCharges,
      this.status,
      this.createdAt,
      this.updatedAt});

  Body.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleTypeId = json['vehicleTypeId'];
    if (json['city'] != null) {
      city = <City>[];
      json['city'].forEach((v) {
        city!.add(new City.fromJson(v));
      });
    }
    vehicleType = json['vehicleType'];
    fare = json['fare'] != null ? new Fare.fromJson(json['fare']) : null;
    weekendFare = json['weekendFare'] != null
        ? new WeekendFare.fromJson(json['weekendFare'])
        : null;
    nightFare = json['nightFare'] != null
        ? new NightFare.fromJson(json['nightFare'])
        : null;
    cancellationCharges = json['cancellationCharges'] != null
        ? new CancellationCharges.fromJson(json['cancellationCharges'])
        : null;
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicleTypeId'] = this.vehicleTypeId;
    if (this.city != null) {
      data['city'] = this.city!.map((v) => v.toJson()).toList();
    }
    data['vehicleType'] = this.vehicleType;
    if (this.fare != null) {
      data['fare'] = this.fare!.toJson();
    }
    if (this.weekendFare != null) {
      data['weekendFare'] = this.weekendFare!.toJson();
    }
    if (this.nightFare != null) {
      data['nightFare'] = this.nightFare!.toJson();
    }
    if (this.cancellationCharges != null) {
      data['cancellationCharges'] = this.cancellationCharges!.toJson();
    }
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class City {
  String? id;
  String? cityName;
  String? state;
  String? status;
  String? createdAt;
  String? updatedAt;

  City(
      {this.id,
      this.cityName,
      this.state,
      this.status,
      this.createdAt,
      this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['cityName'];
    state = json['state'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cityName'] = this.cityName;
    data['state'] = this.state;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Fare {
  int? baseFare;
  double? baseKm;
  int? standardFarePerKm;

  Fare({this.baseFare, this.baseKm, this.standardFarePerKm});

  Fare.fromJson(Map<String, dynamic> json) {
    baseFare = json['baseFare'];
    baseKm = json['baseKm'];
    standardFarePerKm = json['standardFarePerKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseFare'] = this.baseFare;
    data['baseKm'] = this.baseKm;
    data['standardFarePerKm'] = this.standardFarePerKm;
    return data;
  }
}

class WeekendFare {
  int? weekendBaseFare;
  double? weekendBaseKm;
  int? weekendStandardFarePerKm;

  WeekendFare(
      {this.weekendBaseFare,
      this.weekendBaseKm,
      this.weekendStandardFarePerKm});

  WeekendFare.fromJson(Map<String, dynamic> json) {
    weekendBaseFare = json['weekendBaseFare'];
    weekendBaseKm = json['weekendBaseKm'];
    weekendStandardFarePerKm = json['weekendStandardFarePerKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weekendBaseFare'] = this.weekendBaseFare;
    data['weekendBaseKm'] = this.weekendBaseKm;
    data['weekendStandardFarePerKm'] = this.weekendStandardFarePerKm;
    return data;
  }
}

class NightFare {
  int? nightBaseFare;
  double? nightBaseKm;
  int? nightStandardFarePerKm;

  NightFare(
      {this.nightBaseFare, this.nightBaseKm, this.nightStandardFarePerKm});

  NightFare.fromJson(Map<String, dynamic> json) {
    nightBaseFare = json['nightBaseFare'];
    nightBaseKm = json['nightBaseKm'];
    nightStandardFarePerKm = json['nightStandardFarePerKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nightBaseFare'] = this.nightBaseFare;
    data['nightBaseKm'] = this.nightBaseKm;
    data['nightStandardFarePerKm'] = this.nightStandardFarePerKm;
    return data;
  }
}

class CancellationCharges {
  int? baseCancellationCharges;
  int? weekendCancellationCharges;
  int? nightCancellationCharges;

  CancellationCharges(
      {this.baseCancellationCharges,
      this.weekendCancellationCharges,
      this.nightCancellationCharges});

  CancellationCharges.fromJson(Map<String, dynamic> json) {
    baseCancellationCharges = json['baseCancellationCharges'];
    weekendCancellationCharges = json['weekendCancellationCharges'];
    nightCancellationCharges = json['nightCancellationCharges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseCancellationCharges'] = this.baseCancellationCharges;
    data['weekendCancellationCharges'] = this.weekendCancellationCharges;
    data['nightCancellationCharges'] = this.nightCancellationCharges;
    return data;
  }
}
