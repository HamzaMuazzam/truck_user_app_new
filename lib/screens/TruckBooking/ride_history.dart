import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/RideHistory/ride_history.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgetsTaxi/myTripCard.dart';
import '/models/RideHistory/ride_history_model.dart';
import '/services/apiServices/StorageServices/get_storage.dart';



class RideHistory extends StatefulWidget {
  const RideHistory({Key? key}) : super(key: key);

  @override
  _RideHistoryState createState() => _RideHistoryState();
}

class _RideHistoryState extends State<RideHistory> {
  late RideHistoryProvider rideHistoryCtrl;

  @override
  void initState() {
    rideHistoryCtrl = Provider.of<RideHistoryProvider>(context, listen: false);

    rideHistoryCtrl.getRideHistory(limit: 50, offset: 1);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.i(StorageCRUD.getUser().userTokens);
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          leading: SizedBox(),
          title: Text(
            "Ride History",
            style: TextStyle(fontSize: 16),
          )),
      body: SafeArea(
        child: Consumer<RideHistoryProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.dataStatus == CallStatus.Loading)
              return Center(child: CircularProgressIndicator(color: Colors.black));
            else if (value.dataStatus == CallStatus.NoDataFound)
              return Center(
                child: Text(
                  "No Record Found...",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              );
            else if (value.dataStatus == CallStatus.ErrorOccurred)
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Something went wrong please try again later",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              );
            else
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: buttonGradient,
                    ),
                    padding: EdgeInsets.symmetric(vertical: h * 22, horizontal: b * 20),
                    child: Row(children: [
                      Spacer(),
                      Text(
                        MyTripsLabel,
                        style: TextStyle(
                          fontSize: h * 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                      Spacer(),
                    ]),
                  ),
                  Expanded(
                    child: Container(
                      width: SizeConfig.screenWidth,
                      decoration: constBoxDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sh(20),
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: h * 10),
                              shrinkWrap: true,
                              itemCount: value.rideHistoryModel?.data?.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                Datum? data = value.rideHistoryModel?.data?[index];
                                return InkWell(
                                  onTap: () {},
                                  child: MyTripCard(data),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
          },
        ),
      ),
    );
  }
}
