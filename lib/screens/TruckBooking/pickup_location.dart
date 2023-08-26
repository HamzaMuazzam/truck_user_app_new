import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:map_location_picker/map_location_picker.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';

import '../../models/directions_model.dart';
import '../../services/directions_services.dart';
import '../../utils/const.dart';
import '/utils/api_keys.dart';
import '/utils/colors.dart';
import '/utils/sizeConfig.dart';
import '/utils/strings.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../utils/commons.dart';

class PickupLocation extends StatefulWidget {
  @override
  State<PickupLocation> createState() => _PickupLocationState();
}

Future<String> getCityName(double lat, double lng) async {
  try {
    final apiKey = GoogleMapApiKey; // Replace with your Google Maps API key
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    logger.i(data);
    var city = "";
    final cityName = data["results"][0]["address_components"];
    for (var x in cityName) {
      var list = x["types"] as List;
      list.forEach((element) {
        if (element == "locality") {
          city = x["long_name"].toString();
        }
        ;
      });
    }
    return city;
  } catch (e) {
    print(e);
    return "";
  }
}

class _PickupLocationState extends State<PickupLocation> {
  @override
  void initState() {
    locProv.setCurrentLocMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final h = MediaQuery.of(context).size.height / 812;
    final b = MediaQuery.of(context).size.width / 375;
    return Consumer<AppFlowProvider>(
        builder: (BuildContext context, value, Widget? child) {
      return Column(
        children: [
          InkWell(
            onTap: () async {
              try {
                Get.dialog(Center(
                  child: CircularProgressIndicator(),
                ));
                await fairTruckProvider.getAllOrdersDetails();
                if (Get.isDialogOpen == true) {
                  Get.back();
                }
                if (fairTruckProvider.getAllOrdersResponse != null &&
                    fairTruckProvider.getAllOrdersResponse.isNotEmpty) {
                  for (int i = 0;
                      i < fairTruckProvider.getAllOrdersResponse.length;
                      i++) {
                    if (fairTruckProvider.getAllOrdersResponse[i].isPaid == false || fairTruckProvider.getAllOrdersResponse[i].isPaid ==
                            null &&(fairTruckProvider.getAllOrdersResponse[i].isLoaded==true)) {
                      showAlertWarning();
                      return;
                    }
                  }
                }

                String? address;
                String? city = "";
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
                        city = await getCityName(
                            latlng!.latitude, latlng!.longitude);
                        Get.back();
                      }
                    },
                  ));
                } else {
                  await 1.delay();
                  LocationResult? result =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlacePicker(GoogleMapApiKey),
                  ));
                  address = result?.formattedAddress!;
                  latlng = result?.latLng;
                  city = result?.city!.name!;

                }
                await 1.delay();

                if (address != null && latlng != null) {
                  appProvider.currentAddress = address;
                  await appProvider.setPickUpLoc(latlng!, address!);

                  if (appProvider.currentAddress == null) {
                    await AppConst.infoSnackBar(ChooseStartingMsg);
                    return;
                  } else {
                    fairTruckProvider.loadCity = city!;
                    await Provider.of<AppFlowProvider>(context, listen: false)
                        .changeBookingStage(BookingStage.DropOffLocation);
                  }
                }
                if (appFlowProvider.pickupLocation?.latLng != null) {
                  Directions? dir = await DirectionServices().getDirections(
                      origin: appProvider.currentLoc!,
                      dest: appProvider.destLoc ?? LatLng(0.0, 0.0));
                  if (dir != null) {
                    await appProvider.setDirections(dir);
                  }
                }
              } catch (e) {
                logger.e(e);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: b * 20,
                vertical: h * 20,
              ),
              decoration: allBoxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Load Location",
                      style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.search,
                        size: h * 18,
                      ),
                      sw(10),
                      Expanded(
                        child: Text(
                          appProvider.currentAddress ?? ChooseYourLocLabel,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: h * 12),
                        ),
                      ),
                      sw(10),
                      Icon(
                        Icons.location_pin,
                        size: h * 18,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          sh(40),
        ],
      );
    });
  }

  showAlertWarning() async {
    await 0.delay();
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            width: Get.width,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Alert!",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\nYou can't book new order until you pay for your previous order.\n\n"
                    "Please go to order history and pay for your previous order.\n",
                    style: TextStyle(color: Colors.black),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
