import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/AddToFav/get_fav_drivers.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';
import 'dart:convert';

import '/services/apiServices/api_services.dart';
import '/services/apiServices/api_urls.dart';

AddToFavourite addToFavProv = Provider.of(Get.context!, listen: false);

class AddToFavourite extends ChangeNotifier {
  GetFavDriverModel? getFavDriverModel;

  /// add to fav
  Future<bool> addToFavourite(int driverId) async {
    Map<String, String> fields = {
      "driverId": "${driverId}",
    };

    String response = await ApiServices.postMethod(feedUrl: ApiUrls.ADD_TO_FAV, fields: fields);
    if (response.isEmpty) return false;

    logger.i(response);
    AddToFavModel addToFavModel = rideHistoryModelFromJson(response);
    AppConst.successSnackBar(addToFavModel.message ?? "Success");

    return true;
  }

  /// remove from fav
  Future<bool> removeFromFavourite(int? favId) async {
    AppConst.startProgress();

    Map<String, String> fields = {
      "favId": "${favId}",
    };

    String response =
        await ApiServices.deleteMethod(feedUrl: ApiUrls.REMOVE_FROM_FAV, fields: fields);
    AppConst.stopProgress();

    if (response.isEmpty) return false;
    return true;
  }

  /// get All Fav
  Future<bool> getAllFavourite() async {
    getFavDriverModel = null;
    String response = await ApiServices.getMethod(feedUrl: ApiUrls.GET_ALL_FAV_DRIVERS);

    if (response.isEmpty) return false;
    getFavDriverModel = getFavDriverModelFromJson(response);
    notifyListeners();
    return true;
  }
}

AddToFavModel rideHistoryModelFromJson(String str) => AddToFavModel.fromJson(json.decode(str));

class AddToFavModel {
  AddToFavModel({
    this.error,
    this.errorCode,
    this.message,
  });

  bool? error;
  int? errorCode;
  String? message;

  factory AddToFavModel.fromJson(Map<String, dynamic> json) => AddToFavModel(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode,
        "message": message,
      };
}
