import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/providers/AddToFav/add_to_fav_controller.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:url_launcher/url_launcher.dart';

class RideStarted extends StatefulWidget {
  RideStarted({Key? key}) : super(key: key);

  @override
  State<RideStarted> createState() => _RideStartedState();
}

class _RideStartedState extends State<RideStarted> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "Have a good ride with Sultan",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 1,
                        color: Colors.grey.withOpacity(.2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * .6,
                              child: Text(
                                "Are you feeling better with this Driver? Add Driver to Favourite",
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ),
                            button(
                              Icon(
                                Icons.favorite,
                                color: isFav ? Colors.green : Colors.grey,
                              ),
                              () async {
                                appFlowProvider;
                                int driverId = taxiBookingProvider.startRideModel!.driver!.id!;
                                logger.i(driverId);
                                bool result = await addToFavProv.addToFavourite(driverId);
                                if (result) {
                                  setState(() {
                                    isFav = true;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Get.width * .6,
                              child: Text(
                                "Something Wrong.? Call to Police",
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ),
                            button(
                              Icon(Icons.call),
                              () async {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: "15",
                                );
                                await launchUrl(launchUri);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ));
  }

  Widget button(
    Widget icon,
    onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 1,
                color: Colors.grey.withOpacity(.1),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: icon,
          ),
        ),
      ),
    );
  }
}
