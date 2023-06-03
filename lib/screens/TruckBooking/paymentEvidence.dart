import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/fair_provider.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import '../../providers/auth_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../utils/colors.dart';

class PaymentEvidence extends StatefulWidget {
  const PaymentEvidence({Key? key}) : super(key: key);

  @override
  State<PaymentEvidence> createState() => _PaymentEvidenceState();
}

class _PaymentEvidenceState extends State<PaymentEvidence> {
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

    return Scaffold(
      backgroundColor: greybackColor,
      appBar: AppBar(
        backgroundColor: textYellowColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Booking Summary",
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
                                sw(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      sh(10),
                                      // Text(
                                      //   'Estimated Cost: SAR ${fairTruckProvider.tot.toString()}',
                                      //   style: TextStyle(
                                      //       fontSize: h * 12,
                                      //       color: textGreyColor),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(20),
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
                                  'assets/images/payment.png',
                                  width: b * 35,
                                  height: h * 35,
                                  color: textYellowColor,
                                ),
                                sw(7),
                                Expanded(
                                  child:  InkWell(
                                    onTap: () {
                                      authProvider.getDpImage();
                                      // AppWidgets.dpImageFile(  xFile: authProvider!.xFile,
                                      //   onTap: () async {
                                      //     authProvider!.getDpImage();
                                      //   },);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// Selected Truck
                                        Text(
                                          'Payment proof*',
                                          style: TextStyle(
                                              fontSize: h * 12,
                                              color: textYellowColor),
                                        ),
                                        sh(10),
                                      ],
                                    ),
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
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AppButton(
              label: "Submit",
              onPressed: () async {
                // bool result = await paymentProvider.uploadPaymentEvidence();

                // if (result) {
                //   await appFlowProvider.removeDestinationLoc();
                //   locProv.polyLines = {};
                //   await appProvider.removeDirections();
                //   await appProvider.removePickUpLoc();
                //   locProv.locMarkers = {};
                //   locProv.polylineCoordinates = [];
                //   fairTruckProvider.loadCity = '';
                //   fairTruckProvider.unloadCity = '';
                //   Get.to(SearchingWidget());
                //
                //   await Provider.of<AppFlowProvider>(context, listen: false)
                //       .changeBookingStage(BookingStage.SearchingVehicle);
                // } else
                //   logger.i('Maryam');
              },
            ),
          ),
          sh(20)
        ],
      ),
    );
  }
}
