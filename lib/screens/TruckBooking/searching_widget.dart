import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/app_button.dart';

import '../../models/Truck_models/getAllOrdersResponse.dart';
import '../../providers/GoogleMapProvider/location_and_map_provider.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../services/ApiServices/api_services.dart';
import '../../utils/commons.dart';
import '../../utils/strings.dart';
import 'GetAllOrdersScreen.dart';
import 'getOrderDetailsById.dart';
import 'home_page.dart';
import 'navigation_screen.dart';

class SearchingWidget extends StatefulWidget {
  const SearchingWidget({Key? key}) : super(key: key);

  @override
  _SearchingWidgetState createState() => _SearchingWidgetState();
}

GoogleMapController? mapController;

class _SearchingWidgetState extends State<SearchingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController aniController;
  late AppFlowProvider appFlowProvider;
  late TruckBookingProvider taxiBookingProvider;
  late LocationAndMapProvider gMapProv;
  Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String location = "";

  @override
  void initState() {
    var context = Get.context!;
    gMapProv = Provider.of<LocationAndMapProvider>(context, listen: false);
    gMapProv.setCurrentLocMarker();
    super.initState();
    aniController = AnimationController(
      vsync: this,
      lowerBound: 0,
      duration: Duration(seconds: 3),
    )..repeat();
    appFlowProvider = Provider.of<AppFlowProvider>(context, listen: false);
    taxiBookingProvider =
        Provider.of<TruckBookingProvider>(context, listen: false);

    bookOrder();
  }

  @override
  void dispose() {
    aniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationAndMapProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          body: Stack(
            children: [
              !appProvider.isMap
                  ? Container(
                      color: Colors.white,
                    )
                  : GoogleMap(
                      mapType: MapType.normal,
                      compassEnabled: true,
                      myLocationButtonEnabled: false,
                      myLocationEnabled: false,
                      buildingsEnabled: false,
                      markers: (appProvider.destinationType ==
                              DestinationType.Multiple)
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
                                  points: appProvider
                                      .directions!.polylinePoints!
                                      .map(
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
                          CameraUpdate.newCameraPosition(
                              value.newCameraPosition!),
                        );
                      },
                    ),
              AnimatedBuilder(
                  animation: CurvedAnimation(
                      parent: aniController, curve: Curves.easeInCirc),
                  builder: (context, child) {
                    return Stack(alignment: Alignment.center, children: [
                      _buildContainer(150 * aniController.value),
                      _buildContainer(250 * aniController.value),
                      _buildContainer(350 * aniController.value),
                      Align(child: sh(0))
                    ]);
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppButton(
                    label: "Cancel Booking",
                    onPressed: () async {
                      appFlowProvider.stage = BookingStage.PickUp;

                      Fluttertoast.showToast(
                          msg: "The order has been Cancelled.",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      gotoPage(NavigationScreen(), isClosePrevious: true);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black26.withOpacity(1 - (aniController.value)),
      ),
    );
  }
}

void bookOrder() async {
  try{
    List<dynamic> result = await fairTruckProvider.submitOrder();
    if (result[0] == true) {
      await 3.delay();
      if (!kIsWeb) {
        await Provider.of<AppFlowProvider>(Get.context!, listen: false)
            .changeBookingStage(BookingStage.SearchingVehicle);
        appFlowProvider.stage = BookingStage.PickUp;
      }

      if (!kIsWeb) {
        await Fluttertoast.showToast(
            msg: "The order has been booked.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Get.snackbar("Congratulations", "The order has been booked.");
      }
      await 0.delay();

      if (kIsWeb) {
        appFlowProvider.changeWebWidget(BookingStage.Orders);
      } else {
        gotoPage(NavigationScreen(), isClosePrevious: true);
      }

      if (result[0] == true) {
        fairTruckProvider.gotoOrderBookingScreen(result[1].toString());
      }
    }
  }catch(e){
    print(e);
  }
}
