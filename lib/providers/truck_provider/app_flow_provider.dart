import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/directions_model.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/services/directions_services.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/strings.dart';

import '../../screens/TruckBooking/home_page.dart';
import '../../screens/TruckBooking/start_booking.dart';
import '../GoogleMapProvider/location_and_map_provider.dart';

enum BookingStage {
  PickUp,
  DropOffLocation,
  Destination,
  Vehicle,
  City,
  SearchingVehicle,
  Booked,
  BiddingFound,
  DriverAssign,
  RideStarted,
}

enum DestinationType {
  Multiple,
  Single,
  SelectRideType,
}

enum RideType {
  Regular,
  Reoccurring,
  Favorite,
}
final appProvider = Provider.of<AppFlowProvider>(Get.context!, listen: false);
class AppFlowProvider extends ChangeNotifier {
  int rideValue = -1;

  RideType rideType = RideType.Regular;

  changeRideType(RideType rideType) {
    this.rideType = rideType;
    notifyListeners();
  }

  BookingStage stage = BookingStage.PickUp;

  DestinationType _type = DestinationType.Single;
  DestinationType get destinationType => _type;

  LatLng? currentLoc;

  String? currentAdd;

  LatLng? _destLoc;
  LatLng? get destLoc => _destLoc;

  String? _destAdd;
  String? get destAdd => _destAdd;

  Directions? _directions;
  Directions? get directions => _directions;

  bool _isMap = true;
  bool get isMap => _isMap;

  LocationResult? pickupLocation;

  List<MultiDestinationsModel> multiDestinationList = <MultiDestinationsModel>[];
  Set<Marker> markerSet = <Marker>[].toSet();
  Set<Polyline> polylineSet = <Polyline>[].toSet();

  getMultipleAddressAndDistance() {
    Map<String, String> body = {
      "isMultiDestination": "true",
    };

    double dis = 0;
    double totalDis = 0;

    for (int i = 0; i < multiDestinationList.length; i++) {
      dis = double.parse(multiDestinationList[i].distance.replaceAll("m", ""));
      totalDis = totalDis + dis;
    }

    body.addAll({"distanceKM": "${totalDis.round()}"});

    for (int i = 0; i < multiDestinationList.length; i++) {
      body.addAll({
        "multiDestinations[$i][lat]": "${multiDestinationList[i].locationResult!.latLng!.latitude}",
        "multiDestinations[$i][lng]":
            "${multiDestinationList[i].locationResult!.latLng!.longitude}",
        "multiDestinations[$i][addressTill]":
            "${multiDestinationList[i].locationResult!.formattedAddress}",
        "estimatedTimeTill[$i]": "${multiDestinationList[i].waitingTime}",
      });
    }

    taxiBookingProvider.multipleRideFields = body;
    notifyListeners();
    logger.i(body);
  }

  addMarker(LatLng latLng) {
    if (currentLoc != null) {
      Marker currentMarker = Marker(
        markerId: MarkerId(PickupLabel),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
        infoWindow: InfoWindow(title: "Pickup Point"),
        position: LatLng(
          currentLoc!.latitude,
          currentLoc!.longitude,
        ),
      );

      markerSet.add(currentMarker);
    }
    if (multiDestinationList.isNotEmpty) {
      Marker marker = Marker(
          markerId: MarkerId("marker${latLng.latitude}"),
          position: LatLng(
            latLng.latitude,
            latLng.longitude,
          ));

      markerSet.add(marker);
    }
    notifyListeners();
  }

  addPolyLines(LatLng latLng) {
    if (currentLoc != null) {
      Polyline currentLoc = Polyline(
        polylineId: PolylineId(PickupLabel),
        points: directions!.polylinePoints!.map(
          (e) {
            return LatLng(e!.latitude, e.longitude);
          },
        ).toList(),
      );

      polylineSet.add(currentLoc);
    }
    Polyline polyline = Polyline(
      polylineId: PolylineId(
        "poly${latLng.latitude}",
      ),
      points: multiDestinationList.map(
        (e) {
          return LatLng(e.locationResult!.latLng!.latitude, e.locationResult!.latLng!.longitude);
        },
      ).toList(),
    );
    if (multiDestinationList.isNotEmpty) {
      polylineSet.add(polyline);
    }

    notifyListeners();
  }

  addMultiDestination(MultiDestinationsModel data) {
    multiDestinationList.add(data);
    addMarker(data.locationResult!.latLng!);
    addPolyLines(data.locationResult!.latLng!);
    calculateDistance(data.locationResult!);
    notifyListeners();
  }

  removeMultiDestination(int index) {
    multiDestinationList.removeAt(index);
    notifyListeners();
  }

  changeBookingStage(BookingStage currentStage) {
    stage = currentStage;
    notifyListeners();
  }

  changeDestinationType(DestinationType type) {
    _type = type;
    logger.wtf(stage);
    Future.delayed(Duration.zero, () => notifyListeners());
  }

  changeMapStatus(bool status) {
    _isMap = status;
    notifyListeners();
  }

  Future setPickUpLoc(LatLng loc, String add) async {
    currentLoc = loc;
    currentAdd = add;
    await mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 15)));
    addMarker(loc);
    notifyListeners();
  }
  Future removePickUpLoc() async {
    currentLoc = null;
    currentAdd = null;
    notifyListeners();
  }
  Future setDestinationLoc(LatLng loc, String add) async {
    _destLoc = loc;
    _destAdd = add;
    await mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: loc, zoom: 15)));
    notifyListeners();
  }
  Future setDirections(Directions dir) async {
    _directions = dir;
    await mapController!.animateCamera(CameraUpdate.newLatLngBounds(directions!.bounds!, 100),
    );
    notifyListeners();
  }
  Future removeDirections() async {
    _directions = null;
    notifyListeners();
  }
  Future removeDestinationLoc() async {
    _destLoc = LatLng(0.0, 0.0);
    _destAdd = null;
    // var value=await locProv.getCurrentPosition();
    // await mapController!
    //     .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: value, zoom: 15)));
    notifyListeners();
  }

  List<int> multipleDistance = <int>[];

  String totalDistance = "";
  calculateDistance(LocationResult result) async {
    Directions? dir =
        await DirectionServices().getDirections(origin: currentLoc!, dest: result.latLng!);
    if (dir != null) {
      totalDistance = await dir.totalDistance ?? "";
      notifyListeners();
    }
  }

  Future<String?> getPickupAddress(double lat, double lng) async {
    List<Placemark>? placeMarks = await placemarkFromCoordinates(lat, lng);
    Placemark first = placeMarks.first;

    currentAdd = "${first.subLocality} ${first.administrativeArea} "
        "${first.subAdministrativeArea} ${first.name}";
    notifyListeners();
    return currentAdd;
  }
}

class MultiDestinationsModel {
  final LocationResult? locationResult;
  final String travelTime;
  final String price;
  final String distance;
  final String fair;
  final String waitingTime;

  MultiDestinationsModel({
    this.locationResult,
    this.travelTime = '',
    this.price = '',
    this.distance = '',
    this.fair = '',
    this.waitingTime = '',
  });
}
