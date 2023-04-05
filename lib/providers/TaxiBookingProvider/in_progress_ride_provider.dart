import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/taxiBookingModels/bid_accept_model.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/taxi_booking_provider.dart';
import 'package:sultan_cab/providers/taxi/app_flow_provider.dart';
import 'package:sultan_cab/screens/google_map_view/google_map_view.dart';
import 'package:sultan_cab/services/apiServices/api_services.dart';
import 'package:sultan_cab/utils/commons.dart';
import '/services/apiServices/api_urls.dart';

enum RideProgressStatus {
  NO_RIDE,
  PENDING,
  ACCEPTED,
  ARRIVED_AT_PICKUP_LOCATION,
  COMPLETED,
  CANCELLED,
  RIDE_STARTED
}

InProgressRideProvider inProgressRideProvider =
    Provider.of<InProgressRideProvider>(Get.context!, listen: false);

class InProgressRideProvider extends ChangeNotifier {
  RideProgressStatus rideProgressStatus = RideProgressStatus.NO_RIDE;

  // Future<bool> getRideInProgress() async {
  //   String response = await ApiServices.postMethod(
  //       feedUrl: ApiUrls.GET_RIDE_IN_PROGRESS, showProgress: false);
  //
  //   if (response.isEmpty) return false;
  //
  //   taxiBookingProvider.bidAcceptModel = bidAcceptModelFromJson(response);
  //
  //   manageState(
  //       taxiBookingProvider.bidAcceptModel?.data?.bidData?.status ?? "");
  //   notifyListeners();
  //   return true;
  // }

  void changeProgressStage(RideProgressStatus rideProgressStatus) {
    this.rideProgressStatus = rideProgressStatus;
    notifyListeners();
  }

  void manageState(String status) {
    logger.i(status);
    if (taxiBookingProvider.bidAcceptModel?.data?.bidData == null) {

      changeProgressStage(RideProgressStatus.NO_RIDE);
    } else if (status.toLowerCase().contains("pending")) {
      changeProgressStage(RideProgressStatus.PENDING);
      appFlowProvider.changeBookingStage(BookingStage.PickUp);

      notifyListeners();
      return;
    } else if (status.toLowerCase().contains("accepted")) {
      changeProgressStage(RideProgressStatus.ACCEPTED);
      appFlowProvider.changeBookingStage(BookingStage.Booked);
      taxiBookingProvider.changeRideStage(RideStage.DriverToRider);
      Get.to(() => GoogleMapView());

      notifyListeners();
      return;
    } else if (status.toLowerCase().contains("arrived_at_pickup")) {
      changeProgressStage(RideProgressStatus.ARRIVED_AT_PICKUP_LOCATION);
      taxiBookingProvider.changeRideStage(RideStage.Arrived);
      notifyListeners();
      return;
    } else if (status.toLowerCase().contains("completed")) {
      changeProgressStage(RideProgressStatus.COMPLETED);
      taxiBookingProvider.changeRideStage(RideStage.FinishRide);

      notifyListeners();
      return;
    } else if (status.toLowerCase().contains("cancelled")) {
      changeProgressStage(RideProgressStatus.CANCELLED);
      notifyListeners();
      return;
    } else if (status.toLowerCase().contains("ride_started")) {
      changeProgressStage(RideProgressStatus.RIDE_STARTED);
      appFlowProvider.changeBookingStage(BookingStage.RideStarted);

      notifyListeners();
      return;
    }

    logger.i(this.rideProgressStatus);
  }
}
