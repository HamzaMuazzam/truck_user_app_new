import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/services/ApiServices/api_services.dart';
import 'package:sultan_cab/utils/const.dart';

import '../../models/Truck_models/getAllCitiesResponse.dart';
import '../../models/Truck_models/getAllOrdersResponse.dart';
import '../../models/fair_by_car_id/fair_by_truck_id.dart';
import '../../screens/TruckBooking/booking_summary.dart';
import '../../screens/TruckBooking/getOrderDetailsById.dart';
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

  // int totalValue = 0;



  Future<List<dynamic>> submitOrder() async {
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
      logger.i(map2);

      List<Map<String, String>> list = [];
      try{
        fairTruckProvider.getTruckFareResponse!.forEach((element) {
          if (element.quantity > 0) {
            String distance;
            if (appFlowProvider.directions == null) {
              distance = "50.0";
            } else {
              distance = appFlowProvider.directions!.totalDistance!.split(" ")[0];
            }
              distance=distance.replaceAll("km", "").replaceAll("Km", "").replaceAll(",","");


            var i = (element.quantity *
                    double.parse(element.moreThan400KmFares!) *
                    double.parse(distance))
                .toInt();
            // totalValue = totalValue + i;
            list.add({
              "truckId": element.id.toString(),
              "noOfTrucks": element.quantity.toString(),
              "totalFare": i.toString(),
            });
          }
        });
      }catch(e){
        print("object "+ e.toString());
      }
      map2["truckDetails"] = list;
      map2["totalFare"] = getTotalFairs().replaceAll(" SAR", "");
      map2["truckDriverFare"] = getTotalFairsWithoutCommission();
      logger.i(map2);
      AppConst.startProgress(barrierDismissible: true);
      String response = await ApiServices.postMethodTruck(feedUrl: ApiUrls.BOOKING_REQUEST, body: json.encode(map2));
      AppConst.stopProgress();
      logger.e(response);
      if (response.isEmpty) {
        return [false,0];
      }
      logger.i('booking api done');
      return [true,json.decode(response)['orderId']];
    } catch (e) {
      print("CATCHED ERROR => "+e.toString());
      return [false,0];
    }
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

  void gotoOrderBookingScreen(String orderID) async{

    String response = await ApiServices.getMethod(feedUrl: "Order/get-order-by-Id?id=$orderID");






    if (response.isNotEmpty) {
      await 5.delay();
      Get.to(OrderDetailById(GetAllOrdersResponse.fromJson(json.decode(response))));
    }
    else{
      Get.snackbar("Error", "Error on getting order");
    }

  }
  String convertTimeString(String time){
    try{
      if (time.contains("hours")) {
        var split = time.split(" ");
        var hours = split[0];
        var mints = split[2];

        if(hours.length==2 && mints.length==2){
          return "$hours:$mints";
        }
        else if(hours.length==1 && mints.length==2) {
          return "0$hours:$mints";
        }
        else if(hours.length==2 && mints.length==1) {
          return "$hours:0$mints";
        }
        else if(hours.length==1 && mints.length==1) {
          return "0$hours:0$mints";
        }
        else{
          return "$hours:$mints";

        }


        } else if (!time.contains("hours") && time.contains("mins")) {
        var split = time.split(" ");
        var mints = split[0];
        if(mints.length==2){

        return "00:$mints";
        }
        else{
          return "00:0$mints";
        }
      }
    }catch(e){
      return "55:00";
    }

    return "45:00";
  }


}
