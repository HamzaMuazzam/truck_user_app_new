import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';

import '../../providers/truck_provider/app_flow_provider.dart';
import 'choose_vehicle.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({Key? key}) : super(key: key);

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  late double h, b;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    h = SizeConfig.screenHeight / 812;
    b = SizeConfig.screenWidth / 375;

    final appProvider = Provider.of<AppFlowProvider>(context);
    bool isMap = appProvider.isMap;
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              appProvider.changeBookingStage(BookingStage.PickUp);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: h * 22,
                horizontal: b * 20,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: h * 18,
              ),
            ),
          ),
          title: Text(
            DestinationLabel,
            style: TextStyle(
              fontSize: h * 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: buttonGradient,
            ),
          ),
        ),
        if (appFlowProvider.destinationType == DestinationType.Single)
          Expanded(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: b * 15,
                        vertical: h * 15,
                      ),
                      padding: EdgeInsets.fromLTRB(b * 17, h * 20, b * 17, h * 20),
                      decoration: BoxDecoration(
                        color: greybackColor,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff0000000).withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// 1st Location
                                    Text(
                                      appProvider.currentAdd ?? PickUpAddrLbl,
                                      style: TextStyle(
                                        fontSize: h * 12,
                                      ),
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
                              SvgPicture.asset(
                                'assets/icons/choose_city.svg',
                                color: Color(0xffD40511),
                                height: h * 20,
                              ),
                              sw(19),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// Other Location
                                    Text(
                                      appProvider.destAdd ?? "Enter Destination",
                                      style: TextStyle(
                                        fontSize:h * 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ),
                            ],
                          ),
                          sh(15),
            Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                [

                        Text(
                            "Travel Time-${appProvider.directions==null?"":appProvider.directions!.totalDuration}"),
                        Text("/"),
                        if (appProvider.destinationType != DestinationType.Multiple)
                          Text("Distance-${appProvider.directions!.totalDistance}"),
                        if (appProvider.destinationType == DestinationType.Multiple)
                          Text("Distance-${appProvider.totalDistance}"),
                      ],
            ),
                        ],
                      ),
                    ),
                    sh(25),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: h * 20,
                      horizontal: b * 30,
                    ),
                    child: AppButton(
                      label: isMap ? ConfirmLocationLabel : LocateOnMapLabel,
                      onPressed: () {
                        if (isMap) {
                          appProvider.changeBookingStage(BookingStage.Vehicle);
                          // Get.to(ChooseCar());
                          // appProvider.changeMapStatus(true);
                        }
                      },
                      isShadow: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (appFlowProvider.destinationType == DestinationType.Multiple) destinationWidget(isMap),
      ],
    );
  }

  Widget destinationWidget(
      bool isMap,
      ) {
    return Container(
      height: Get.height * .3,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (isMap) {
                    appFlowProvider.changeBookingStage(BookingStage.Vehicle);
                    appFlowProvider.changeMapStatus(true);
                  }
                },
                child: Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                ),
                backgroundColor: Colors.black,
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: appFlowProvider.multiDestinationList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                dense: true,
                leading: Icon(
                  Icons.location_on_outlined,
                  color: index == 0 ? Colors.red : secondaryColor,
                ),
                title: Text(
                  appFlowProvider.multiDestinationList[index].locationResult?.formattedAddress ??
                      "",
                  style: TextStyle(fontSize: 12),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
