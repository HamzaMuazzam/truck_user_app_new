import 'dart:async';
import 'package:get/get.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/CancelReasons/get_cancel_reason.dart';
import 'package:sultan_cab/models/RideCancel/ride_cancel%20_model.dart';
import 'package:sultan_cab/models/fair_by_car_id/fair_by_car_id.dart';
import 'package:sultan_cab/models/get_location_change_model/get_location_change_model.dart';
import 'package:sultan_cab/models/get_reviews/get_reviews.dart';
import 'package:sultan_cab/models/get_vehicle_type_model/get_vehicle_type.dart';
import 'package:sultan_cab/models/taxiBookingModels/bid_accept_model.dart';
import 'package:sultan_cab/models/taxiBookingModels/bidding_model.dart';
import 'package:sultan_cab/models/taxiBookingModels/book_ride_response_model.dart';
import 'package:sultan_cab/models/taxiBookingModels/driver_arrival_model.dart';
import 'package:sultan_cab/models/taxiBookingModels/ride_end_model.dart';
import 'package:sultan_cab/models/taxiBookingModels/start_ride_model.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/NotificationProvider/notification_provider.dart';
import 'package:sultan_cab/providers/Reoccurring/reoccurring.dart';
import 'package:sultan_cab/services/ApiServices/api_services.dart';
import 'package:sultan_cab/services/ApiServices/api_urls.dart';
import 'package:sultan_cab/services/sockets/sockets.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/TruckBooking/start_booking.dart';
import '../truck_provider/app_flow_provider.dart';

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


ReoccurringProvider recProv =
    Provider.of<ReoccurringProvider>(Get.context!, listen: false);
TruckBookingProvider taxiBookingProvider =
    Provider.of<TruckBookingProvider>(Get.context!, listen: false);

class TruckBookingProvider extends ChangeNotifier {
  TextEditingController offerPriceCtrl = TextEditingController();
  GetVehicleTypesModel? getVehicleTypesModel;
  BookARideResponseModel? bookARideResponseModel;
  DriverArrivalModel? driverArrivalModel;
  FairByCarId? fairByCarId;
  BiddingModel? biddingModel;
  StartRideModel? startRideModel;
  BidAcceptModel? bidAcceptModel;
  OnLocationChange? onDriverLocationChange;
  GetCancelReasonModel? getCancelReasonModel;
  RideEndModel? rideEndModel;
  List<BiddingModel> biddingList = <BiddingModel>[];
  String carID = "";
  Map<String, String> multipleRideFields = {};

  RideStage stage = RideStage.Bidding;

  void changeRideStage(RideStage currentStage) {
    stage = currentStage;
    notifyListeners();
  }

  Future<bool> getVehicleTypes() async {
    AppConst.startProgress();
    String response =
        await ApiServices.getMethodWithBody(ApiUrls.GET_VEHICLE_TYPES, null);
    AppConst.stopProgress();

    if (response.isEmpty) {
      AppConst.errorSnackBar("Unable to get vehicles types");
      return false;
    }
    getVehicleTypesModel = getVehicleTypesModelFromJson(response);

    notifyListeners();
    return true;
  }

  Future<void> getFairByID({
    required String carId,
    required String distance,
    required String estimatedTime,
  }) async {
    AppConst.startProgress();
    Map<String, String> fields = {
      "vehicleTypeId": carId,
      "distance": distance,
      "estimatedTime": estimatedTime,
    };

    String response =
        await ApiServices.getMethodWithBody(ApiUrls.GET_FAIR_BY_ID, fields);
    await AppConst.stopProgress();
    if (response.isEmpty) {
      AppConst.errorSnackBar("Unable to get fair");
      return;
    }
    fairByCarId = fairByCarIdFromJson(response);

    offerPriceCtrl.text = fairByCarId!.data!.estimatedPrice.round().toString();

    notifyListeners();
  }

