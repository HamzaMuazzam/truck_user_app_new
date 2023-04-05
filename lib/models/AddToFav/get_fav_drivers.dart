import 'dart:convert';

GetFavDriverModel getFavDriverModelFromJson(String str) =>
    GetFavDriverModel.fromJson(json.decode(str));

String getFavDriverModelToJson(GetFavDriverModel data) => json.encode(data.toJson());

class GetFavDriverModel {
  GetFavDriverModel({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  List<Datum>? data;

  factory GetFavDriverModel.fromJson(Map<String, dynamic> json) => GetFavDriverModel(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode,
        "message": message,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
      };
}

class Datum {
  Datum({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.driverId,
    this.riderId,
    this.driver,
  });

  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? driverId;
  int? riderId;
  Driver? driver;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        driverId: json["driverId"],
        riderId: json["riderId"],
        driver: json["driver"] != null ? Driver.fromJson(json["driver"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "driverId": driverId,
        "riderId": riderId,
        "driver": driver?.toJson(),
      };
}

class Driver {
  Driver({
    this.name,
    this.mobileNumber,
    this.profileGoogleSignInButton,
    this.loginId,
    this.id,
  });

  String? name;
  String? mobileNumber;
  String? profileGoogleSignInButton;
  String? loginId;
  int? id;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        profileGoogleSignInButton: json["profileGoogleSignInButton"],
        loginId: json["loginId"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobileNumber": mobileNumber,
        "profileGoogleSignInButton": profileGoogleSignInButton,
        "loginId": loginId,
        "id": id,
      };
}
