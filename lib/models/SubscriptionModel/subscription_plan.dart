import 'dart:convert';

SubscriptionPlanModel subscriptionPlanModelFromJson(String str) =>
    SubscriptionPlanModel.fromJson(json.decode(str));

class SubscriptionPlanModel {
  SubscriptionPlanModel({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  List<Datum>? data;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => SubscriptionPlanModel(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
    this.status,
    this.discountValue,
    this.planName,
    this.discountCode,
    this.discountType,
    this.validTill,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  bool? status;
  int? discountValue;
  String? planName;
  String? discountCode;
  String? discountType;
  DateTime? validTill;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        status: json["status"],
        discountValue: json["discountValue"],
        planName: json["planName"],
        discountCode: json["discountCode"],
        discountType: json["discountType"],
        validTill: json["validTill"] != null ? DateTime.parse(json["validTill"]) : null,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "discountValue": discountValue,
        "planName": planName,
        "discountCode": discountCode,
        "discountType": discountType,
        "validTill": validTill,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