  Future<bool> bookARide(AppFlowProvider appFlowProvider) async {
    Map<String, String> fields = {
      "vehicleTypeId": "${carID}",
    };

    fields["estimatedTime"] =
        (appFlowProvider.directions!.durationSeconds! / 60).round().toString();
    fields["distanceKM"] = ((appFlowProvider.directions!.distanceKM!) / 1000)
        .toString()
        .replaceAll(" km", "");
    fields["FairId"] = fairByCarId!.data!.fair.id.toString();
    fields["fairValue"] = offerPriceCtrl.text;

    if (appFlowProvider.destinationType == DestinationType.Single) {
      fields["startLat"] = appFlowProvider.currentLoc!.latitude.toString();
      fields["startLng"] = appFlowProvider.currentLoc!.longitude.toString();
      fields["endLat"] = appFlowProvider.destLoc!.latitude.toString();
      fields["endLng"] = appFlowProvider.destLoc!.longitude.toString();
      fields["startAddress"] = appFlowProvider.currentAdd ?? "";
      fields["endAddress"] = appFlowProvider.destAdd ?? "";

      if (appFlowProvider.rideType == RideType.Reoccurring) {
        fields.addAll({
          "isRecurring": "true",
          "isScheduled": "true",
          "scheduledTime": "${recProv.reoccurringSchedule?.time}",
          "isRecurringActive": "true",
          "recurringCount": "0",
        });

        for (int i = 0; i < recProv.reoccurringSchedule!.days.length; i++) {
          fields.addAll(
              {"selectedDay[${i}]": "${recProv.reoccurringSchedule!.days[i]}"});
        }
      }
    }

    if (appFlowProvider.destinationType == DestinationType.Multiple) {
      fields.addAll(taxiBookingProvider.multipleRideFields);
    }

    logger.i(fields);

    String response = await ApiServices.postMethod(
        feedUrl: ApiUrls.BOOK_A_RIDE, fields: fields);
    if (response.isEmpty) {
      await AppConst.errorSnackBar("Unable to book a Ride");
      return false;
    }
    bookARideResponseModel = bookARideResponseModelFromJson(response);

    notifyListeners();
    return true;
  }

  void receiveBiddingData(data) async {
    biddingModel = BiddingModel.fromJson(data);
    if (biddingModel != null) {
      biddingList.add(biddingModel!);
      runTimer(biddingList.length - 1);

      await playBiddingSound("assets/sounds/booking_success.mp3");
    }
    notifyListeners();
  }

  Future<bool> removeBiddingFrontEnd(int index,
      {bool isApiCall = false}) async {
    if (isApiCall) bool result = await declineBidFromServer(index);

    biddingList.removeAt(index);
    notifyListeners();

    return true;
  }

  Future<bool> acceptBid(int index) async {
    Map<String, String> fields = {
      'driverId': biddingList[index].bidCreated?.user?.id?.toString() ?? "",
      'requestId': biddingList[index].bidCreated?.requestId?.toString() ?? "",
      'bidId': biddingList[index].bidCreated?.id?.toString() ?? "",
    };

    String response = await ApiServices.postMethod(
        feedUrl: ApiUrls.ACCEPT_BID, fields: fields);

    if (response.isEmpty) {
      await AppConst.errorSnackBar("Unable to accept bid");

      return false;
    }
    logger.i(response);
    bidAcceptModel = bidAcceptModelFromJson(response);
    AppSockets.trackDriver(rideId: "${bidAcceptModel?.data?.requestData?.id}");
    changeRideStage(RideStage.DriverToRider);
    return true;
  }

  Future<bool> declineBidFromServer(int index) async {
    Map<String, String> fields = {
      'bidId': biddingList[index].bidCreated?.id?.toString() ?? "",
    };

    String response = await ApiServices.postMethod(
        feedUrl: ApiUrls.DECLINE_BID, fields: fields);
    if (response.isEmpty) {
      await AppConst.errorSnackBar("Unable to decline bid");

      return false;
    }
    await AppConst.successSnackBar("Bid declined");
    return true;
  }

  Future<bool> getCancelReasons() async {
    String response =
        await ApiServices.postMethod(feedUrl: ApiUrls.CANCEL_REASONS);
    if (response.isEmpty) {
      await AppConst.errorSnackBar("Unable to get reasons");
      return false;
    }
    logger.i(response);
    getCancelReasonModel = getCancelReasonModelFromJson(response);
    notifyListeners();
    return true;
  }

