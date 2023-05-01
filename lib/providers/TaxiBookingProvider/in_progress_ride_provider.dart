import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


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

  void changeProgressStage(RideProgressStatus rideProgressStatus) {
    this.rideProgressStatus = rideProgressStatus;
    notifyListeners();
  }

}
