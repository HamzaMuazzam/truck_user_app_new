import 'dart:convert';

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
import '../NotificationProvider/notification_provider.dart';

FairTruckProvider fairTruckProvider = Provider.of<FairTruckProvider>(Get.context!, listen: false);

class FairTruckProvider extends ChangeNotifier {
  String loadCity = '';
  String unloadCity = '';
  TextEditingController deliveryNote =TextEditingController();
  List<GetTruckFareResponse>? getTruckFareResponse = [];

// var totalFare;
  Future<bool> getAllTruckFairs() async {
    AppConst.startProgress();
    var body =
        await ApiServices.getMethodTruck(feedUrl: ApiUrls.TRUCK_ALL_FARES);
    logger.e(body);
    if (body.isEmpty) return false;

    getTruckFareResponse = getTruckFareResponseFromJson(body);
    logger.i(getTruckFareResponse![0].commission);
    notifyListeners();
    return true;
  }
  int totalValue = 0;
  int totalFair(){
    fairTruckProvider.getTruckFareResponse!.forEach((element) {
      if (element.quantity > 0) {
        var i = element.quantity *
            element.farePerKm!.toInt() *
            double.parse(
                appFlowProvider.directions!.totalDistance!.split(" ")[0])
                .toInt();
        totalValue = totalValue + i;

      }
    });
    return totalValue;
  }
  Future<bool> submitOrder() async {
    var map2 = {
      "title": "",
      "pickUpLat": appFlowProvider.currentLoc!.latitude.toString(),
      "pickUpLng": appFlowProvider.currentLoc!.longitude.toString(),
      "pickUpLink": "https://www.google.com/maps/search/?api=1&query=${appFlowProvider.currentLoc!.latitude.toString()},"
          "${appFlowProvider.currentLoc!.longitude.toString()}",
      "pickUpAddress": appFlowProvider.currentAdd.toString(),
      "dropOffLLink": "https://www.google.com/maps/search/?api=1&query=${appFlowProvider.destLoc!.latitude.toString()},"
          "${appFlowProvider.destLoc!.longitude.toString()}",
      "dropOffAddress": appFlowProvider.destAdd.toString(),
      "dropOffLat": appFlowProvider.destLoc!.latitude.toString(),
      "dropOffLng": appFlowProvider.destLoc!.longitude.toString(),
      "contact": StorageCRUD.getUser().phoneNumber,
      "userId": StorageCRUD.getUser().id,
      "totalFare": '0',
      "distance": appFlowProvider.directions!.totalDistance.toString(),
      "pickUpCity": loadCity,
      "dropOffCity": unloadCity,
      "delieveryNote": deliveryNote.text.toString(),
    };

    List<Map<String, String>> list = [];

    fairTruckProvider.getTruckFareResponse!.forEach((element) {
      if (element.quantity > 0) {
        var i = element.quantity *
            element.farePerKm!.toInt() *
            double.parse(
                    appFlowProvider.directions!.totalDistance!.split(" ")[0])
                .toInt();
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
    String response = await ApiServices.postMethodTruck(
        feedUrl: ApiUrls.BOOKING_REQUEST, body: json.encode(map2));
    AppConst.stopProgress();

    if (response.isEmpty) {
      return false;
    }
    logger.i('booking api done');
    deliveryNote.text='';
    AppConst.successSnackBar(response.toString());

    return true;
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

  List<GetAllOrdersResponse> getAllOrdersResponse=[];
bool allOrders=true;
  Future<bool> getAllOrdersDetails() async {
    getAllOrdersResponse.clear();
    var response = await ApiServices.getMethod(feedUrl: 'Order/get-order-by-c'
        'lient?id=${StorageCRUD.getUser().id}');
    if (response.isEmpty)
      {
        allOrders=false;
        notifyListeners();
        return false;
      }

    getAllOrdersResponse = getAllOrdersResponseFromJson(response)??[];
    if(getAllOrdersResponse!=[])
      {
        logger.i(getAllOrdersResponse);
      }
    allOrders=true;
    notifyListeners();

    return true;
  }


}
