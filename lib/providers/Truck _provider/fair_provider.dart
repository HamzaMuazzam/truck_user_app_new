import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/services/ApiServices/api_services.dart';
import 'package:sultan_cab/utils/const.dart';

import '../../models/Truck_models/getAllCitiesResponse.dart';
import '../../models/Truck_models/getAllOrdersResponse.dart';
import '../../models/fair_by_car_id/fair_by_truck_id.dart';
import '../../services/ApiServices/StorageServices/get_storage.dart';
import '../../services/ApiServices/api_urls.dart';
import '../../utils/commons.dart';
import '../GoogleMapProvider/location_and_map_provider.dart';
import '../truck_provider/app_flow_provider.dart';

FairTruckProvider fairTruckProvider =
    Provider.of<FairTruckProvider>(Get.context!, listen: false);

class FairTruckProvider extends ChangeNotifier {
  String loadCity = '';
  String unloadCity = '';
  TextEditingController deliveryNote = TextEditingController();
  List<GetTruckFareResponse>? getTruckFareResponse = [];

  // var totalFare;
  Future<bool> getAllTruckFairs() async {
    AppConst.startProgress();
    var body =
        await ApiServices.getMethodTruck(feedUrl: ApiUrls.TRUCK_ALL_FARES);
    logger.e(body);
    if (body.isEmpty) return false;

    getTruckFareResponse = getTruckFareResponseFromJson(body);
    notifyListeners();
    return true;
  }

  int totalValue = 0;

  int _totalFair() {
    fairTruckProvider.getTruckFareResponse!.forEach((element) {
      String distance;
      if (appFlowProvider.directions == null) {
        distance = "50.0";
      } else {
        distance = appFlowProvider.directions!.totalDistance!.split(" ")[0];
      }
      if (element.quantity > 0) {
        var i = element.quantity *
            element.farePerKm!.toInt() *
            double.parse(distance)
                .toInt();
        totalValue = totalValue + i;
      }
    });
    return totalValue;
  }

  Future<bool> submitOrder() async {
    try {
      AppFlowProvider appFlowProvider =
          Provider.of<AppFlowProvider>(Get.context!, listen: false);

      var string = appFlowProvider.currentLoc!.latitude.toString();
      print(string);
      var string2 = appFlowProvider.currentLoc!.longitude.toString();
      print(string2);
      var string3 = appFlowProvider.currentLoc!.latitude.toString();
      print(string3);
      var string4 = appFlowProvider.currentLoc!.longitude.toString();
      print(string4);
      var string5 = appFlowProvider.currentAdd.toString();
      print(string5);
      var string6 = appFlowProvider.destLoc!.latitude.toString();
      print(string6);
      var string7 = appFlowProvider.destLoc!.longitude.toString();
      print(string7);
      var string8 = appFlowProvider.destAdd.toString();
      print(string8);
      var string9 = appFlowProvider.destLoc!.latitude.toString();
      print(string9);
      var string10 = appFlowProvider.destLoc!.longitude.toString();
      print(string10);
      var number = StorageCRUD.getUser().phoneNumber;
      print(number);
      var id = StorageCRUD.getUser().id;
      var loadCity1 = loadCity;
      print(loadCity1);
      var unloadCity1 = unloadCity;
      print(unloadCity1);
      var string12 = deliveryNote.text.toString();
      print(string12);
      print(id);

      var map2 = {
        "title": "",
        "pickUpLat": appFlowProvider.currentLoc!.latitude.toString(),
        "pickUpLng": appFlowProvider.currentLoc!.longitude.toString(),
        "pickUpLink": "https://www.google.com/maps/search/?api=1&query=${appFlowProvider.currentLoc!.latitude.toString()},${appFlowProvider.currentLoc!.longitude.toString()}",
        "pickUpAddress": appFlowProvider.currentAdd.toString(),
        "dropOffLLink": "https://www.google.com/maps/search/?api=1&query=${appFlowProvider.destLoc!.latitude.toString()},${appFlowProvider.destLoc!.longitude.toString()}",
        "dropOffAddress": appFlowProvider.destAdd.toString(),
        "dropOffLat": appFlowProvider.destLoc!.latitude.toString(),
        "dropOffLng": appFlowProvider.destLoc!.longitude.toString(),
        "contact": StorageCRUD.getUser().phoneNumber,
        "userId": StorageCRUD.getUser().id,
        "totalFare": '0',
        "pickUpCity": loadCity,
        "dropOffCity": unloadCity,
        "delieveryNote": deliveryNote.text.toString(),
        "time":"${convertTimeString(appProvider.directions!.totalDuration!)}"
      };

      if (appFlowProvider.directions != null) {
        map2["distance"] = appFlowProvider.directions?.totalDistance.toString();
      }else{
        map2["distance"]=0.toString();
      }

      List<Map<String, String>> list = [];

      fairTruckProvider.getTruckFareResponse!.forEach((element) {
        if (element.quantity > 0) {
          String distance;
          if (appFlowProvider.directions == null) {
            distance = "50.0";
          } else {
            distance = appFlowProvider.directions!.totalDistance!.split(" ")[0];
          }
          var i = element.quantity *
              element.farePerKm!.toInt() *
              double.parse(distance).toInt();
          totalValue = totalValue + i;
          list.add({
            "truckId": element.id.toString(),
            "noOfTrucks": element.quantity.toString(),
            "totalFare": i.toString(),
          });
        }
      });
      map2["truckDetails"] = list;
      map2["totalFare"] = totalValue.toString();
      logger.i(map2);
      AppConst.startProgress(barrierDismissible: true);
      String response = await ApiServices.postMethodTruck(feedUrl: ApiUrls.BOOKING_REQUEST, body: json.encode(map2));
      AppConst.stopProgress();
      if (response.isEmpty) {
        return false;
      }
      logger.i('booking api done');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


  String convertTimeString(String time){
    try{
      if (time.contains("hours")) {
        var split = time.split(" ");
        var hours = split[0];
        var mints = split[3];
        return "$hours:$mints";
      } else if (!time.contains("hours") && time.contains("mints")) {
        var split = time.split(" ");
        var mints = split[0];
        return "00:$mints";
      }
    }catch(e){
      return "55:00";
    }

    return "55:00";
  }
  List<GetAllCitiesResponse>? getAllCitiesResponse = [];

  Future<bool> getAllCities() async {
    var response =
        await ApiServices.getMethodTruck(feedUrl: ApiUrls.GET_ALL_CITIES);
    if (response.isEmpty) return false;

    getAllCitiesResponse = getAllCitiesResponseFromJson(response);
    notifyListeners();
    return true;
  }

  List<GetAllOrdersResponse> getAllOrdersResponse = [];
  bool allOrders = true;

  Future<bool> getAllOrdersDetails() async {
    getAllOrdersResponse.clear();
    var response = await ApiServices.getMethod(
        feedUrl: 'Order/get-order-by-client?id=${StorageCRUD.getUser().id}');
    if (response.isEmpty) {
      allOrders = false;
      notifyListeners();
      return false;
    }

    getAllOrdersResponse = getAllOrdersResponseFromJson(response);
    getAllOrdersResponse= getAllOrdersResponse.reversed.toList();
    allOrders = true;
    notifyListeners();

    return true;
  }
}
