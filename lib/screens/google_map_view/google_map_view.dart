import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';

class GoogleMapView extends StatefulWidget {
  GoogleMapView({Key? key}) : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final LocationAndMapProvider locProv =
      Provider.of<LocationAndMapProvider>(Get.context!, listen: false);
  final TruckBookingProvider bookingProv =
      Provider.of<TruckBookingProvider>(Get.context!, listen: false);

  bool isArrived = false;
  bool coming = false;
  @override
  void initState() {
    locProv.getCurrentPosition(addMarker: true);
    locProv.addMarkers();

    super.initState();
  }

  @override
  void dispose() {
    locProv.polyLines = {};
    locProv.locMarkers = {};
    locProv.polylineCoordinates = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocationAndMapProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return locProv.currentPosition != null
              ? Consumer<TruckBookingProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return Stack(
                      children: [
                        GoogleMap(
                          polylines: locProv.polyLines,
                          markers: locProv.locMarkers,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              locProv.currentPosition!.latitude!,
                              locProv.currentPosition!.longitude!,
                            ),
                            zoom: 13,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            if (!locProv.mapController.isCompleted)
                              locProv.mapController.complete(controller);
                          },
                        ),

                        // if (taxiBookingProvider.stage == RideStage.FinishRide)
                        //   FinishRideAndReviews(),
                      ],
                    );
                  },
                )
              : SizedBox();
        },
      ),
    );
  }

  Future<int?> cancelReason(TruckBookingProvider taxiBookingProvider) async {
    return Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Why do you want cancel ?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(height: 1, color: Colors.grey.withOpacity(.5)),
          ],
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        isScrollControlled: true);
  }
}
