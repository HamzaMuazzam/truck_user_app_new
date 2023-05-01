import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/widgets/app_widgets.dart';

import '../../utils/commons.dart';
import '../truck_provider/app_flow_provider.dart';

AppFlowProvider appFlowProvider = Provider.of<AppFlowProvider>(Get.context!, listen: false);
LocationAndMapProvider locProv =
Provider.of<LocationAndMapProvider>(Get.context!, listen: false);
class LocationAndMapProvider extends ChangeNotifier {
  String googleMapApiKey = "AIzaSyCqcZ7xj1BPJeC3Uyo2coGi9qaGNpyU_EA";

  Completer<GoogleMapController> mapController = Completer();
  loc.Location location = loc.Location();

  PolylinePoints polylinePoints = PolylinePoints();
  bool isChange = false;

  loc.LocationData? currentPosition;
  Set<Marker> locMarkers = {};
  Set<Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];
  CameraPosition? newCameraPosition;
  Marker? currentLocMarker;
  Marker? driverLocMarker;
  Marker? desLocMarker;

  void setCurrentMarker() {
    currentLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      markerId: MarkerId("currentLocMarker"),
      position: LatLng(currentPosition!.latitude!, currentPosition!.longitude!),
    );
    notifyListeners();
  }

  void setDriverMarker() async {
    driverLocMarker = Marker(
      icon: BitmapDescriptor.fromBytes(
          await AppWidgets.getBytesFromAsset("assets/images/driver_location.png", 100)),
      markerId: MarkerId("driverLocMarker"),
      position: LatLng(double.parse(taxiBookingProvider.onDriverLocationChange!.lat),
          double.parse(taxiBookingProvider.onDriverLocationChange!.lng)),
    );
    addMarkers();
    addPolyPoints();
  }

  void setDesMarker() {
    desLocMarker = Marker(
      markerId: MarkerId("desLocMarker"),
      position: LatLng(taxiBookingProvider.bidAcceptModel?.data?.requestData?.endLat ?? 0.0,
          taxiBookingProvider.bidAcceptModel?.data?.requestData?.endLng ?? 0.0),
    );
  }

  CameraPosition initCameraPosition = CameraPosition(
    /// LAt LNG for Lahore
    target: LatLng(31.5204, 74.3587),
    zoom: 5,
  );

  Future<void> setCurrentLocMarker() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever)
      await Geolocator.requestPermission();

    final loc =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    newCameraPosition = CameraPosition(target: LatLng(loc.latitude, loc.longitude), zoom: 15);
    appFlowProvider.currentLoc = LatLng(loc.latitude, loc.longitude);
    notifyListeners();
  }

  double calculateRadius({required double lat, required double lon}) {
    /// Return in meters
    return Geolocator.distanceBetween(
        currentPosition!.latitude!, currentPosition!.longitude!, lat, lon);

  }

  Future getCurrentPosition({bool addMarker = false}) async {
    bool serviceEnabled;
    loc.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    currentPosition = await location.getLocation();
    setCurrentMarker();
    notifyListeners();
  }

  void addMarkers() async {
    if (currentPosition != null)
      locMarkers = <Marker>{
        if (taxiBookingProvider.stage != RideStage.Started) currentLocMarker!,
        if (taxiBookingProvider.stage == RideStage.DriverToRider) driverLocMarker!,
        if (taxiBookingProvider.stage == RideStage.Started) desLocMarker!,
      };
    notifyListeners();
  }

  void addPolyPoints() async {
    if (currentPosition == null) return;
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapApiKey,
      PointLatLng(currentPosition!.latitude!, currentPosition!.longitude!),
      PointLatLng(taxiBookingProvider.bidAcceptModel?.data?.requestData?.startLat ?? 0.0,
          taxiBookingProvider.bidAcceptModel?.data?.requestData?.startLng ?? 0.0),
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );

      result.points.removeLast();
      polyLines.clear();
      Polyline polyline = Polyline(
        width: 3,
        polylineId: PolylineId("poly"),
        color: Colors.black,
        points: polylineCoordinates,
      );
      polyLines.add(polyline);
      notifyListeners();
    }
  }
  void removePolyPoints() async {


    // if (currentPosition == null) return;

      polylineCoordinates.clear();
      polyLines.clear();
      notifyListeners();

  }
}
