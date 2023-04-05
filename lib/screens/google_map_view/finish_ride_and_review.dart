import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/mode_selector.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/taxi_booking_provider.dart';
import 'package:sultan_cab/providers/taxi/app_flow_provider.dart';
import 'package:sultan_cab/screens/TaxiBooking/dialogBoxRating.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/widgets/single_selection_chip.dart';

class FinishRideAndReviews extends StatefulWidget {
  const FinishRideAndReviews({Key? key}) : super(key: key);

  @override
  State<FinishRideAndReviews> createState() => _FinishRideAndReviewsState();
}

class _FinishRideAndReviewsState extends State<FinishRideAndReviews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Ride Finish...",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 20),
              Text(
                "Please Add Reviews and Rating",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              SingleSelectionChip(
                chipsDataList: taxiBookingProvider.reviewsList,
                valueChanged: (value) {
                  int? revID;
                  revID = taxiBookingProvider.getReviewsModel!.data!
                      .firstWhere((element) => element.review == value)
                      .id;

                  taxiBookingProvider.setReview(value, revID!);
                },
              ),
              SizedBox(height: 20),
              DialogBoxRating(
                submitRating: () async {
                  if (taxiBookingProvider.review.isEmpty &&
                      taxiBookingProvider.rating.toString().isEmpty) {
                    AppConst.errorSnackBar("Please Add Review and Railing");

                    return;
                  }

                  bool result = await taxiBookingProvider.addRatingAndReviews(
                    driverID: "${taxiBookingProvider.startRideModel?.driver?.id}",
                    requestId: "${taxiBookingProvider.startRideModel?.request?.id}",
                  );
                  if (result) {
                    appFlowProvider.changeBookingStage(BookingStage.PickUp);
                    taxiBookingProvider.changeRideStage(RideStage.Normal);
                    appFlowProvider.changeBookingStage(BookingStage.PickUp);
                    appFlowProvider.changeRideType(RideType.Regular);
                    appFlowProvider.changeDestinationType(DestinationType.SelectRideType);

                    Get.offAll(() => ModeSelectorScreen());
                  }
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
