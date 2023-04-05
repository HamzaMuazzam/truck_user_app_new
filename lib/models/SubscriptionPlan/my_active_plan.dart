import 'dart:convert';

MyActivePlanModel myActivePlanFromJson(String str) => MyActivePlanModel.fromJson(json.decode(str));

class MyActivePlanModel {
  MyActivePlanModel({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  Data? data;

  factory MyActivePlanModel.fromJson(Map<String, dynamic> json) => MyActivePlanModel(
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
    this.status,
    this.id,
    this.buyingDate,
    this.userId,
    this.subscriptionId,
    this.updatedAt,
    this.createdAt,
  });

  bool? status;
  int? id;
  DateTime? buyingDate;
  int? userId;
  int? subscriptionId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        id: json["id"],
        buyingDate: json["buyingDate"] != null ? DateTime.parse(json["buyingDate"]) : null,
        userId: json["userId"],
        subscriptionId: json["subscriptionId"],
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "buyingDate": buyingDate != null
            ? ("${buyingDate!.year.toString().padLeft(4, '0')}-${buyingDate!.month.toString().padLeft(2, '0')}-${buyingDate!.day.toString().padLeft(2, '0')}")
            : null,
        "userId": userId,
        "subscriptionId": subscriptionId,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
