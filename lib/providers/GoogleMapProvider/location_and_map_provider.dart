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

import '../truck_provider/app_flow_provider.dart';

AppFlowProvider appFlowProvider =
    Provider.of<AppFlowProvider>(Get.context!, listen: false);
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
      icon: BitmapDescriptor.fromBytes(await AppWidgets.getBytesFromAsset(
          "assets/images/driver_location.png", 100)),
      markerId: MarkerId("driverLocMarker"),
      position: LatLng(
          double.parse(taxiBookingProvider.onDriverLocationChange!.lat),
          double.parse(taxiBookingProvider.onDriverLocationChange!.lng)),
    );
    addMarkers();
  }

  CameraPosition initCameraPosition = CameraPosition(
    /// LAt LNG for Lahore
    target: LatLng(31.5204, 74.3587),
    zoom: 5,
  );

  Future<void> setCurrentLocMarker() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      showLocationPermissionDialog(Get.context!, () {}, () async {
        await Geolocator.requestPermission();
        _hasPermissions();
      });
      return;
    } else {
      _hasPermissions();
    }
  }

  void _hasPermissions() async {
    final loc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    newCameraPosition =
        CameraPosition(target: LatLng(loc.latitude, loc.longitude), zoom: 15);
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
        if (taxiBookingProvider.stage == RideStage.DriverToRider)
          driverLocMarker!,
        if (taxiBookingProvider.stage == RideStage.Started) desLocMarker!,
      };
    notifyListeners();
  }
}

class LocationPermissionDialog extends StatelessWidget {
  var onLaterPressed;
  var onGrantPressed;
  LocationPermissionDialog(this.onLaterPressed, this.onGrantPressed);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              size: 48,
              color: Colors.blue,
            ),
            SizedBox(height: 16.0),
            Text(
              "Why do we need your location?".tr,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "To process your order smoothly, we need access to your pickup and drop off locations. This enables us to find the nearest drivers and deliver your order efficiently."
                  .tr,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                onGrantPressed();
                Navigator.of(context).pop();
              },
              child: Text("Grant Location Permission".tr),
            ),
            TextButton(
              onPressed: () {
                onLaterPressed();
                Navigator.of(context).pop();
              },
              child: Text("Maybe Later".tr),
            ),
          ],
        ),
      ),
    );
  }
}

void showLocationPermissionDialog(
    BuildContext context, var onLaterPressed, var onGrantPressed) {
  showDialog(
    context: context,
    builder: (context) =>
        LocationPermissionDialog(onLaterPressed, onGrantPressed),
  );
}
