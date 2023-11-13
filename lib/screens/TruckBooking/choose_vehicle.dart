import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/fair_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';

import 'booking_summary.dart';

enum SingingCharacter { lafayette, jefferson }

class ChooseCar extends StatefulWidget {
  const ChooseCar({Key? key}) : super(key: key);

  @override
  _ChooseCarState createState() => _ChooseCarState();
}

class _ChooseCarState extends State<ChooseCar> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;
    return Consumer<FairTruckProvider>(builder: (builder, data, child) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              label: 'Select Trailer Type'.tr,
            ),
            Container(
              height: h * 380,
              color: greybackColor,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fairTruckProvider.getTruckFareResponse!.length,
                  itemBuilder: (context, index) {
                    var truck = fairTruckProvider.getTruckFareResponse![index];
                    print(data);
                    return SingleChildScrollView(
                      child: Container(
                        // height: h * 100,
                        decoration: BoxDecoration(
                          color: greybackColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, top: 20),
                                  child: Container(
                                    height: h * 54,
                                    width: h * 64,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/flatBedTrailer.png'),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                ),
                                                child: Text(
                                                  fairTruckProvider
                                                      .getTruckFareResponse![
                                                          index]
                                                      .truckName!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: textYellowColor),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15.0,
                                              ),
                                              child: Text(
                                                truck.moreThan400KmFares!
                                                        .toString() +
                                                    " per KM".tr,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: greyColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          sw(10),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15.0, top: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  fairTruckProvider
                                                      .getTruckFareResponse![
                                                          index]
                                                      .truckType!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: textColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(30),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  sw(70),
                                  InkWell(
                                    onTap: () {
                                      if (fairTruckProvider
                                              .getTruckFareResponse![index]
                                              .quantity >
                                          0) {
                                        fairTruckProvider
                                            .getTruckFareResponse![index]
                                            .quantity--;
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          border: Border.all(
                                              color: secondaryColor)),
                                      child: Icon(
                                        Icons.remove_rounded,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      truck.quantity.toString(),
                                      style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              color: textColor,
                                              offset: Offset(0, -5))
                                        ],
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.grey,
                                        decorationThickness: 4,
                                        fontSize: 15,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      fairTruckProvider
                                          .getTruckFareResponse![index]
                                          .quantity++;
                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                          border: Border.all(
                                              color: secondaryColor)),
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  sw(70),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 90.0, right: 20),
                              child: Container(
                                color: Colors.grey,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            AppButton(
              label: BookingContinue.toUpperCase(),
              onPressed: () async {
                bool where = fairTruckProvider.getTruckFareResponse!
                    .where((element) => element.quantity > 0)
                    .isNotEmpty;
                if (where) {
                  // await fairTruckProvider.getAllCities();
                  // appFlowProvider.changeBookingStage(BookingStage.City);

                  Get.to(BookingSummary());
                } else {
                  AppConst.errorSnackBar("Please select one trailer at least");
                  return;
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
