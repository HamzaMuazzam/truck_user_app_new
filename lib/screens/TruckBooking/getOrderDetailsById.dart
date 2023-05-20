import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/payment_provider.dart';

import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import '../../models/Truck_models/getAllOrdersResponse.dart';
import '../../providers/auth_provider.dart';
import '../../services/ApiServices/api_urls.dart';
import '../../utils/strings.dart';

class OrderDetailById extends StatefulWidget {
  final GetAllOrdersResponse? getAllOrdersResponse;

  OrderDetailById(this.getAllOrdersResponse, {Key? key}) : super(key: key);

  @override
  _OrderDetailByIdState createState() =>
      _OrderDetailByIdState(this.getAllOrdersResponse);
}

class _OrderDetailByIdState extends State<OrderDetailById> {
  final GetAllOrdersResponse? order;

  _OrderDetailByIdState(this.order);

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

    return Scaffold(
      backgroundColor: greybackColor,
      appBar: AppBar(
        backgroundColor: textYellowColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "${order!.orderDetails!.pickUpCity == 'string' ? 'Load '
              'City' : order!.orderDetails!.pickUpCity} To "
          "${order!.orderDetails!.dropOffCity == 'string' ? 'unLoad '
              'City' : order!.orderDetails!.dropOffCity}",
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
                          vertical: h * 15,
                        ),
                        padding:
                            EdgeInsets.fromLTRB(b * 17, h * 20, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            stepper(order),
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
                                        order!
                                                .orderDetails!.pickUpAddress ??
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
                                        order!
                                                .orderDetails!.dropOffAddress ??
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                          .orderDetails!.pickUpCity
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                          .orderDetails!.dropOffCity
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                          .orderDetails!.pickUpLat
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                          .orderDetails!.pickUpLng
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                          .orderDetails!.dropOffLat
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                          .orderDetails!.dropOffLng
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                                  .orderDetails!.pickUpLink !=
                                              null
                                          ? order!
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                                  .orderDetails!.dropOffLink !=
                                              null
                                          ? order!
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!.orderDetails!
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                          .orderDetails!.distance
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                              .orderDetails!.createdDate!.year
                                              .toString() +
                                          '-' +
                                          order!
                                              .orderDetails!.createdDate!.month
                                              .toString() +
                                          '-' +
                                          order!
                                              .orderDetails!.createdDate!.day
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                                  .orderDetails!.isLoaded !=
                                              null
                                          ? order!
                                                      .orderDetails!.isLoaded ==
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                                  .orderDetails!.isAccepted !=
                                              null
                                          ? order!.orderDetails!
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!.inProgress != null
                                          ? order!.inProgress ==
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                                  .orderDetails!.isDelievered !=
                                              null
                                          ? order!.orderDetails!
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                                  .orderDetails!.isInProcess !=
                                              null
                                          ? order!.orderDetails!
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!
                                                  .orderDetails!.isCanceled !=
                                              null
                                          ? order!.orderDetails!
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
                            sh(20),
                            if (order!
                                        .orderDetails!.isCanceled !=
                                    null &&
                                order!
                                        .orderDetails!.isCanceled ==
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
                                        order!.cancelationReason
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!.delieveredTime ==
                                              null
                                          ? "--"
                                          : order!.delieveredTime
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      order!.loadedTime == null
                                          ? '--'
                                          : order!.loadedTime
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
                            Consumer<PaymentProvider>(builder:
                                (BuildContext context, value, Widget? child) {
                              return docContainer(
                                label: "Payment Evidence",
                                imageUrl: value.paymentFile == null &&
                                        value.paymentEvidenceUrl == ''
                                    ? ''
                                    :
                                // value.paymentEvidenceUrl != ''
                                //         ?
                                value.paymentEvidenceUrl.toString(),
                                        // : value.paymentFile!.path.toString(),
                                fileCode: 1,
                              );
                            }),
                            sh(20),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                            sh(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                sw(7),
                                Expanded(
                                  child: Text(
                                    'Payment Varified',
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
                                          .getPaymentEvidenceResponse!=null?
                                    paymentProvider
                                        .getPaymentEvidenceResponse!
                                        .isVerified==true ? 'Yes':'No':'No',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                sw(7),
                                Expanded(
                                  child: Text(
                                    'Varified By',
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
                                          .getPaymentEvidenceResponse!=null  ?   paymentProvider
                                          .getPaymentEvidenceResponse!
                                          .paymentVerifiedBy.toString():'--',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                sw(7),
                                Expanded(
                                  child: Text(
                                    'Varified Date',
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
                                          .getPaymentEvidenceResponse!=null?   paymentProvider
                                          .getPaymentEvidenceResponse!
                                          .paymentVerifiedDate.toString():'--',
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
      ),
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
          child: InkWell(
            onTap: () {
              // Get.to(  ImagePreview(
              //   photoUrl: 'https://api.truck.deeps.info/api/' + imageUrl!,
              //   name: label,
              // ));
            },
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
                          await paymentProvider.getPaymentImage
                            (order!.id.toString());
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
        ),
        sh(20),
      ],
    );
  }


  Widget stepper(GetAllOrdersResponse? order) {
    int index=0;

    if(order!=null){
      if(order.isAccepted==false && order.isDelievered==false && order.isLoaded==false){
        index=0;
      } else if(order.isAccepted==true && order.isDelievered==false && order.isLoaded==false){
        index=1;
      }
      else if(order.isAccepted==true && order.isDelievered==false && order.isLoaded==true && order.isInProcess==true){
        index=2;
      }else if(order.isAccepted==true && order.isDelievered==true && order.isInProcess==false){
        index=3;
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
                "info",
                style: TextStyle(
                    color: index == 0 || index > 0 ? Colors.green : Colors.white),
              ),
              Text("Service",
                  style: TextStyle(
                      color:
                      index == 1 || index > 1 ? Colors.green : Colors.white)),
              Text("Details",
                  style: TextStyle(
                      color:
                      index == 2 || index > 2 ? Colors.green : Colors.white)),
              Text("Delivered",
                  style: TextStyle(
                      color:
                      index == 3 || index > 3 ? Colors.green : Colors.white))
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

}
