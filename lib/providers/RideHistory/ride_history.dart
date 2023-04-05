import 'package:flutter/cupertino.dart';
import 'package:sultan_cab/models/RideHistory/last_ride_model.dart';
import 'package:sultan_cab/models/RideHistory/ride_history_model.dart';

import '/services/apiServices/api_services.dart';
import '/services/apiServices/api_urls.dart';

enum CallStatus {
  Loading,
  ErrorOccurred,
  NoDataFound,
  DataFound,
}

class RideHistoryProvider extends ChangeNotifier {
  RideHistoryModel? rideHistoryModel;
  GetLastRideModel? getLastRideModel;

  CallStatus dataStatus = CallStatus.NoDataFound;

  void changeDataStatus(CallStatus dataStatus) {
    this.dataStatus = dataStatus;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }

  Future<bool> getRideHistory({required int limit, required int offset}) async {
    changeDataStatus(CallStatus.Loading);
    String response = await ApiServices.getMethodWithBody(
        ApiUrls.GET_RIDE_HISTORY, {"limit": "50", "offset": "1"});
    if (response.isEmpty) {
      changeDataStatus(CallStatus.ErrorOccurred);
      return false;
    }
    rideHistoryModel = rideHistoryModelFromJson(response);
    if (rideHistoryModel!.data!.isEmpty)
      changeDataStatus(CallStatus.NoDataFound);
    else {
      changeDataStatus(CallStatus.DataFound);
    }
    notifyListeners();
    return true;
  }

  void getLastRideHistory({required int nextUserId}) async {
    Map<String, String> fields = {"nextUserId": "$nextUserId"};
    String response = await ApiServices.getMethodWithBody(ApiUrls.GET_RIDE_HISTORY, fields);
    if (response.isEmpty) return;
    getLastRideModel = getLastRideModelFromJson(response);
  }
}
