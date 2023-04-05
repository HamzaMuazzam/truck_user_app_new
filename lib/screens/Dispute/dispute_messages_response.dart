import 'dart:convert';

DisputeMessagesResponse disputeMessagesResponseFromJson(String str) =>
    DisputeMessagesResponse.fromJson(json.decode(str));

class DisputeMessagesResponse {
  DisputeMessagesResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  List<AllMessages>? data;

  factory DisputeMessagesResponse.fromJson(Map<String, dynamic> json) => DisputeMessagesResponse(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: List<AllMessages>.from(json["data"].map((x) => AllMessages.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AllMessages {
  AllMessages({
    this.id,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.sentById,
    this.disputeId,
  });

  int? id;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? sentById;
  int? disputeId;

  factory AllMessages.fromJson(Map<String, dynamic> json) => AllMessages(
        id: json["id"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        sentById: json["sentById"],
        disputeId: json["disputeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "sentById": sentById,
        "disputeId": disputeId,
      };
}
