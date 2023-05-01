import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/screens/chat_room.dart';

import '/services/apiServices/api_urls.dart';

class DriverArrival extends StatefulWidget {
  const DriverArrival({Key? key}) : super(key: key);

  @override
  State<DriverArrival> createState() => _DriverArrivalState();
}

class _DriverArrivalState extends State<DriverArrival> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationAndMapProvider>(builder: (BuildContext context, value, Widget? child) {
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: Colors.black,
                    //   radius: 25,
                    //   backgroundImage: NetworkImage(
                    //       "${ApiUrls.BASE_URL}${taxiBookingProvider.bidAcceptModel?.data?.riderData?.profileImage}"),
                    // ),
                    SizedBox(width: 10),
                    Text(
                      taxiBookingProvider.bidAcceptModel?.data?.riderData?.name ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: SizedBox()),

                    ///TODO:
                    IconButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ChatRoom(
                                rideId: taxiBookingProvider.bidAcceptModel!.data!.requestData!.id!,
                                nextUserId:
                                    taxiBookingProvider.bidAcceptModel!.data!.driverData!.id!,
                              );
                            },
                          ),
                        );
                      },
                      icon: Icon(Icons.chat),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (taxiBookingProvider.bidAcceptModel?.data?.driverData?.loginId != null)
                            await taxiBookingProvider.makePhoneCall(
                                taxiBookingProvider.bidAcceptModel!.data!.driverData!.loginId!);
                        },
                        icon: Icon(Icons.call)),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Driver Arrived at Your Pickup Location...",
                  style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    });
  }
}
