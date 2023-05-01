import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'providers/truck_provider/app_flow_provider.dart';
import 'screens/TruckBooking/start_booking.dart';

class ModeSelectorScreen extends StatefulWidget {
  const ModeSelectorScreen({Key? key}) : super(key: key);

  @override
  State<ModeSelectorScreen> createState() => _ModeSelectorScreenState();
}

class _ModeSelectorScreenState extends State<ModeSelectorScreen> {
  late double h, b;
  // late NotificationsProvider notifyProvider;

  @override
  void initState() {
    // notifyProvider = Provider.of<NotificationsProvider>(context, listen: false);
    // notifyProvider.isAndroidPermissionGranted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    h = MediaQuery.of(context).size.height / 812;
    b = MediaQuery.of(context).size.width / 375;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: Get.width * .3,
                      width: Get.width * .3,
                      child: Image.asset(
                        'assets/logo/sultan_logo.png',
                        width: b * 215,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Truck King",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                sh(60),
                Text(
                  ChooseOptionLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: b * 24,
                  ),
                ),
                sh(16),
                Text(
                  WhatToRideLabel,
                  style: TextStyle(
                    fontSize: b * 12,
                  ),
                ),
                sh(31),

                /// Single destination

                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () async {
                    appFlowProvider.changeBookingStage(BookingStage.PickUp);
                    appFlowProvider.changeDestinationType(DestinationType.Single);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return StartBooking();
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff9f9f9),
                      borderRadius: BorderRadius.circular(b * 4),
                    ),
                    height: h * 122,
                    width: b * 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/self_drive.png',
                          width: b * 61,
                          height: h * 61,
                        ),
                        sh(12),
                        Text(
                          "Single Destination",
                          style: TextStyle(
                            fontSize: b * 12,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                sh(20),

                /// Multiple Destination
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () async {
                    TruckBookingProvider taxiProvider = Provider.of(context, listen: false);
                    bool result = await taxiProvider.getVehicleTypes();
                    if (!result) return;

                    appFlowProvider.changeMapStatus(true);
                    appFlowProvider.changeDestinationType(DestinationType.Multiple);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return StartBooking();
                        },
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff9f9f9),
                      borderRadius: BorderRadius.circular(b * 4),
                    ),
                    height: h * 122,
                    width: b * 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/icons/taxi.png', width: b * 61, height: h * 61),
                        sh(12),
                        Text(
                          "Multiple Destinations",
                          style: TextStyle(fontSize: b * 12, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
