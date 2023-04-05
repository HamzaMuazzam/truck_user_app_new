import 'dart:convert';

GetCancelReasonModel getCancelReasonModelFromJson(String str) =>
    GetCancelReasonModel.fromJson(json.decode(str));

String getCancelReasonModelToJson(GetCancelReasonModel data) => json.encode(data.toJson());

class GetCancelReasonModel {
  GetCancelReasonModel({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  List<Datum>? data;

  factory GetCancelReasonModel.fromJson(Map<String, dynamic> json) => GetCancelReasonModel(
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
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.reasonText,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? reasonText;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        reasonText: json["reasonText"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reasonText": reasonText,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
