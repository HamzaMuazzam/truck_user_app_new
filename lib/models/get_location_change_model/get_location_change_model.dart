import 'dart:convert';

OnLocationChange onLocationChangeFromJson(String str) =>
    OnLocationChange.fromJson(json.decode(str));

String onLocationChangeToJson(OnLocationChange data) => json.encode(data.toJson());

class OnLocationChange {
  OnLocationChange({
    required this.userId,
    required this.rideId,
    required this.lat,
    required this.lng,
  });

  String userId;
  String rideId;
  String lat;
  String lng;

  factory OnLocationChange.fromJson(Map<String, dynamic> json) => OnLocationChange(
        userId: json["userId"],
        rideId: json["rideId"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "rideId": rideId,
        "lat": lat,
        "lng": lng,
      };
}
