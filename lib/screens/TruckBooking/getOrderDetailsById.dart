import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/payment_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import '../../models/Truck_models/getAllOrdersResponse.dart';
import '../../models/payment/TabPaymentDetails.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../utils/strings.dart';
import '../commonPages/web_view_screen.dart';
import 'package:http/http.dart' as http;

class OrderDetailById extends StatefulWidget {
  final GetAllOrdersResponse? getAllOrdersResponse;

  OrderDetailById(this.getAllOrdersResponse, {Key? key}) : super(key: key);

  @override
  _OrderDetailByIdState createState() =>
      _OrderDetailByIdState(this.getAllOrdersResponse);
}

class _OrderDetailByIdState extends State<OrderDetailById> {
  _OrderDetailByIdState(GetAllOrdersResponse? order) {
    fairTruckProvider.order = order;
  }
Timer? timer;
  @override
  void initState() {
    super.initState();
    logger.e(fairTruckProvider.order!.toJson());
    if (GetPlatform.isWeb && timer==null) {
      Timer.periodic(Duration(seconds:10), (timer) {
        this.timer=timer;
        fairTruckProvider.updateSingleOrder(widget.getAllOrdersResponse?.orderId?.toString());

      });
    }
  }

  late double h, b;

  // bool showOne=false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    h = SizeConfig.screenHeight / 812;
    b = SizeConfig.screenWidth / 375;

