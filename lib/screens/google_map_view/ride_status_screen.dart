import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/screens/chat_room.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../services/ApiServices/api_urls.dart';
import '../TruckBooking/navigation_screen.dart';

class RideStatusScreen extends StatefulWidget {
  const RideStatusScreen({Key? key}) : super(key: key);

  @override
  State<RideStatusScreen> createState() => _RideStatusScreenState();
}

class _RideStatusScreenState extends State<RideStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocationAndMapProvider>(
      builder: (BuildContext context, value, Widget? child) {
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
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 25,
                        // backgroundImage: NetworkImage(
                        //     "${ApiUrls.BASE_URL}${taxiBookingProvider.bidAcceptModel?.data?.riderData?.profileImage}"),
                      ),
                      SizedBox(width: 10),
                      Text(
                        taxiBookingProvider.bidAcceptModel?.data?.riderData?.name ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Expanded(child: SizedBox()),

                      ///TODO:
                      IconButton(
                        onPressed: () async {
                          logger.i(taxiBookingProvider.bidAcceptModel!.data!.requestData!.userId!);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ChatRoom(
                                  rideId:
                                      taxiBookingProvider.bidAcceptModel!.data!.requestData!.id!,
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
                            if (taxiBookingProvider.bidAcceptModel?.data?.driverData?.loginId !=
                                null)
                              await taxiBookingProvider.makePhoneCall(
                                  taxiBookingProvider.bidAcceptModel!.data!.driverData!.loginId!);
                          },
                          icon: Icon(Icons.call)),
                      SizedBox(width: 10),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Ride Booked...",
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  if (appFlowProvider.destinationType == DestinationType.Single)
                    Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.red,
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: Get.width * .75,
                              child: Text(taxiBookingProvider
                                      .bidAcceptModel?.data?.requestData?.startAddress ??
                                  ""),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Container(height: 2, color: Colors.grey),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.green,
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: Get.width * .75,
                              child: Text(taxiBookingProvider
                                      .bidAcceptModel?.data?.requestData?.endAddress ??
                                  ""),
                            )
                          ],
                        ),
                      ],
                    ),
                  if (appFlowProvider.destinationType == DestinationType.Multiple)
                    destinationWidget(),
                  SizedBox(height: 20),
                  AppButton(
                    label: "Cancel",
                    onPressed: () async {
                      TruckBookingProvider taxiBookingProvider =
                          Provider.of<TruckBookingProvider>(context, listen: false);

                      bool result = await taxiBookingProvider.getCancelReasons();
                      if (result) {
                        int? id = await getCancelReason(taxiBookingProvider);
                        if (id != null) {
                          bool status = await taxiBookingProvider.cancelRide(id);
                          if (status) {
                            Get.offAll(() => NavigationScreen());
                            appFlowProvider.changeBookingStage(BookingStage.PickUp);
                          }
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<int?> getCancelReason(TruckBookingProvider taxiBookingProvider) async {
    return Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                "Why do you want cancel ?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Container(height: 1, color: Colors.grey.withOpacity(.5)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: List.generate(
                  taxiBookingProvider.getCancelReasonModel?.data?.length ?? 0,
                  (index) {
                    final data = taxiBookingProvider.getCancelReasonModel?.data?[index];

                    return Card(
                      elevation: 5,
                      child: ListTile(
                        dense: true,
                        title: Text(data?.reasonText ?? ""),
                        onTap: () {
                          Get.back(result: data?.id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        isScrollControlled: true);
  }

  Widget destinationWidget() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: appFlowProvider.multiDestinationList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          dense: true,
          leading: Icon(
            Icons.location_on_outlined,
            color: index == 0 ? Colors.red : Colors.green,
          ),
          title: Text(
            appFlowProvider.multiDestinationList[index].locationResult?.formattedAddress ?? "",
            style: TextStyle(fontSize: 12),
          ),
        );
      },
    );
  }
}
