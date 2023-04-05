import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:shimmer/shimmer.dart';

class VehicleCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      margin: EdgeInsets.only(right: b * 15, bottom: h * 10, left: b * 15),
      padding: EdgeInsets.fromLTRB(b * 5, h * 20, b * 15, h * 20),
      decoration: BoxDecoration(
        boxShadow: boxShadow2,
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[200]!,
                highlightColor: Colors.grey[400]!,
                child: Image.asset(
                  'assets/images/car_placeholder.png',
                  height: h * 95,
                  width: b * 148,
                ),
              ),
              sw(24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[400]!,
                      child: Text(
                        "TATA Motors Innova- Gray",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: b * 14,
                        ),
                      ),
                    ),
                    sh(10),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            LimitedLabel,
                            style: TextStyle(
                              fontSize: b * 12,
                              color: Color(0xff3f3d56),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            UnLimitedLabel,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: b * 12,
                              color: Color(0xff3f3d56),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sh(3),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "3000/day",
                            style: TextStyle(
                              fontSize: b * 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffa7a7a7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "3000/day",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: b * 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffa7a7a7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    sh(11),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[200]!,
                      highlightColor: Colors.grey[400]!,
                      child: AppButton(
                        label: BookNowLabel,
                        vertPad: h * 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
