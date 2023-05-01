
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/fair_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';

import '../../providers/auth_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../services/ApiServices/StorageServices/get_storage.dart';
import '../../widgets/ride_booked_dialog.dart';
import 'booking_summary.dart';
import 'navigation_screen.dart';

enum SingingCharacter { lafayette, jefferson }

class ChooseCar extends StatefulWidget {
  const ChooseCar({Key? key}) : super(key: key);

  @override
  _ChooseCarState createState() => _ChooseCarState();
}

class _ChooseCarState extends State<ChooseCar> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void initState()  {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;
    return Consumer<FairTruckProvider>(builder: (builder, data, child) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              label: 'Select Trailer Type',
            ),
            Container(
              height: h * 380,
              color: greybackColor,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fairTruckProvider.getTruckFareResponse!.length,
                  itemBuilder: (context, index) {
                    var truck = fairTruckProvider.getTruckFareResponse![index];
                    print(data);
                    return SingleChildScrollView(
                      child: Container(
                        // height: h * 100,
                        decoration: BoxDecoration(
                          color: greybackColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 20),
                                  child: Container(
                                    height: h * 54,
                                    width: h * 64,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/flatBedTrailer.png'),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                ),
                                                child: Text(
                                                  fairTruckProvider
                                                      .getTruckFareResponse![
                                                  index]
                                                      .truckName!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: textYellowColor),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15.0,
                                              ),
                                              child: Text(
                                                truck.farePerKm!.toInt().toString() +" per KM",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: greyColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          sw(10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0, top: 20),
                                            child: Row(
                                              children: [

                                                Text(
                                                  fairTruckProvider
                                                      .getTruckFareResponse![
                                                  index]
                                                      .truckType!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: textColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(30),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  sw(70),
                                  InkWell(
                                    onTap: () {
                                      if(fairTruckProvider.getTruckFareResponse![index].quantity>0){
                                        fairTruckProvider.getTruckFareResponse![index].quantity--;
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          border: Border.all(
                                              color: secondaryColor)),
                                      child: Icon(
                                        Icons.remove_rounded,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      truck.quantity.toString(),
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: textColor,
                                              offset: Offset(0, -5))
                                        ],
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.grey,
                                        decorationThickness: 4,
                                        fontSize: 15,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      fairTruckProvider.getTruckFareResponse![index].quantity++;
                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          border: Border.all(
                                              color: secondaryColor)),
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  sw(70),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 90.0, right: 20),
                              child: Container(
                                color: Colors.grey,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            AppButton(
              label: BookingContinue.toUpperCase(),
              onPressed: () async {
                bool where = fairTruckProvider.getTruckFareResponse!.where((element) => element.quantity>0).isNotEmpty;
                if(where){
                  await fairTruckProvider.getAllCities();
                  appFlowProvider.changeBookingStage(BookingStage.City);

                  // Get.to(BookingSummary());
                }else{
                  AppConst.errorSnackBar("Please select one trailer at least");
                  return;
                }



              },
            ),

          ],
        ),
      );
    });
  }

}



// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:sultan_cab/providers/Truck%20_provider/fair_provider.dart';
// import 'package:sultan_cab/utils/colors.dart';
// import 'package:sultan_cab/utils/const.dart';
// import 'package:sultan_cab/utils/sizeConfig.dart';
// import 'package:sultan_cab/utils/strings.dart';
// import 'package:sultan_cab/widgets/app_button.dart';
// import '../../providers/GoogleMapProvider/location_and_map_provider.dart';
// import '../../providers/taxi/app_flow_provider.dart';
// import 'booking_summary.dart';
//
// class ChooseCar extends StatefulWidget {
//   const ChooseCar({Key? key}) : super(key: key);
//
//   @override
//   _ChooseCarState createState() => _ChooseCarState();
// }
//
// GoogleMapController? mapController;
//
// class _ChooseCarState extends State<ChooseCar> {
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   @override
//   late LocationAndMapProvider gMapProv;
//   Completer<GoogleMapController> _controller = Completer();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   String location = "";
//
//   @override
//   void initState() {
//     gMapProv = Provider.of<LocationAndMapProvider>(context, listen: false);
//     // gMapProv.setCurrentLocMarker();
//
//     super.initState();
//   }
//
//   Widget build(BuildContext context) {
//     late LocationAndMapProvider gMapProv;
//     Completer<GoogleMapController> _controller = Completer();
//     final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//     SizeConfig().init(context);
//     var h = SizeConfig.screenHeight / 812;
//     var b = SizeConfig.screenWidth / 375;
//
//     return Scaffold(
//       body: Consumer<FairTruckProvider>(builder: (builder, data, child) {
//         return Stack(
//           children: [
//
//             SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Consumer<LocationAndMapProvider>(
//                       builder: (builder, value, child) {
//                     return !appProvider.isMap
//                         ? Container(
//                             color: Colors.white,
//                           )
//                         : Container(
//                             height: 470,
//                             child: GoogleMap(
//                               mapType: MapType.normal,
//                               compassEnabled: true,
//                               myLocationButtonEnabled: false,
//                               myLocationEnabled: false,
//                               buildingsEnabled: false,
//                               markers: (appProvider.destinationType ==
//                                       DestinationType.Multiple)
//                                   ? appProvider.markerSet
//                                   : {
//                                       if (appProvider.currentLoc != null)
//                                         Marker(
//                                           markerId: MarkerId(PickupLabel),
//                                           icon: BitmapDescriptor
//                                               .defaultMarkerWithHue(
//                                             BitmapDescriptor.hueRed,
//                                           ),
//                                           infoWindow:
//                                               InfoWindow(title: "Loadup Point"),
//                                           position: LatLng(
//                                             appProvider.currentLoc!.latitude,
//                                             appProvider.currentLoc!.longitude,
//                                           ),
//                                         ),
//                                       if (appProvider.destLoc != null)
//                                         Marker(
//                                           markerId: MarkerId(DestinationLabel),
//                                           icon: BitmapDescriptor
//                                               .defaultMarkerWithHue(
//                                             BitmapDescriptor.hueBlue,
//                                           ),
//                                           infoWindow: InfoWindow(
//                                               title: DestinationPointLabel),
//                                           position: LatLng(
//                                             appProvider.destLoc!.latitude,
//                                             appProvider.destLoc!.longitude,
//                                           ),
//                                         ),
//                                     },
//                               polylines: appProvider.destinationType ==
//                                       DestinationType.Multiple
//                                   ? appProvider.polylineSet
//                                   : {
//                                       if (appProvider.directions != null)
//                                         Polyline(
//                                           polylineId: PolylineId('route'),
//                                           color: Colors.black,
//                                           width: 3,
//                                           points: appProvider
//                                               .directions!.polylinePoints!
//                                               .map(
//                                             (e) {
//                                               return LatLng(
//                                                   e!.latitude, e.longitude);
//                                             },
//                                           ).toList(),
//                                         )
//                                     },
//                               initialCameraPosition:
//                                   value.newCameraPosition == null
//                                       ? value.initCameraPosition
//                                       : value.newCameraPosition!,
//                               onMapCreated:
//                                   (GoogleMapController controller) async {
//                                 value.setCurrentLocMarker();
//                                 _controller.complete(controller);
//                                 mapController = controller;
//                                 await mapController!.animateCamera(
//                                   CameraUpdate.newCameraPosition(
//                                       value.newCameraPosition!),
//                                 );
//                               },
//                             ),
//                           );
//                   }),
//                   AppButton(
//                     label: 'Select Trailer Type',
//                   ),
//                   Column(
//                     children: List.generate(
//                         fairTruckProvider.getTruckFareResponse!.length,
//                         (index) {
//                       var truck =
//                           fairTruckProvider.getTruckFareResponse![index];
//                       print(data);
//                       return Container(
//                         // height: h * 100,
//                         decoration: BoxDecoration(
//                           color: greybackColor,
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 15.0, top: 20),
//                                   child: Container(
//                                     height: h * 54,
//                                     width: b * 54,
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.all(
//                                           Radius.circular(10),
//                                         ),
//                                         border: Border.all(
//                                             color: Colors.black, width: 2),
//                                         image: DecorationImage(
//                                             image: AssetImage(
//                                                 'assets/images/flatBedTrailer.png'),
//                                             fit: BoxFit.fill)),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 25),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Expanded(
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                   left: 15.0,
//                                                 ),
//                                                 child: Text(
//                                                   fairTruckProvider
//                                                       .getTruckFareResponse![
//                                                           index]
//                                                       .truckName!
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 20,
//                                                       color: textYellowColor),
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                 right: 15.0,
//                                               ),
//                                               child: Text(
//                                                 truck.farePerKm!
//                                                         .toInt()
//                                                         .toString() +
//                                                     " per KM",
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     color: greyColor),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 40.0, top: 20),
//                                               child: Row(
//                                                 children: [
//                                                   fairTruckProvider
//                                                                   .getTruckFareResponse![
//                                                                       index]
//                                                                   .truckType !=
//                                                               null &&
//                                                           fairTruckProvider
//                                                               .getTruckFareResponse![
//                                                                   index]
//                                                               .truckType!
//                                                               .isNotEmpty
//                                                       ? Icon(
//                                                           truck.quantity > 0
//                                                               ? Icons
//                                                                   .radio_button_on
//                                                               : Icons
//                                                                   .radio_button_off,
//                                                           size: 18,
//                                                           color: truck.quantity >
//                                                                   0
//                                                               ? textYellowColor
//                                                               : Colors.white,
//                                                         )
//                                                       : sw(1),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 5.0, top: 0),
//                                                     child: Text(
//                                                       fairTruckProvider
//                                                           .getTruckFareResponse![
//                                                               index]
//                                                           .truckType!
//                                                           .toString(),
//                                                       style: TextStyle(
//                                                           fontSize: 15,
//                                                           color: textColor),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             sh(30),
//                             Padding(
//                               padding: const EdgeInsets.all(15.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   sw(70),
//                                   InkWell(
//                                     onTap: () {
//                                       if (fairTruckProvider
//                                               .getTruckFareResponse![index]
//                                               .quantity >
//                                           0) {
//                                         fairTruckProvider
//                                             .getTruckFareResponse![index]
//                                             .quantity--;
//                                         setState(() {});
//                                       }
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(50)),
//                                           border: Border.all(
//                                               color: secondaryColor)),
//                                       child: Icon(
//                                         Icons.remove_rounded,
//                                         size: 18,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Text(
//                                       truck.quantity.toString(),
//                                       style: TextStyle(
//                                         shadows: [
//                                           Shadow(
//                                               color: textColor,
//                                               offset: Offset(0, -5))
//                                         ],
//                                         decoration: TextDecoration.underline,
//                                         decorationColor: Colors.grey,
//                                         decorationThickness: 4,
//                                         fontSize: 15,
//                                         color: Colors.transparent,
//                                       ),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       fairTruckProvider
//                                           .getTruckFareResponse![index]
//                                           .quantity++;
//                                       setState(() {});
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(50)),
//                                           border: Border.all(
//                                               color: secondaryColor)),
//                                       child: Icon(
//                                         Icons.add,
//                                         size: 18,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                   sw(70),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(left: 90.0, right: 20),
//                               child: Container(
//                                 color: Colors.grey,
//                                 height: 2,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.only(left:15.0, top:10),
//                 child: IconButton(onPressed: (){
//                   Get.back();
//                 }, icon: Icon(
//                   Icons.arrow_back, color: Colors.black,
//                 )),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: AppButton(
//                 label: BookingContinue.toUpperCase(),
//                 onPressed: () async {
//                   bool where = fairTruckProvider.getTruckFareResponse!
//                       .where((element) => element.quantity > 0)
//                       .isNotEmpty;
//                   if (where) {
//                     Get.to(BookingSummary());
//                   } else {
//                     AppConst.errorSnackBar(
//                         "Please select one trailer at least");
//                     return;
//                   }
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }
