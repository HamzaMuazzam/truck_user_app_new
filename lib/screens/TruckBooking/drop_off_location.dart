import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/directions_model.dart';
import 'package:sultan_cab/screens/TruckBooking/pickup_location.dart';
import 'package:sultan_cab/services/directions_services.dart';
import 'package:sultan_cab/utils/api_keys.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_snackBar.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../utils/commons.dart';
import 'package:http/http.dart' as http;

class DropOffLocation extends StatefulWidget {
  const DropOffLocation({Key? key}) : super(key: key);

  @override
  _DropOffLocationState createState() => _DropOffLocationState();
}

class _DropOffLocationState extends State<DropOffLocation> {
  late TruckBookingProvider taxiProv;
  late AppFlowProvider appProvider;

  Marker? pickMarker;

  @override
  void initState() {
    taxiProv = Provider.of<TruckBookingProvider>(context, listen: false);
    appProvider = Provider.of<AppFlowProvider>(context, listen: false);

    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final h = MediaQuery.of(context).size.height / 812;
    final b = MediaQuery.of(context).size.width / 375;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: b * 20,
        vertical: h * 20,
      ),
      decoration: BoxDecoration(
        color: greybackColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sh(10),
          Container(
            decoration: allBoxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Unload Location",
                    style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (appProvider.currentAddress != null) {

                      String? address;
                      String? city;
                      LatLng? latlng;
                      if (kIsWeb) {
                        await Get.to(MapLocationPicker(
                          apiKey: GoogleMapApiKey,
                          onNext: (GeocodingResult? result) async {
                            if (result != null) {
                              print(result.toJson());
                              address = result.formattedAddress!;
                              latlng = LatLng(result.geometry.location.lat,
                                  result.geometry.location.lng);
                              city = await getCityName(latlng!.latitude,latlng!.longitude);
                              Get.back();
                            }
                          },
                        ));
                      }
                      else {
                        LocationResult? result =
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlacePicker(GoogleMapApiKey),
                        ));
                        address = result?.formattedAddress!;
                        latlng =result?.latLng;
                        city=result?.city!.name!;

                        print(address);
                        print(latlng);
                        print(city);
                      }


                      if (address != null && latlng!=null) {
                        fairTruckProvider.unloadCity=city!;


                        await appProvider.setDestinationLoc(latlng!, address!);
                        Directions? dir = await DirectionServices()
                            .getDirections(
                            origin: appProvider.currentLoc!,
                            dest: latlng!);
                        print(dir);
                        if (dir != null) await appProvider.setDirections(dir);
                        if (appProvider.destAdd == null) {
                          // await AppConst.infoSnackBar(ChooseDestinationMsg);
                          return;
                        }
                        else if (appProvider.currentAddress == null) {
                          // await AppConst.infoSnackBar(ChooseStartingMsg);
                          return;
                        }
                        else {
                          if (await fairTruckProvider.getAllTruckFairs())
                            await Provider.of<AppFlowProvider>(context, listen: false).changeBookingStage(BookingStage.Destination);
                          else
                            logger.e('Error in truck fairs');
                        }

                      }
                    }

                    // else
                    //   appSnackBar(context: context, msg: ChooseStartingMsg, isError: true);
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      height: h * 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          sw(14),
                          Expanded(
                            child: Text(
                              appProvider.destAdd == null ||
                                      appProvider.destAdd == ''
                                  ? SearchDestLabel
                                  : appProvider.destAdd!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: h * 12,
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          sh(20),
          if (appProvider.directions != null &&
              appProvider.destAdd != null &&
              appProvider.currentAddress != null)
            Column(
              children: [
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Icon(Icons.circle, color: secondaryColor, size: 15),
                //     SizedBox(width: 10),
                //     SizedBox(
                //       width: Get.width * .7,
                //       child: Text(
                //         "${appProvider.currentAdd}",
                //         style: TextStyle(),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 5),
                // Container(color: Colors.grey.withOpacity(.5), height: 1.5),
                // SizedBox(height: 5),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Icon(Icons.circle, color: Colors.green, size: 15),
                //     SizedBox(width: 10),
                //     SizedBox(
                //         width: Get.width * .7,
                //         child: Text(
                //           "${appProvider.destAdd!}",
                //           style: TextStyle(),
                //         )),
                //   ],
                // ),
              ],
            ),
          // if (appProvider.directions != null)
          //   Container(
          //     decoration: BoxDecoration(
          //       // color: Color(0xfff3f3f3),
          //       borderRadius: BorderRadius.circular(50),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Text(
          //               "Travel Time-${appProvider.directions!.totalDuration}"),
          //           Text("/"),
          //           if (appProvider.destinationType != DestinationType.Multiple)
          //             Text("Distance-${appProvider.directions!.totalDistance}"),
          //           if (appProvider.destinationType == DestinationType.Multiple)
          //             Text("Distance-${appProvider.totalDistance}"),
          //         ],
          //       ),
          //     ),
          //   ),
          sh(40),
          // AppButton(
          //   label: ProceedLabel,
          //   onPressed: () async {
          //     if (appProvider.destAdd == null) {
          //       await AppConst.infoSnackBar(ChooseDestinationMsg);
          //       return;
          //     } else if (appProvider.currentAdd == null) {
          //       await AppConst.infoSnackBar(ChooseStartingMsg);
          //       return;
          //     } else {
          //       if (await fairTruckProvider.getAllTruckFairs())
          //
          //
          //         await Provider.of<AppFlowProvider>(context, listen: false)
          //             .changeBookingStage(BookingStage.Destination);
          //     }
          //   },
          // )
        ],
      ),
    );
  }
}