    paymentProvider.paymentWidget = showPaymentPart();
    return Scaffold(
      backgroundColor: greybackColor,
      appBar: AppBar(
        backgroundColor: textYellowColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "${fairTruckProvider.order!.orderDetails!.pickUpCity == 'string' ? 'Load '
              'City' : fairTruckProvider.order!.orderDetails!.pickUpCity} To "
          "${fairTruckProvider.order!.orderDetails!.dropOffCity == 'string' ? 'unLoad '
              'City' : fairTruckProvider.order!.orderDetails!.dropOffCity}",
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
      body: Consumer<FairTruckProvider>(builder: (context, data, child) {
        return Column(
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
                          padding: EdgeInsets.fromLTRB(
                              b * 17, h * 20, b * 17, h * 20),
                          decoration: BoxDecoration(
                            color: greybackColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              stepper(fairTruckProvider.order),
                              sh(20),
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
                                          fairTruckProvider.order!.orderDetails!
                                                  .pickUpAddress ??
                                              PickUpAddrLbl,
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
                                  SvgPicture.asset(
                                    'assets/icons/choose_city.svg',
                                    color: Color(0xffD40511),
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
                                          fairTruckProvider.order!.orderDetails!
                                                  .dropOffAddress ??
                                              "Your Destination",
                                          style: TextStyle(
                                            fontSize: h * 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // ),
                                ],
                              ),
                              sh(20),
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Order ID:',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order?.orderId
                                                ?.toString() ??
                                            "",
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Load City',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider
                                            .order!.orderDetails!.pickUpCity
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'UnLoad City',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider
                                            .order!.orderDetails!.dropOffCity
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Pickup Lat',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider
                                            .order!.orderDetails!.pickUpLat
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Pickup Lng',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider
                                            .order!.orderDetails!.pickUpLng
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Dropoff Lat',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider
                                            .order!.orderDetails!.dropOffLat
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Dropoff Lng',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider
                                            .order!.orderDetails!.dropOffLng
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Pickup Link',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                    .pickUpLink !=
                                                null
                                            ? fairTruckProvider.order!
                                                .orderDetails!.pickUpLink!
                                                .toString()
                                            : '--',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'DropOff Link',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                    .dropOffLink !=
                                                null
                                            ? fairTruckProvider.order!
                                                .orderDetails!.dropOffLink!
                                                .toString()
                                            : '--',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'NotificationSent',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                    .isNotificationSent ==
                                                true
                                            ? 'Yes'
                                            : 'No',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Distance',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider
                                                .order!.orderDetails!.distance
                                                .toString() +
                                            " KM",
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Amount',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.totalFare
                                                .toString() +
                                            " SAR",
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Created Date',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                .createdDate!.year
                                                .toString() +
                                            '-' +
                                            fairTruckProvider.order!.orderDetails!
                                                .createdDate!.month
                                                .toString() +
                                            '-' +
                                            fairTruckProvider.order!.orderDetails!
                                                .createdDate!.day
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Loaded',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                    .isLoaded !=
                                                null
                                            ? fairTruckProvider
                                                        .order!
                                                        .orderDetails!
                                                        .isLoaded ==
                                                    true
                                                ? 'Yes'
                                                : 'No'
                                            : 'null',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Accepted',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                    .isAccepted !=
                                                null
                                            ? fairTruckProvider
                                                        .order!
                                                        .orderDetails!
                                                        .isAccepted ==
                                                    true
                                                ? 'Yes'
                                                : 'No'
                                            : 'null',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Progress',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.inProgress !=
                                                null
                                            ? fairTruckProvider
                                                        .order!.inProgress ==
                                                    true
                                                ? 'Yes'
                                                : 'No'
                                            : 'null',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Delivered',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                    .isDelievered !=
                                                null
                                            ? fairTruckProvider
                                                        .order!
                                                        .orderDetails!
                                                        .isDelievered ==
                                                    true
                                                ? 'Yes'
                                                : 'No'
                                            : 'null',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'in process',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                    .isInProcess !=
                                                null
                                            ? fairTruckProvider
                                                        .order!
                                                        .orderDetails!
                                                        .isInProcess ==
                                                    true
                                                ? 'Yes'
                                                : 'No'
                                            : 'null',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Cancelled',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.orderDetails!
                                                    .isCanceled !=
                                                null
                                            ? fairTruckProvider
                                                        .order!
                                                        .orderDetails!
                                                        .isCanceled ==
                                                    true
                                                ? 'Yes'
                                                : 'No'
                                            : 'null',
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(10),
                              if (fairTruckProvider.order!.truckDriver != null)
                                Column(
                                  children: [
                                    Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                    sh(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        sw(7),
                                        Expanded(
                                          child: Text(
                                            'Driver Name',
                                            style: TextStyle(
                                                fontSize: h * 12,
                                                color: textYellowColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              fairTruckProvider.order!
                                                      .truckDriver!.name ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: h * 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sh(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        sw(7),
                                        Expanded(
                                          child: Text(
                                            'Driver ID',
                                            style: TextStyle(
                                                fontSize: h * 12,
                                                color: textYellowColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              fairTruckProvider
                                                      .order?.truckDriver?.tdId
                                                      .toString() ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: h * 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sh(20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        sw(7),
                                        Expanded(
                                          child: Text(
                                            'Driver Contact',
                                            style: TextStyle(
                                                fontSize: h * 12,
                                                color: textYellowColor),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              fairTruckProvider.order!
                                                      .truckDriver!.contact ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: h * 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    sh(20),
                                  ],
                                ),
                              sh(20),
                              if (fairTruckProvider
                                          .order!.orderDetails!.isCanceled !=
                                      null &&
                                  fairTruckProvider
                                          .order!.orderDetails!.isCanceled ==
                                      true)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    sw(7),
                                    Expanded(
                                      child: Text(
                                        'Cancellation Reason',
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          fairTruckProvider
                                              .order!.cancelationReason
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: h * 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Delivered Time',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.delieveredTime ==
                                                null
                                            ? "--"
                                            : fairTruckProvider
                                                .order!.delieveredTime
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Loaded Time',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order!.loadedTime ==
                                                null
                                            ? '--'
                                            : fairTruckProvider.order!.loadedTime
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Container(
                                color: Colors.grey,
                                height: 1,
                              ),
                              sh(20),
                              if (fairTruckProvider.order?.isLoaded == true &&
                                  fairTruckProvider.order?.isPaid == false)
                                Column(
                                  children: [
                                    paymentProvider.paymentWidget!,
                                    sh(20),
                                    Container(
                                      color: Colors.grey,
                                      height: 1,
                                    ),
                                  ],
                                ),
                              sh(10),
                              if (fairTruckProvider.order?.isPaid == false)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Text(
                                        'Payment Status',
                                        style: TextStyle(
                                            fontSize: h * 12,
                                            color: textYellowColor),
                                      ),
                                    ),
                                    Text(
                                      'Unpaid',
                                      style: TextStyle(
                                          fontSize: h * 12, color: Colors.red),
                                    ),
                                  ],
                                ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Payment Verified',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        fairTruckProvider.order?.isPaid == false
                                            ? "NO"
                                            : "YES",
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Verified By',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        paymentProvider
                                                .getPaymentEvidenceResponse
                                                ?.paymentVerifiedBy
                                                .toString() ??
                                            "--",
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  sw(7),
                                  Expanded(
                                    child: Text(
                                      'Verified Date',
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          color: textYellowColor),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        paymentProvider
                                                .getPaymentEvidenceResponse
                                                ?.paymentVerifiedDate
                                                .toString() ??
                                            "--",
                                        style: TextStyle(
                                          fontSize: h * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              sh(20),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            sh(20)
          ],
        );
      }),
    );
  }

  Widget docContainer({
    @required String? label,
    String? imageUrl,
    @required int? fileCode,
  }) {
    var b = SizeConfig.screenWidth / 375;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? "",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: h * 15,
            color: textYellowColor,
          ),
        ),
        sh(10),
        Padding(
          padding: EdgeInsets.only(right: b * 6),
          child: imageUrl == ''
              ? Container(
                  height: 120,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: phoneBoxBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                      onTap: () async {
                        if (Get.isDialogOpen == true) {
                          Get.back();
                        }
                        await paymentProvider.getPaymentImage(
                            fairTruckProvider.order!.orderId.toString());
                        setState(() {});
                      },
                      child: Center(child: Text('Upload Evidence'))),
                )
              : CachedNetworkImage(
                  imageUrl:
                      'https://thumbs.dreamstime.com/z/red-stamp-paid-grunge-frame-big-thumbs-up-text-153975323.jpg',
                  // ApiUrls.BASE_URL_TRUCK + imageUrl!,
                  width: Get.width,
                  height: Get.height * 0.25,
                  fit: BoxFit.fitWidth,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(b * 4),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
        ),
        sh(20),
      ],
    );
  }

  Widget stepper(GetAllOrdersResponse? order) {
    int index = 0;

    if (order != null) {
      if (order.isDelievered == true) {
        index = 3;
      } else if (order.isLoaded == true) {
        index = 2;
      } else if (order.inProgress == true) {
        index = 1;
      } else if (order.isAccepted == true) {
        index = 0;
      }
    }

    return Column(
      children: [
        Container(
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order",
                style: TextStyle(
                    color:
                        index == 0 || index > 0 ? Colors.green : Colors.white),
              ),
              Text("Reached",
                  style: TextStyle(
                      color: index == 1 || index > 1
                          ? Colors.green
                          : Colors.white)),
              Text("Road",
                  style: TextStyle(
                      color: index == 2 || index > 2
                          ? Colors.green
                          : Colors.white)),
              Text("Deliver",
                  style: TextStyle(
                      color: index == 3 || index > 3
                          ? Colors.green
                          : Colors.white))
            ],
          ),
        ),
        Container(
          height: 40,
          width: Get.width * 0.75,
          child: Center(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF35B66D), Color(0xFFF1E41B)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    height: 5,
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.circle,
                              size: 30,
                              color: index == 0 || index > 0
                                  ? Colors.green
                                  : Colors.white),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.circle,
                              size: 30,
                              color: index == 1 || index > 1
                                  ? Colors.green
                                  : Colors.white),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.circle,
                              size: 30,
                              color: index == 2 || index > 2
                                  ? Colors.green
                                  : Colors.white),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.circle,
                              size: 30,
                              color: index == 3 || index > 3
                                  ? Colors.green
                                  : Colors.white),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget showPaymentPart() {
    return Column(
      children: [
        if (fairTruckProvider.order!.isPaid == false)
          Consumer<PaymentProvider>(
              builder: (BuildContext context, value, Widget? child) {
            return docContainer(
              label: "Payment Evidence",
              imageUrl:
                  value.paymentFile == null && value.paymentEvidenceUrl == ''
                      ? ''
                      : value.paymentEvidenceUrl.toString(),
              fileCode: 1,
            );
          }),
        if (fairTruckProvider.order!.isPaid == false &&
            paymentProvider.paymentFile != null &&
            paymentProvider.paymentEvidenceUrl != '')
          Container(
            color: Colors.grey,
            height: 1,
          ),
        if (paymentProvider.paymentEvidenceUrl.isEmpty)
          InkWell(
            onTap: () async {
              if (fairTruckProvider.order?.isLoaded == false) {
                return;
              }
              if (fairTruckProvider.order!.isPaid == true) return;
              if (Get.isDialogOpen == true) {
                Get.back();
              }
              bool? isPaid;

              if (GetPlatform.isWeb) {
                Map<String, String> map = {
                  "OrderId": "${fairTruckProvider.order!.orderId}",
                  "userId": "${fairTruckProvider.order!.orderDetails!.user!.id}",
                  "Amount":
                      "${(fairTruckProvider.order!.totalFare! * 100).toInt()}",
                  "Description": "...."
                };
                TabPaymentDetails? tabPaymentDetails =
                    await getPaymentLink(map);
                if (tabPaymentDetails != null) {
                  // isPaid = await Get.to(PaymentWebView(initUrl: tabPaymentDetails.redirectUrl));
                    html.WindowBase base = html.window.open(tabPaymentDetails.redirectUrl??"google.com", 'Payment Tab');
                }
              } else {
                isPaid = await Get.to(PaymentWebView(
                    initUrl:
                        "https://admin.truc-king.io/Home/Payment?UserId=${fairTruckProvider.order!.orderDetails!.user!.id}&amount=${(fairTruckProvider.order!.totalFare! * 100).toInt()}&OrderId=${fairTruckProvider.order!.orderId}"));
              }

              if (isPaid == true) {
                fairTruckProvider.order!.isPaid = true;
                setState(() {});
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sw(7),
                Expanded(
                  child: Text(
                    'Pay By Card',
                    style: TextStyle(fontSize: h * 12, color: textYellowColor),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      fairTruckProvider.order!.isPaid == true
                          ? "PAID"
                          : "Click to Proceed",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: h * 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    paymentProvider.paymentEvidenceUrl = "";
    paymentProvider.getPaymentEvidenceResponse = null;
    if(timer!=null){
      print("I AM DISPOSED TIMER $timer");
      timer?.cancel();
    }
  }
}

Future<TabPaymentDetails?> getPaymentLink(Map<String, String> body) async {
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('https://admin.truc-king.io/api/PaymentEvidence/pay'));
    request.body = json.encode(body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      print(responseBody);
      return tabPaymentDetailsFromJson(responseBody);
    } else {
      print(response.reasonPhrase);
      print(responseBody);
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}
