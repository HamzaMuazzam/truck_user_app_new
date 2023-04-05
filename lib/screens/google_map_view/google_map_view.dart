import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/taxi_booking_provider.dart';
import 'package:sultan_cab/screens/google_map_view/DriverArrival.dart';
import 'package:sultan_cab/screens/google_map_view/finish_ride_and_review.dart';
import 'ride_started.dart';
import 'ride_status_screen.dart';

class GoogleMapView extends StatefulWidget {
  GoogleMapView({Key? key}) : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final LocationAndMapProvider locProv =
      Provider.of<LocationAndMapProvider>(Get.context!, listen: false);
  final TaxiBookingProvider bookingProv =
      Provider.of<TaxiBookingProvider>(Get.context!, listen: false);

  bool isArrived = false;
  bool coming = false;
  @override
  void initState() {
    locProv.getCurrentPosition(addMarker: true);
    locProv.addPolyPoints();
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
              ? Consumer<TaxiBookingProvider>(
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
                        if (taxiBookingProvider.stage == RideStage.DriverToRider)
                          RideStatusScreen(),
                        if (taxiBookingProvider.stage == RideStage.Arrived) DriverArrival(),
                        if (taxiBookingProvider.stage == RideStage.RideStarted) RideStarted(),
                        if (taxiBookingProvider.stage == RideStage.FinishRide)
                          FinishRideAndReviews(),
                      ],
                    );
                  },
                )
              : SizedBox();
        },
      ),
    );
  }

  Future<int?> cancelReason(TaxiBookingProvider taxiBookingProvider) async {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: List.generate(
                  taxiBookingProvider.getCancelReasonModel?.data?.length ?? 0,
                  (index) {
                    final data = taxiBookingProvider.getCancelReasonModel?.data?[index];

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        dense: true,
                        title: Text(data?.reasonText ?? ""),
                        onTap: () {
                          Get.back(result: data?.id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
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
