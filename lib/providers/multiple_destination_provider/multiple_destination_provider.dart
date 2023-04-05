// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:thrifty_cab/utils/commons.dart';
// import 'package:flutter/widgets.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:thrifty_cab/models/directions_model.dart';
// import 'package:thrifty_cab/screens/taxi/start_booking.dart';
// import 'package:thrifty_cab/utils/commons.dart';
//
// enum MultipleBookingStage {
//   PickUp,
//   Destination,
//   Vehicle,
//   SearchingVehicle,
//   Booked,
//   BiddingFound,
//   SingleDestination,
// }
//
// MultipleDestinationProvider multipleDesProv =
//     Provider.of<MultipleDestinationProvider>(Get.context!, listen: false);
//
// class MultipleDestinationProvider extends ChangeNotifier {
//   MultipleBookingStage _stage = MultipleBookingStage.PickUp;
//   MultipleBookingStage get stage => _stage;
//
//   LatLng? _currentLoc;
//   LatLng? get currentLoc => _currentLoc;
//
//   String? _currentAdd;
//   String? get currentAdd => _currentAdd;
//
//   LatLng? _destLoc;
//   LatLng? get destLoc => _destLoc;
//
//   String? _destAdd;
//   String? get destAdd => _destAdd;
//
//   Directions? _directions;
//   Directions? get directions => _directions;
//
//   bool _isMap = true;
//   bool get isMap => _isMap;
//
//   changeBookingStage(MultipleBookingStage currentStage) {
//     _stage = currentStage;
//     logger.wtf(_stage);
//     notifyListeners();
//   }
//
//   changeMapStatus(bool status) {
//     _isMap = status;
//     notifyListeners();
//   }
//
//   Future setCurrentLoc(LatLng loc, String add) async {
//     _currentLoc = loc;
//     _currentAdd = add;
//     await getPickupAddress(currentLoc!.latitude, currentLoc!.longitude);
//     await mapController!
//         .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 15)));
//     notifyListeners();
//   }
//
//   Future setDestinationLoc(LatLng loc, String add) async {
//     _destLoc = loc;
//     _destAdd = add;
//
//     await mapController!
//         .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 15)));
//     notifyListeners();
//   }
//
//   Future setDirections(Directions dir) async {
//     _directions = dir;
//     await mapController!.animateCamera(
//       CameraUpdate.newLatLngBounds(directions!.bounds!, 100),
//     );
//     notifyListeners();
//   }
//
//   String calculateDistance() {
//     double dis = Geolocator.distanceBetween(
//       _currentLoc!.latitude,
//       _currentLoc!.longitude,
//       _destLoc!.latitude,
//       _destLoc!.longitude,
//     );
//
//     return (dis / 1000).toStringAsFixed(3);
//   }
//
//   Future<String?> getPickupAddress(double lat, double lng) async {
//     List<Placemark>? placeMarks = await placemarkFromCoordinates(lat, lng);
//     Placemark first = placeMarks.first;
//
//     _currentAdd = "${first.subLocality} ${first.administrativeArea} "
//         "${first.subAdministrativeArea} ${first.name}";
//     logger.i(_currentAdd);
//
//     notifyListeners();
//     return _currentAdd;
//   }
//
//
// }
