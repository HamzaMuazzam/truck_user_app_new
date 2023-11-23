import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/get_location_change_model/get_location_change_model.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';

import '../../services/apiServices/api_services.dart';
import '../../services/apiServices/api_urls.dart';
// import 'package:url_launcher/url_launcher.dart';

enum RideStage {
  Normal,
  Bidding,
  BidAccept,
  DriverToRider,
  Arrived,
  Started,
  RideStarted,
  FinishRide,
}

TruckBookingProvider truckBookingProvider =
    Provider.of<TruckBookingProvider>(Get.context!, listen: false);

class TruckBookingProvider extends ChangeNotifier {
  TextEditingController offerPriceCtrl = TextEditingController();

  OnLocationChange? onDriverLocationChange;
  String carID = "";
  Map<String, String> multipleRideFields = {};

  RideStage stage = RideStage.Bidding;

  late Timer timer;

  // Future<void> makePhoneCall(String phoneNumber) async {
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launchUrl(launchUri);
  // }

  void showDriverOnMap(data) {
    onDriverLocationChange = OnLocationChange.fromJson(data);
    locProv.setDriverMarker();
    if (locProv.currentPosition != null && !isRiderNotify)
      // notifyNearToArrival();
      notifyListeners();
  }

  bool isRiderNotify = false;
  List<String> reviewsList = [];
  String review = "";
  double rating = 0.0;
  int? reviewId;

  void setReview(String review, int reviewId) {
    this.review = review;
    this.reviewId = reviewId;
    logger.i(this.review + this.reviewId.toString());
    notifyListeners();
  }

  void setRating(double rating) {
    this.rating = rating;
    logger.i(this.rating);
    notifyListeners();
  }

  Future<bool> addRatingAndReviews({
    required String driverID,
    required String requestId,
  }) async {
    Map<String, String> fields = {
      'rating': this.rating.toString(),
      'feedBack': this.review,
      'nextUserId': driverID,
      'requestId': requestId,
      'reviewId': this.reviewId.toString()
    };

    String response = await ApiServices.postMethod(
        feedUrl: ApiUrls.ADD_REVIEWS, fields: fields);
    if (response.isEmpty) return false;

    logger.i(response);
    AppConst.successSnackBar("Review Added".tr);
    return true;
  }
}
