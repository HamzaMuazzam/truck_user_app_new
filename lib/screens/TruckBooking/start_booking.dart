import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:sultan_cab/utils/strings.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '/providers/GoogleMapProvider/location_and_map_provider.dart';
import '/utils/colors.dart';
import '/utils/sizeConfig.dart';

import 'chooseCities.dart';
import 'choose_vehicle.dart';
import 'destination_location.dart';
import 'drop_off_location.dart';
import 'pickup_location.dart';
import 'searching_widget.dart';

class StartBooking extends StatefulWidget {
  const StartBooking({Key? key}) : super(key: key);

  @override
  _StartBookingState createState() => _StartBookingState();
}

GoogleMapController? mapController;

class _StartBookingState extends State<StartBooking> {
  late LocationAndMapProvider gMapProv;
  Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String location = "";

  @override
  void initState() {
    gMapProv = Provider.of<LocationAndMapProvider>(context, listen: false);
    gMapProv.setCurrentLocMarker();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final appProvider = Provider.of<AppFlowProvider>(context);

    return WillPopScope(
      onWillPop: () async {
        if (appProvider.stage == BookingStage.Destination) {
          appProvider.changeBookingStage(BookingStage.PickUp);
          return false;
        } else if (appProvider.stage == BookingStage.Vehicle) {
          appProvider.changeBookingStage(BookingStage.Destination);
          return false;
        } else if (appProvider.stage == BookingStage.Booked) {
          appProvider.changeBookingStage(BookingStage.PickUp);
          return false;
        } else if (appProvider.stage == BookingStage.SearchingVehicle)
          return false;
        else
          return true;
      },
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: greybackColor,
        body: SafeArea(
          top: appProvider.stage != BookingStage.PickUp,
          child: Consumer<LocationAndMapProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return value.newCameraPosition != null
                  ?

              Stack(
                children: [

                  Column(
                    children: [
                      Expanded(
                        child: !appProvider.isMap
                            ? Container(
                          color: Colors.white,
                        )
                            : GoogleMap(
                          mapType: MapType.normal,
                          compassEnabled: true,
                          myLocationButtonEnabled: false,
                          myLocationEnabled: false,
                          buildingsEnabled: false,
                          markers:
                          (appProvider.destinationType == DestinationType.Multiple)
                              ? appProvider.markerSet
                              : {
                            if (appProvider.currentLoc != null)
                              Marker(
                                markerId: MarkerId(PickupLabel),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed,
                                ),
                                infoWindow: InfoWindow(title: "Loadup Point"),
                                position: LatLng(
                                  appProvider.currentLoc!.latitude,
                                  appProvider.currentLoc!.longitude,
                                ),
                              ),
                            if (appProvider.destLoc != null)
                              Marker(
                                markerId: MarkerId(DestinationLabel),
                                icon: BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueBlue,
                                ),
                                infoWindow:
                                InfoWindow(title: DestinationPointLabel),
                                position: LatLng(
                                  appProvider.destLoc!.latitude,
                                  appProvider.destLoc!.longitude,
                                ),
                              ),
                          },
                          polylines: appProvider.destinationType ==
                              DestinationType.Multiple
                              ? appProvider.polylineSet
                              : {
                            if (appProvider.directions != null)
                              Polyline(
                                polylineId: PolylineId('route'),
                                color: Colors.black,
                                width: 3,
                                points:
                                appProvider.directions!.polylinePoints!.map(
                                      (e) {
                                    return LatLng(e!.latitude, e.longitude);
                                  },
                                ).toList(),
                              )
                          },
                          initialCameraPosition: value.newCameraPosition == null
                              ? value.initCameraPosition
                              : value.newCameraPosition!,
                          onMapCreated: (GoogleMapController controller) async {
                            value.setCurrentLocMarker();
                            _controller.complete(controller);
                            mapController = controller;
                            await mapController!.animateCamera(
                              CameraUpdate.newCameraPosition(value.newCameraPosition!),
                            );
                          },
                        ),
                      ),

                      if (appProvider.stage == BookingStage.PickUp && appProvider.destinationType == DestinationType.Single)
                        PickupLocation(),
                      if (appProvider.stage == BookingStage.DropOffLocation && appProvider
                          .destinationType == DestinationType.Single)
                        DropOffLocation(),

                    ],
                  ),

                  if (appProvider.stage == BookingStage.Destination)
                    DestinationScreen(),
                  if (appProvider.stage == BookingStage.Vehicle)
                    ChooseCar(),
                  if (appProvider.stage == BookingStage.City)
                    ChooseCities(),
                  if (appProvider.stage == BookingStage.SearchingVehicle)
                    SearchingWidget(),

                ],
              )
                  : SizedBox();
            },
          ),
        ),
      ),
    );
  }
}