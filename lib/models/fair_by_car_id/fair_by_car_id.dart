import 'dart:convert';

FairByCarId fairByCarIdFromJson(String str) => FairByCarId.fromJson(json.decode(str));

class FairByCarId {
  FairByCarId({
    required this.error,
    required this.errorCode,
    this.message,
    this.data,
  });

  bool error;
  int errorCode;
  String? message;
  Data? data;

  factory FairByCarId.fromJson(Map<String, dynamic> json) => FairByCarId(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.estimatedPrice,
    required this.fair,
  });

  double estimatedPrice;
  Fair fair;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        estimatedPrice: double.parse(json["estimatedPrice"].toString()),
        fair: Fair.fromJson(json["fair"]),
      );

  Map<String, dynamic> toJson() => {
        "estimatedPrice": estimatedPrice,
        "fair": fair.toJson(),
      };
}

class Fair {
  Fair({
    required this.id,
    required this.ratePerKm,
    this.waitingCharges,
    required this.minFairPercentage,
    required this.maxFairPercentage,
    this.cancellationCharges,
    this.vehicleTypeId,
  });

  int id;
  int ratePerKm;
  int? waitingCharges;
  int minFairPercentage;
  int maxFairPercentage;
  int? cancellationCharges;

  int? vehicleTypeId;
  int? fairValue;

  factory Fair.fromJson(Map<String, dynamic> json) => Fair(
        id: json["id"],
        ratePerKm: json["ratePerKM"],
        waitingCharges: json["waitingCharges"],
        minFairPercentage: json["minFairPercentage"],
        maxFairPercentage: json["maxFairPercentage"],
        cancellationCharges: json["cancellationCharges"],
        vehicleTypeId: json["vehicleTypeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ratePerKM": ratePerKm,
        "waitingCharges": waitingCharges,
        "minFairPercentage": minFairPercentage,
        "maxFairPercentage": maxFairPercentage,
        "cancellationCharges": cancellationCharges,
        "vehicleTypeId": vehicleTypeId,
        "fairValue": fairValue,
      };
}
