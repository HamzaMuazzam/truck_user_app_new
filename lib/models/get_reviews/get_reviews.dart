import 'dart:convert';

GetReviewsModel getReviewsModelFromJson(String str) => GetReviewsModel.fromJson(json.decode(str));

String getReviewsModelToJson(GetReviewsModel data) => json.encode(data.toJson());

class GetReviewsModel {
  GetReviewsModel({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  List<Datum>? data;

  factory GetReviewsModel.fromJson(Map<String, dynamic> json) => GetReviewsModel(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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
    this.review,
  });

  int? id;
  String? review;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "review": review,
      };
}
