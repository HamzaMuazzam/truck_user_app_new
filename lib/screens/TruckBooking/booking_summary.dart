import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/fair_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/app_button.dart';

import '../../providers/GoogleMapProvider/location_and_map_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import 'searching_widget.dart';

class BookingSummary extends StatefulWidget {
  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  FairTruckProvider fairTruckProvider =
      Provider.of(Get.context!, listen: false);

  @override
  void initState() {
    super.initState();
  }

  late double h, b;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    h = SizeConfig.screenHeight / 812;
    b = SizeConfig.screenWidth / 375;
    final appProvider = Provider.of<AppFlowProvider>(context);
    var travelTime = fairTruckProvider
        .convertTimeString(appProvider.directions!.totalDuration!);
    print(travelTime);

    return Scaffold(
      backgroundColor: greybackColor,
      appBar: AppBar(
        backgroundColor: textYellowColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Booking Summary".tr,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: scaffoldColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 15,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 20, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/blue_cirle.svg',
                                  width: h * 17,
                                ),
                                sw(19),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// 1st Location
                                      Text(
                                        appProvider.currentAddress ??
                                            "Pick up address".tr,
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Transform.translate(
                              offset: Offset(-h * 3, 0),
                              child: Icon(
                                Icons.more_vert,
                                color: Color(0xff999999),
                              ),
                            ),
                            sh(5),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/unloading.png',
                                  height: h * 20,
                                ),
                                sw(19),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Other Location
                                      Text(
                                        appProvider.destAdd ??
                                            "Your Destination".tr,
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textGreyColor),
                                      ),
                                    ],
                                  ),
                                ),
                                // ),
                              ],
                            ),
                            sh(10),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 0,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 0, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/truckSummary.png',
                                  width: b * 35,
                                  height: h * 35,
                                  color: textYellowColor,
                                ),
                                sw(7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Selected Truck
                                      Text(
                                        'Selected Truck'.tr,
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                      sh(10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                sw(42),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sh(10),
                                      Text(
                                        getSelectedTrucks(),
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textGreyColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(10),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 0,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 0, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/truckSummary.png',
                                  width: b * 35,
                                  height: h * 35,
                                  color: textYellowColor,
                                ),
                                sw(7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Selected Truck
                                      Text(
                                        'Load City'.tr,
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                      sh(10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                sw(42),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Selected Truck

                                      sh(10),
                                      Text(
                                        fairTruckProvider.loadCity,
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(10),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 0,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 0, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/truckSummary.png',
                                  width: b * 35,
                                  height: h * 35,
                                  color: textYellowColor,
                                ),
                                sw(7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'UnLoad City'.tr,
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                      sh(10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                sw(42),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Selected Truck

                                      sh(10),
                                      Text(
                                        fairTruckProvider.unloadCity,
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(10),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                            sh(10),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 0,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 0, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.social_distance,
                                  size: 35,
                                  color: yellowColor,
                                ),
                                sw(7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Distance".tr,
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                      sh(10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                sw(42),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sh(10),
                                      Text(
                                        appFlowProvider
                                            .directions!.totalDistance
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(10),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                            sh(10),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 0,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 0, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 35,
                                  color: yellowColor,
                                ),
                                sw(7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Estimated Time:".tr,
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                      sh(10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                sw(42),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sh(10),
                                      Text(
                                        travelTime,
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(10),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                            sh(10),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 0,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 0, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.price_check,
                                  size: 35,
                                  color: yellowColor,
                                ),
                                sw(7),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Fairs".tr,
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                      sh(10),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                sw(42),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sh(10),
                                      Text(
                                        getTotalFairs(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(10),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                            sh(10),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 0,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 0, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 120,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: phoneBoxBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: fairTruckProvider.deliveryNote,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText:
                                        'My description details here..'.tr,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            sh(10),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AppButton(
              label: "Submit".tr,
              onPressed: () async {
                Get.to(() => SearchingWidget());
              },
            ),
          ),
          sh(20)
        ],
      ),
    );
  }
}

String getSelectedTrucks() {
  List<String> list = [];
  fairTruckProvider.getTruckFareResponse!.forEach((element) {
    String trucks = '';
    String quantity = '';
    if (element.quantity > 0) {
      if (element.truckType != '') {
        trucks = ' ( ' + element.truckType! + ' )';
      }
      if (element.quantity > 1) {
        quantity = ' * ' + element.quantity.toString();
      }
      list.add(element.truckName! + trucks + quantity);
    }
  });
  return list.isEmpty ? "" : list.join("\n");
}

String getTotalFairs() {
  double total = 0.0;
  fairTruckProvider.getTruckFareResponse!.forEach((element) {
    double totalValue = 0.0;

    if (element.quantity > 0) {
      String distance;
      double distanceDouble = 0.0;
      if (appFlowProvider.directions == null) {
        distance = "50.0";
        distanceDouble = double.parse(distance);
      } else {
        distance = appFlowProvider.directions!.totalDistance!.split(" ")[0];
      }
      if (distance.contains(",")) {
        distance = distance.replaceAll(",", "");
      }
      distanceDouble = double.parse(distance);

      if (distanceDouble <= 100 && distanceDouble < 400) {
        totalValue = totalValue + double.parse(element.upto100Km!);
      } else if (distanceDouble > 100 && distanceDouble <= 400) {
        totalValue = totalValue + double.parse(element.upto400Km!);
      } else if (distanceDouble > 400) {
        totalValue = totalValue +
            distanceDouble * double.parse(element.moreThan400KmFares!);
      }
      totalValue = totalValue * element.quantity;
      var commission = double.parse(element.commission!) * element.quantity;
      total = total + totalValue + commission;
    }
  });

  return (total).toStringAsFixed(0) + " SAR";
}

String getTotalFairsWithoutCommission() {
  double total = 0.0;
  fairTruckProvider.getTruckFareResponse!.forEach((element) {
    double totalValue = 0.0;

    if (element.quantity > 0) {
      String distance;
      double distanceDouble = 0.0;
      if (appFlowProvider.directions == null) {
        distance = "50.0";
        distanceDouble = double.parse(distance);
      } else {
        distance = appFlowProvider.directions!.totalDistance!.split(" ")[0];
      }
      if (distance.contains(",")) {
        distance = distance.replaceAll(",", "");
      }
      distanceDouble = double.parse(distance);

      if (distanceDouble <= 100 && distanceDouble < 400) {
        totalValue = totalValue + double.parse(element.upto100Km!);
      } else if (distanceDouble > 100 && distanceDouble <= 400) {
        totalValue = totalValue + double.parse(element.upto400Km!);
      } else if (distanceDouble > 400) {
        totalValue = totalValue +
            distanceDouble * double.parse(element.moreThan400KmFares!);
      }
      totalValue = totalValue * element.quantity;
      // var commission = double.parse(element.commission!) * element.quantity;
      total = total + totalValue /*+ commission*/;
    }
  });

  return (total).toStringAsFixed(0);
}
