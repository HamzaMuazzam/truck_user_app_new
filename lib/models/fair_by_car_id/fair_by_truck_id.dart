// To parse this JSON data, do
//
//     final getTruckFareResponse = getTruckFareResponseFromJson(jsonString);

import 'dart:convert';

List<GetTruckFareResponse> getTruckFareResponseFromJson(String str) => List<GetTruckFareResponse>.from(json.decode(str).map((x) => GetTruckFareResponse.fromJson(x)));

String getTruckFareResponseToJson(List<GetTruckFareResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTruckFareResponse {
  int? id;
  String? truckName;
  String? truckType;
  String? upto100Km;
  String? upto400Km;
  String? moreThan400KmFares;
  String? commission;
  dynamic vat;
  int quantity=0;

  GetTruckFareResponse({
    this.id,
    this.truckName,
    this.truckType,
    this.upto100Km,
    this.upto400Km,
    this.moreThan400KmFares,
    this.commission,
    this.vat,
    this.quantity=0,
  });

  factory GetTruckFareResponse.fromJson(Map<String, dynamic> json) => GetTruckFareResponse(
    id: json["id"],
    truckName: json["truckName"],
    quantity: 0,
    truckType: json["truckType"],
    upto100Km: json["upto100KM"],
    upto400Km: json["upto400KM"],
    moreThan400KmFares: json["moreThan400KMFares"],
    commission: json["commission"],
    vat: json["vat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "truckName": truckName,
    "quantity": quantity,
    "truckType": truckType,
    "upto100KM": upto100Km,
    "upto400KM": upto400Km,
    "moreThan400KMFares": moreThan400KmFares,
    "commission": commission,
    "vat": vat,
  };
}
