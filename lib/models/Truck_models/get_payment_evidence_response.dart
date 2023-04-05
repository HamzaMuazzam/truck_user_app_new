// To parse this JSON data, do
//
//     final getPaymentEvidanceResponse = getPaymentEvidanceResponseFromJson(jsonString);

import 'dart:convert';

GetPaymentEvidenceResponse getPaymentEvidenceResponseFromJson(String str) =>
    GetPaymentEvidenceResponse.fromJson(json.decode(str));

String getPaymentEvidenceResponseToJson(GetPaymentEvidenceResponse data) =>
    json.encode(data.toJson());

class GetPaymentEvidenceResponse {
  GetPaymentEvidenceResponse({
    this.id,
    this.userId,
    this.user,
    this.orderId,
    this.orderDetails,
    this.filePath,
    this.baseUrl,
    this.isVerified,
    this.paymentVerifiedBy,
    this.paymentVerifiedDate,
  });

  int? id;
  int? userId;
  dynamic user;
  int? orderId;
  dynamic orderDetails;
  String? filePath;
  String? baseUrl;
  bool? isVerified;
  dynamic paymentVerifiedBy;
  dynamic paymentVerifiedDate;

  factory GetPaymentEvidenceResponse.fromJson(Map<String, dynamic> json) =>
      GetPaymentEvidenceResponse(
    id: json["id"],
    userId: json["userId"],
    user: json["user"],
    orderId: json["orderId"],
    orderDetails: json["orderDetails"],
    filePath: json["filePath"],
    baseUrl: json["baseUrl"],
    isVerified: json["isVerified"],
    paymentVerifiedBy: json["paymentVerifiedBy"],
    paymentVerifiedDate: json["paymentVerifiedDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "user": user,
    "orderId": orderId,
    "orderDetails": orderDetails,
    "filePath": filePath,
    "baseUrl": baseUrl,
    "isVerified": isVerified,
    "paymentVerifiedBy": paymentVerifiedBy,
    "paymentVerifiedDate": paymentVerifiedDate,
  };
}
