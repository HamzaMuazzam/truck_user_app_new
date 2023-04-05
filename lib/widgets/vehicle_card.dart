import 'package:flutter/material.dart';
import 'package:sultan_cab/models/vehicle_model.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/cachedImage.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({Key? key, @required this.vehicle, this.fun}) : super(key: key);

  final VehicleModel? vehicle;
  final Function()? fun;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      margin: EdgeInsets.only(
        right: b * 15,
        bottom: h * 10,
        left: b * 15,
      ),
      padding: EdgeInsets.fromLTRB(
        b * 5,
        h * 20,
        b * 15,
        h * 20,
      ),
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
              Hero(
                tag: vehicle!.vehicleId!.toString(),
                child: CachedImage(
                  imgUrl: vehicle!.photo!,
                  height: h * 95,
                  isGallery: false,
                  width: b * 148,
                  vehicleId: vehicle!.vehicleId.toString(),
                ),
              ),
              sw(24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            vehicle!.vehicleName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: b * 14,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // dialogBoxDetail(context, vehicle!);
                          },
                          child: Icon(
                            Icons.info_outline,
                            color: secondaryColor,
                            size: b * 16,
                          ),
                        ),
                      ],
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
                            vehicle!.isLimited != 'No'
                                ? vehicle!.limitedPrice!.substring(
                                      0,
                                      vehicle!.limitedPrice!.indexOf('/'),
                                    ) +
                                    '/$DayLabel'
                                : "No",
                            style: TextStyle(
                              fontSize: b * 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffa7a7a7),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            vehicle!.isUnlimited != 'No'
                                ? vehicle!.unlimitedPrice!.substring(
                                      0,
                                      vehicle!.unlimitedPrice!.indexOf('/'),
                                    ) +
                                    '/$DayLabel'
                                : 'No',
                            textAlign: TextAlign.center,
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
                    AppButton(
                      label: BookNowLabel,
                      vertPad: h * 10,
                      onPressed: this.fun,
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
