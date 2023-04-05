import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLoc {
  String? pickCity;
  String? pickCityID;
  String? pickCityAddr;
  LatLng? pickCoordinates;

  String? dropCity;
  String? dropCityID;
  String? dropCityAddr;
  LatLng? dropCoordinates;

  DateTime? pickTime;
  DateTime? dropTime;

  CurrentLoc(
      {this.pickCity,
      this.pickCityID,
      this.pickCityAddr,
      this.pickCoordinates,
      this.dropCity,
      this.dropCityID,
      this.dropCityAddr,
      this.dropCoordinates,
      this.pickTime,
      this.dropTime});
}
