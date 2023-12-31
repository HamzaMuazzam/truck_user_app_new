import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/fair_provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/payment_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';

import '../../providers/truck_provider/app_flow_provider.dart';
import '../../services/apiServices/StorageServices/get_storage.dart';
import 'getOrderDetailsById.dart';

class GetAllOrdersScreen extends StatefulWidget {
  GetAllOrdersScreen();

  @override
  _GetAllOrdersScreenState createState() => _GetAllOrdersScreenState();
}

class _GetAllOrdersScreenState extends State<GetAllOrdersScreen> {
  @override
  void initState() {
    fairTruckProvider.getAllOrdersDetails();
    super.initState();
  }

  late double h, b;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    h = SizeConfig.screenHeight / 812;
    b = SizeConfig.screenWidth / 375;
    print(StorageCRUD.getUser().id.toString() + " this is user id");

    final appProvider = Provider.of<AppFlowProvider>(context);

    return Consumer<FairTruckProvider>(
        builder: (BuildContext context, value, Widget? child) {
      return Scaffold(
        backgroundColor: greybackColor,
        body: Container(
            height: Get.height,
            child: !value.allOrders
                ? Center(
                    child: Text(
                    'There is no order history'.tr,
                    style: TextStyle(color: textYellowColor),
                  ))
                : value.allOrders && value.getAllOrdersResponse.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.getAllOrdersResponse.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      await paymentProvider.getPaymentEvidence(
                                          value.getAllOrdersResponse[index]
                                              .orderId
                                              .toString());
                                      print(value
                                          .getAllOrdersResponse[index].orderId
                                          .toString());
                                      Get.to(OrderDetailById(
                                          value.getAllOrdersResponse[index]));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: b * 15,
                                        // vertical: h * 15,
                                      ),
                                      padding: EdgeInsets.fromLTRB(
                                          b * 17, h * 20, b * 17, h * 0),
                                      decoration: BoxDecoration(
                                        color: greybackColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    /// 1st Location
                                                    Text(
                                                      value
                                                                  .getAllOrdersResponse[
                                                                      index]
                                                                  .orderDetails!
                                                                  .pickUpAddress !=
                                                              null
                                                          ? value
                                                              .getAllOrdersResponse[
                                                                  index]
                                                              .orderDetails!
                                                              .pickUpAddress
                                                              .toString()
                                                          : "Pick up address"
                                                              .tr,
                                                      style: TextStyle(
                                                          fontSize: h * 12,
                                                          color:
                                                              textYellowColor),
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
                                                      value
                                                              .getAllOrdersResponse[
                                                                  index]
                                                              .orderDetails!
                                                              .dropOffAddress ??
                                                          "Your Destination".tr,
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  appProvider.destAdd ??
                                                      "Estimated Price".tr,
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
                                                            .getAllOrdersResponse[
                                                                index]
                                                            .totalFare!
                                                            .toInt()
                                                            .toString() +
                                                        ' SAR'.tr,
                                                    style: TextStyle(
                                                      fontSize: h * 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // ),
                                            ],
                                          ),
                                          sh(20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  appProvider.destAdd ??
                                                      "Order ID".tr,
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
                                                        .getAllOrdersResponse[
                                                            index]
                                                        .orderId
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: h * 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // ),
                                            ],
                                          ),
                                          sh(20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  appProvider.destAdd ??
                                                      "Payment".tr,
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
                                                                    .getAllOrdersResponse[
                                                                        index]
                                                                    .isLoaded ==
                                                                true &&
                                                            fairTruckProvider
                                                                    .getAllOrdersResponse[
                                                                        index]
                                                                    .isPaid ==
                                                                true
                                                        ? "PAID".tr
                                                        : "UNPAID".tr,
                                                    style: TextStyle(
                                                      fontSize: h * 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // ),
                                            ],
                                          ),
                                          sh(20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  appProvider.destAdd ??
                                                      "Is Loaded?".tr,
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
                                                                .getAllOrdersResponse[
                                                                    index]
                                                                .isLoaded ==
                                                            true
                                                        ? "Yes".tr
                                                        : "No".tr,
                                                    style: TextStyle(
                                                      color: fairTruckProvider
                                                                  .getAllOrdersResponse[
                                                                      index]
                                                                  .isLoaded ==
                                                              true
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontSize: h * 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // ),
                                            ],
                                          ),
                                          sh(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Driver Detail".tr,
                                                  style: TextStyle(
                                                      fontSize: h * 12,
                                                      color: textYellowColor),
                                                ),
                                              ),

                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    value
                                                                .getAllOrdersResponse[
                                                                    index]
                                                                .truckDriver ==
                                                            null
                                                        ? '--'
                                                        : value
                                                                .getAllOrdersResponse[
                                                                    index]
                                                                .truckDriver!
                                                                .name ??
                                                            '--',
                                                    style: TextStyle(
                                                      fontSize: h * 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // ),
                                            ],
                                          ),
                                          sh(10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Order Status".tr,
                                                  style: TextStyle(
                                                      fontSize: h * 12,
                                                      color: textYellowColor),
                                                ),
                                              ),

                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    value.getAllOrdersResponse[index]
                                                                .isDelievered ==
                                                            true
                                                        ? "Completed".tr
                                                        : "Ongoing".tr,
                                                    style: TextStyle(
                                                        fontSize: h * 16,
                                                        color: value
                                                                    .getAllOrdersResponse[
                                                                        index]
                                                                    .isDelievered ==
                                                                true
                                                            ? Colors.green
                                                            : Colors.red),
                                                  ),
                                                ),
                                              ),
                                              // ),
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
                                  ),
                                ]),
                          );
                        })
                    : Center(
                        child:
                            CircularProgressIndicator(color: textYellowColor))),
      );
    });
  }
}
