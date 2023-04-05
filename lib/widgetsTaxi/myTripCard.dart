import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/models/RideHistory/ride_history_model.dart';
import 'package:sultan_cab/screens/Dispute/create_dispute.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'package:sultan_cab/utils/strings.dart';
import '../utils/sizeConfig.dart';

class MyTripCard extends StatelessWidget {
  final Datum? data;
  const MyTripCard(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.i(data?.user?.profileImage);
    SizeConfig().init(context);
    final h = SizeConfig.screenHeight / 812;
    final b = SizeConfig.screenWidth / 375;

    return Container(
      margin: EdgeInsets.only(right: b * 15, bottom: h * 10, left: b * 15),
      decoration: BoxDecoration(
        boxShadow: boxShadow2,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 13, left: b * 20),
                child: CachedNetworkImage(
                  imageUrl: (data?.user?.profileImage ?? ""),
                  width: b * 50,
                  height: h * 50,
                  fit: BoxFit.fitWidth,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(b * 6),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (BuildContext buildCtx, value, widget) {
                    return SvgPicture.asset("assets/icons/profileIcon.svg");
                  },
                ),
              ),
              sw(10),
              Padding(
                padding: EdgeInsets.only(top: h * 13),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data?.user?.name ?? "Sultan Driver",
                      style: TextStyle(
                        fontSize: b * 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    sh(3),
                    // Text(
                    //  "",
                    //   style: TextStyle(
                    //     color: Color(0xff3f3d56),
                    //     fontSize: b * 12,
                    //   ),
                    // ),
                    // sh(3),
                    // Text(
                    //   "Registration Number!",
                    //   style: TextStyle(
                    //     color: Color(0xff3f3d56),
                    //     fontSize: b * 12,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 7),
                decoration: BoxDecoration(
                  color: tagColor("Booking Status"),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(5),
                  ),
                ),
                child: Text(
                  data?.status?.toUpperCase() ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          sh(14),
          Padding(
            padding: EdgeInsets.fromLTRB(b * 16, 0, b * 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/blue_cirle.svg',
                      width: b * 17,
                    ),
                    sw(19),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?.startAddress ?? "",
                            style: TextStyle(
                              fontSize: b * 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/calendar.svg",
                                width: b * 10,
                                color: Colors.black,
                              ),
                              sw(8),
                              if (data?.createdAt != null)
                                Text(
                                  timeFormat(TimeOfDay.fromDateTime(data!.createdAt!)),
                                  style: TextStyle(
                                    fontSize: b * 10,
                                  ),
                                ),
                            ],
                          ),
                          sh(3),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/clock.svg",
                                width: b * 14,
                                color: Colors.black,
                              ),
                              sw(8),
                              if (data?.arrivedAt != null)
                                Text(
                                  timeFormat(TimeOfDay.fromDateTime(data!.arrivedAt!)),
                                  style: TextStyle(
                                    fontSize: b * 10,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(-b * 3, 0),
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
                      color: Colors.red,
                      height: h * 20,
                    ),
                    sw(19),
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?.endAddress ?? "",
                            style: TextStyle(
                              fontSize: b * 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          sh(16),
          Container(
            margin: EdgeInsets.symmetric(horizontal: b * 15),
            color: primaryColor,
            height: h * 1.5,
            width: SizeConfig.screenWidth,
          ),
          sh(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (data?.id != null)
                    Get.to(() => CreateDispute(
                          reqID: data!.id!,
                        ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(5),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Text(
                      "Create Dispute",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String label(String title) {
    if (title == ReportLabel)
      return "assets/icons/report.svg";
    else if (title == CancelLabel)
      return "assets/icons/cancel.svg";
    else if (title == UpdateLabel)
      return "assets/icons/update.svg";
    else if (title == ReportHisLabel)
      return "assets/icons/report.svg";
    else if (title == RatingLabel) return "assets/icons/rating.svg";
    return '';
  }
}

Color tagColor(String type) {
  if (type == CancelledLabel)
    return Color(0xffc22a23);
  else if (type == CompletedLabel)
    return Color(0xff14ce5e);
  else if (type == ConfirmedLabel)
    return Color(0xff55a3ff);
  else if (type == PendingLabel) return primaryColor;
  return Color(0xff395185);
}
