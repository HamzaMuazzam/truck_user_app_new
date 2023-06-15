import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/screens/TruckBooking/pickup_location.dart';

import '../../customized_plugins/lib/map_location_picker.dart';
import '../../models/directions_model.dart';
import '../../providers/GoogleMapProvider/location_and_map_provider.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../services/directions_services.dart';
import '../../utils/api_keys.dart';
import '../../utils/commons.dart';
import '../../utils/const.dart';
import '../../utils/strings.dart';
import '../../widgets/app_snackBar.dart';

class OrderLocationPickScreenWeb extends StatefulWidget {
  const OrderLocationPickScreenWeb({Key? key}) : super(key: key);

  @override
  State<OrderLocationPickScreenWeb> createState() =>
      _OrderLocationPickScreenWebState();
}

int _index = 0;
String? pickaddress;
String? dropAddress;



class _OrderLocationPickScreenWebState
    extends State<OrderLocationPickScreenWeb> {


  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return null;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return null;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Access the latitude and longitude
    double latitude = position.latitude;
    double longitude = position.longitude;

    print('Latitude: $latitude');
    print('Longitude: $longitude');
    return position;
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    gteLocationLatLng();

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
        ),
        stepper(0),
        SizedBox(
          height: 100,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          InkWell(
            onTap: ()async {
              String? city="";
              LatLng? latlng;
              if (kIsWeb) {
                await Get.to(MapLocationPicker(
                  apiKey: GoogleMapApiKey,
                   currentLatLng: LatLng(position!.latitude,position!.longitude),
                  minMaxZoomPreference: MinMaxZoomPreference(3,20),
                  onNext: (GeocodingResult? result) async {
                    if (result != null) {
                      print(result.toJson());
                      pickaddress = result.formattedAddress!;
                      latlng = LatLng(result.geometry.location.lat,
                          result.geometry.location.lng);
                      city = await getCityName(latlng!.latitude,latlng!.longitude);
                      Get.back();
                      setState(() {
                      });
                    }
                  },
                ));
              }
              else {
                LocationResult? result =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlacePicker(GoogleMapApiKey),
                ));
                pickaddress = result?.formattedAddress!;
                latlng =result!.latLng;
                city=result.city!.name!;
              }

              if (pickaddress != null && latlng!=null) {
                appProvider.currentAdd = pickaddress;
                await appProvider.setPickUpLoc(
                    latlng!, pickaddress!);

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
              setState(() {
              });
            },
            child: Container(
              width: Get.width *0.5,
              height: 55,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(pickaddress??"Picking point",style: TextStyle(color: Colors.black),),
                  )),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: ()async{
              if (appProvider.currentAdd != null) {
                String? city="";
                LatLng? latlng;
                if (kIsWeb) {
                  await Get.to(MapLocationPicker(
                    apiKey: GoogleMapApiKey,
                    currentLatLng:LatLng(position!.latitude,position!.longitude),
                    minMaxZoomPreference: MinMaxZoomPreference(3,20),
                    onNext: (GeocodingResult? result) async {
                      if (result != null) {
                        print(result.toJson());
                        dropAddress = result.formattedAddress!;
                        latlng = LatLng(result.geometry.location.lat,
                            result.geometry.location.lng);
                        city = await getCityName(latlng!.latitude,latlng!.longitude);
                        Get.back();
                        setState(() {
                          
                        });
                      }
                    },
                  ));
                }
                else {
                  LocationResult? result =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PlacePicker(GoogleMapApiKey),
                  ));
                  dropAddress = result?.formattedAddress!;
                  latlng =result!.latLng;
                  city=result.city!.name!;
                }


                if (dropAddress != null && latlng!=null) {
                  fairTruckProvider.unloadCity=city!;


                  await appProvider.setDestinationLoc(latlng!, dropAddress!);
                  Directions? dir = await DirectionServices()
                      .getDirections(
                      origin: appProvider.currentLoc!,
                      dest: latlng!);

                  if (dir != null) await appProvider.setDirections(dir);
                  if (appProvider.destAdd == null) {
                    await AppConst.infoSnackBar(ChooseDestinationMsg);
                    return;
                  }
                  else if (appProvider.currentAdd == null) {
                    await AppConst.infoSnackBar(ChooseStartingMsg);
                    return;
                  }
                  else {
                    if (await fairTruckProvider.getAllTruckFairs())
              await Provider.of<AppFlowProvider>(context, listen: false).changeBookingStage(BookingStage.Destination);
              else
              logger.e('Error in truck fairs');
              }

              }
              } else
              appSnackBar(context: context, msg: ChooseStartingMsg, isError: true);
            },
            child: Container(
              width: Get.width *0.5,
              height: 55,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(dropAddress??"Delivery point",style: TextStyle(color: Colors.black),),
                  )),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),

        ],),

        SizedBox(
          height: 100,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          InkWell(
            onTap: (){
              if(dropAddress==null || pickaddress==null){
                return;
              }
              appFlowProvider.changeWebWidget(BookingStage.Vehicle);
            },
            child: Container(height: 55,width: 150,
            child: Center(child: Text("Next",),),
            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),),
          ),
            SizedBox(
              width: 100,
            ),
        ],)
      ],
    );
  }
  Position? position;
  void gteLocationLatLng() async {
     position = await  getCurrentLocation();
  }
}

Widget stepper(int index) {
  return Column(
    children: [
      Container(
        width: Get.width * 0.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order",
              style: TextStyle(
                  color: index == 0 || index > 0 ? Colors.green : Colors.white),
            ),
            Text("Reached",
                style: TextStyle(
                    color:
                        index == 1 || index > 1 ? Colors.green : Colors.white)),
            Text("Road",
                style: TextStyle(
                    color:
                        index == 2 || index > 2 ? Colors.green : Colors.white)),
            Text("Deliver",
                style: TextStyle(
                    color:
                        index == 3 || index > 3 ? Colors.green : Colors.white))
          ],
        ),
      ),
      Container(

        height: 40,
        width: Get.width * 0.75,
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF35B66D), Color(0xFFF1E41B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 5,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 30,
                            color: index == 0 || index > 0
                                ? Colors.green
                                : Colors.white),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 30,
                            color: index == 1 || index > 1
                                ? Colors.green
                                : Colors.white),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 30,
                            color: index == 2 || index > 2
                                ? Colors.green
                                : Colors.white),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 30,
                            color: index == 3 || index > 3
                                ? Colors.green
                                : Colors.white),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
