import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';

import '/models/directions_model.dart';
import '/services/directions_services.dart';
import '/utils/api_keys.dart';
import '/utils/colors.dart';
import '/utils/sizeConfig.dart';
import '/utils/strings.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../utils/const.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
class PickupLocation extends StatefulWidget {
  @override
  State<PickupLocation> createState() => _PickupLocationState();
}
Future<String> getCityName(double lat, double lng) async {
  try{
    final apiKey = GoogleMapApiKey; // Replace with your Google Maps API key
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey";
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    final cityName = data["results"][0]["address_components"];
    print(cityName);
    for(var x in cityName){
      if(x["types"].toString().contains("locality")){
        return x["long_name"].toString();
      }
    }
    return "";


  }catch(e){
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
              String? address;
              String? city="";
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
                latlng =result!.latLng;
                city=result.city!.name!;
              }

              if (address != null && latlng!=null) {
                appProvider.currentAdd = address;
                await appProvider.setPickUpLoc(
                    latlng!, address!);

                if (appProvider.currentAdd == null) {
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
                          appProvider.currentAdd ?? ChooseYourLocLabel,
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
}
