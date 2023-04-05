import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:shimmer/shimmer.dart';

class VehicleCardHistoryShimmer extends StatelessWidget {
  final List<String> menuLabel = [ReportLabel];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      margin: EdgeInsets.only(right: b * 15, bottom: h * 10, left: b * 15),
      padding: EdgeInsets.fromLTRB(b * 5, h * 0, b * 15, h * 13),
      decoration: BoxDecoration(
        boxShadow: boxShadow2,
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[400]!,
                child: Container(
                  margin: EdgeInsets.only(left: b * 11),
                  padding: EdgeInsets.symmetric(horizontal: b * 30, vertical: h * 7),
                  decoration: BoxDecoration(
                    // color: tagColor("Completed"),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    "Completed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: b * 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          sh(17),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 5, left: b * 10),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[400]!,
                  child: Image.asset(
                    'assets/images/car_placeholder.png',
                    height: h * 95,
                    width: b * 148,
                  ),
                ),
              ),
              sw(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[400]!,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tata Nexon - Blue",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: b * 14,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.info_outline,
                            color: secondaryColor,
                            size: b * 16,
                          ),
                        ],
                      ),
                    ),
                    sh(10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[400]!,
                      child: Row(
                        children: [
                          Text(
                            OrderIdLabel + ":",
                            style: TextStyle(
                              fontSize: b * 11.5,
                              color: Color(0xff3f3d56),
                            ),
                          ),
                          Text(
                            "Nexon1234",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: b * 10,
                              color: Color(0xffa7a7a7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    sh(10),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[400]!,
                      child: Text(
                        TotalAmountLabel,
                        style: TextStyle(
                          fontSize: b * 10,
                          letterSpacing: 0.6,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    sh(5),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[400]!,
                      child: Text(
                        "\u20b910000",
                        style: TextStyle(
                          fontSize: b * 18,
                          letterSpacing: 0.6,
                          color: primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          sh(19),
          Container(
            margin: EdgeInsets.only(left: b * 10),
            padding: EdgeInsets.symmetric(horizontal: b * 22, vertical: h * 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xfff2f2f2),
              ),
              borderRadius: BorderRadius.circular(b * 4),
            ),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[400]!,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/calendar.svg",
                        width: b * 10,
                        color: Colors.black,
                      ),
                      sw(8),
                      Text(
                        "21-11-2002",
                        style: TextStyle(fontSize: b * 12, letterSpacing: 0.6),
                      ),
                      Spacer(),
                      Text(
                        ToLabel,
                        style: TextStyle(
                          fontSize: b * 12,
                          letterSpacing: 0.6,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        "assets/icons/calendar.svg",
                        width: b * 10,
                        color: Colors.black,
                      ),
                      sw(8),
                      Text(
                        "21-11-2300",
                        style: TextStyle(fontSize: b * 12, letterSpacing: 0.6),
                      ),
                    ],
                  ),
                ),
                sh(10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[400]!,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/clock.svg",
                        width: b * 14,
                        color: Colors.black,
                      ),
                      sw(8),
                      Text(
                        "9:26 AM",
                        style: TextStyle(fontSize: b * 12, letterSpacing: 0.6),
                      ),
                      Spacer(),
                      Text(
                        ToLabel,
                        style: TextStyle(
                          fontSize: b * 12,
                          letterSpacing: 0.6,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Spacer(),
                      SvgPicture.asset(
                        "assets/icons/clock.svg",
                        width: b * 14,
                        color: Colors.black,
                      ),
                      sw(8),
                      Text(
                        "9:26 PM",
                        style: TextStyle(fontSize: b * 12, letterSpacing: 0.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
