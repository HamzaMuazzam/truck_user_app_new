// To parse this JSON data, do
//
//     final getTruckFareResponse = getTruckFareResponseFromJson(jsonString);

import 'dart:convert';

List<GetTruckFareResponse> getTruckFareResponseFromJson(String str) => List<GetTruckFareResponse>.from(json.decode(str).map((x) => GetTruckFareResponse.fromJson(x)));

String getTruckFareResponseToJson(List<GetTruckFareResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTruckFareResponse {
  GetTruckFareResponse({
    this.id,
    this.truckName,
    this.truckType,
    this.farePerKm,
    this.commission,
    this.vat,
    this.quantity=0,
  });

  int? id;
  String? truckName;
  String? truckType;
  double? farePerKm;
  String? commission;
  int quantity;
  String? vat;

  factory GetTruckFareResponse.fromJson(Map<String, dynamic> json) => GetTruckFareResponse(
    id: json["id"],
    truckName: json["truckName"],
    truckType: json["truckType"],
    farePerKm: json["farePerKM"],
    commission: json["commission"],
    vat: json["vat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "truckName": truckName,
    "truckType": truckType,
    "farePerKM": farePerKm,
    "commission": commission,
    "vat": vat,
  };
}
