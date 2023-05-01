import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/taxiBookingModels/bidding_model.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/screens/google_map_view/google_map_view.dart';
import 'package:sultan_cab/services/apiServices/api_urls.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';

import '../../providers/truck_provider/app_flow_provider.dart';

class ReceivedBiddingView extends StatefulWidget {
  const ReceivedBiddingView({Key? key}) : super(key: key);

  @override
  _ReceivedBiddingViewState createState() => _ReceivedBiddingViewState();
}

class _ReceivedBiddingViewState extends State<ReceivedBiddingView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: Get.height,
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: SingleChildScrollView(
        child: BiddingCard(),
      ),
    );
  }
}

class BiddingCard extends StatefulWidget {
  const BiddingCard({Key? key}) : super(key: key);

  @override
  State<BiddingCard> createState() => _BiddingCardState();
}

class _BiddingCardState extends State<BiddingCard>
    with TickerProviderStateMixin {
  late TruckBookingProvider taxiBookingProvider;
  late AppFlowProvider appProvider;

  @override
  void initState() {
    taxiBookingProvider =
        Provider.of<TruckBookingProvider>(context, listen: false);
    appProvider = Provider.of<AppFlowProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 5),
        child: Consumer<TruckBookingProvider>(
            builder: (BuildContext context, value, Widget? child) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: taxiBookingProvider.biddingList.length,
              itemBuilder: (BuildContext context, int index) {
                BiddingModel data = taxiBookingProvider.biddingList[index];

                if (data.userRating != null) {
                  data.userRating!.avgRating.toString();
                } else {}

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1.5, color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CachedNetworkImage(
                              //   width: Get.width * .12,
                              //   height: Get.width * .12,
                              //   fit: BoxFit.cover,
                              //   imageUrl:
                              //       "${ApiUrls.BASE_URL}${data.bidCreated?.user?.profileImage}",
                              //   imageBuilder:
                              //       (BuildContext ctx, imageProvider) {
                              //     return Container(
                              //       decoration: BoxDecoration(
                              //         shape: BoxShape.circle,
                              //         image: DecorationImage(
                              //             image: imageProvider,
                              //             fit: BoxFit.cover),
                              //       ),
                              //     );
                              //   },
                              //   placeholder: (context, url) =>
                              //       CircularProgressIndicator(),
                              //   errorWidget: (context, url, error) =>
                              //       Image.asset(
                              //           "assets/images/place_holder.jpg"),
                              // ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //   Text(
                                  // "Car type",
                                  //     style: TextStyle(fontWeight: FontWeight.w500),
                                  //   ),
                                  Text(
                                    data.bidCreated?.user?.name??"",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                      Text("0"),
                                    ],
                                  ),
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "PKR ${data.bidCreated?.bidAmount?.round().toString()}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: greenColor)),
                                  Text("7 min"),
                                  Text("1.5 KM"),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),

                          ///TODO:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              /// decline
                              GestureDetector(
                                onTap: () async {
                                  bool result =
                                      await value.removeBiddingFrontEnd(index,isApiCall: true);
                                  if (result) if (value.biddingList.isEmpty) {
                                    appProvider.changeBookingStage(
                                        BookingStage.Vehicle);
                                  }
                                },
                                child: Container(
                                  constraints:
                                      BoxConstraints(minWidth: Get.width * .3),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Center(
                                        child: Text("Decline",
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ),
                                ),
                              ),

                              /// accept
                              GestureDetector(
                                onTap: () async {
                                  bool result = await value.acceptBid(index);

                                  if (result)
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return GoogleMapView();
                                        },
                                      ),
                                    );
                                },
                                child: Container(
                                  constraints:
                                      BoxConstraints(minWidth: Get.width * .3),
                                  decoration: BoxDecoration(
                                      color: greenColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Center(
                                      child: Text(
                                        "Accept",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text("${taxiBookingProvider.biddingList[index].time}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }));
  }
}
