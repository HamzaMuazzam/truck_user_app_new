import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/mode_selector.dart';
import 'package:sultan_cab/providers/taxi/app_flow_provider.dart';
import 'Favorite/favorite_ride_screen.dart';
import 'Reoccurring/reoccurring_ride.dart';

class ChooseRideType extends StatefulWidget {
  const ChooseRideType({Key? key}) : super(key: key);

  @override
  State<ChooseRideType> createState() => _ChooseRideTypeState();
}

class _ChooseRideTypeState extends State<ChooseRideType> {
  @override
  Widget build(BuildContext context) {
    AppFlowProvider appProvider = Provider.of<AppFlowProvider>(context, listen: false);

    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          typeList.length,
          (index) => GestureDetector(
            onTap: () async {
              appProvider.rideValue = index;
              setState(() {});
              if (appProvider.rideValue == 0) {
                appProvider.changeRideType(RideType.Regular);
                Get.to(() => ModeSelectorScreen());
              }
              if (appProvider.rideValue == 1) {
                appProvider.changeRideType(RideType.Reoccurring);

                Get.to(() => ReoccurringRide());
              }
              if (appProvider.rideValue == 2) {
                appProvider.changeRideType(RideType.Favorite);
                Get.to(() => FavoriteRideScreen());
              }
            },
            child: containerOptions(index, appProvider),
          ),
        ),
      ),
    );
  }

  Widget containerOptions(int index, AppFlowProvider appProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: appProvider.rideValue == index ? 2 : 1,
                  color: appProvider.rideValue == index ? Colors.green : Colors.black,
                )),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  typeList[index],
                  style: TextStyle(
                      color: appProvider.rideValue == index ? Colors.green : Colors.black),
                ),
              ),
            ),
          ),
          if (appProvider.rideValue == index)
            Positioned(
                top: 0,
                right: 0,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 20,
                ))
        ],
      ),
    );
  }

  List<String> typeList = <String>[
    "Regular",
    "Reoccurring",
    "Favorite",
  ];
}