  Future<bool> cancelRide(int cancelReasonId) async {
    logger.i(bookARideResponseModel!.data!.request!.id.toString());
    Map<String, String> fields = {
      "requestId": "${bookARideResponseModel!.data!.request!.id.toString()}",
      "cancelReasonId": "${cancelReasonId}",
    };

    String response = await ApiServices.postMethod(
        feedUrl: ApiUrls.CANCEL_RIDE, fields: fields);
    if (response.isEmpty) {
      await AppConst.errorSnackBar("Unable to cancel ride");

      return false;
    }
    await AppConst.infoSnackBar("Ride Canceled");

    return true;
  }

  RideCancelModel? rIdeCancelModel;

  void onRideCancel(data) {
    rIdeCancelModel = RideCancelModel.fromJson(data);
    AppConst.successSnackBar("${"Ride Canceled by Driver"}");
    appFlowProvider.changeBookingStage(BookingStage.Destination);
    Get.offAll(StartBooking());

    notifyListeners();
  }

  Future<void> playBiddingSound(String assetPath) async {
    await AssetsAudioPlayer.newPlayer().open(Audio(assetPath));
  }

  void getStartRideData(data) async {
    startRideModel = StartRideModel.fromJson(data);
    if (startRideModel != null) {
      AppConst.successSnackBar(
          startRideModel?.request?.status?.replaceAll("_", " ") ??
              "Ride Started");
      appFlowProvider.changeBookingStage(BookingStage.RideStarted);
      notifyListeners();
    }
  }

  late Timer timer;

  void runTimer(int index) {
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {

        if (biddingList.isEmpty) {
          appFlowProvider.changeBookingStage(BookingStage.PickUp);
          timer.cancel();
          return;
        }

        if (biddingList.isNotEmpty && biddingList[index].time > 0) {
          biddingList[index].time = biddingList[index].time - 1;
        } else {
          timer.cancel();
          removeBiddingFrontEnd(index);
        }
        notifyListeners();
      },
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void showDriverOnMap(data) {
    onDriverLocationChange = OnLocationChange.fromJson(data);
    locProv.setDriverMarker();
    if (locProv.currentPosition != null && !isRiderNotify)
      // notifyNearToArrival();
    notifyListeners();
  }

  void onDriverArrival(data) async {
    driverArrivalModel = DriverArrivalModel.fromJson(data);
    if (driverArrivalModel != null) {}
    changeRideStage(RideStage.Arrived);

    // await notifyProv.showNotification(
    //     title: "Truck King", body: "Driver Arrived at your pickup location");
    notifyListeners();
  }

  void onRideEnd(data) async {
    rideEndModel = RideEndModel.fromJson(data);
    bool result = await taxiBookingProvider.getReviews();
    if (result) changeRideStage(RideStage.FinishRide);
    notifyListeners();
  }

  bool isRiderNotify = false;

  // void notifyNearToArrival() async {
  //   await notifyProv.InitializationNotifications();
  //   double distance = locProv.calculateRadius(
  //       lat: double.parse(onDriverLocationChange!.lat),
  //       lon: double.parse(onDriverLocationChange!.lng));
  //   if (distance < 100) {
  //     notifyProv.showNotification(
  //         title: "Truck King", body: " Driver is near to your pickup location");
  //   }
  //
  //   isRiderNotify = true;
  // }

  GetReviewsModel? getReviewsModel;
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

  Future<bool> getReviews() async {
    reviewsList = [];
    String response = await ApiServices.getMethod(feedUrl: ApiUrls.GET_REVIEWS);

    if (response.isEmpty) return false;

    getReviewsModel = getReviewsModelFromJson(response);

    getReviewsModel!.data!.forEach((element) {
      reviewsList.add(element.review ?? "");
    });
    notifyListeners();
    return true;
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
    AppConst.successSnackBar("Review Added");
    return true;
  }
}
