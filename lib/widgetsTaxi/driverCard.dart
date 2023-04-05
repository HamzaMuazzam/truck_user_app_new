import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sultan_cab/models/taxi/allRides.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';

class DriverCard extends StatelessWidget {
  const DriverCard({
    Key? key,
    required this.h,
    required this.b,
    this.res,
    this.isLocal,
  }) : super(key: key);

  final double h;
  final double b;
  final Result? res;
  final bool? isLocal;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      padding: EdgeInsets.fromLTRB(b * 15, h * 15, b * 15, 0),
      decoration: allBoxDecoration,
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    "https://res.cloudinary.com/djisilfwk/image/upload/v1644340042/thriftycab/avatar/michail_ratbej.jpg",
                width: b * 56,
                height: h * 59,
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
              ),
              sw(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    res?.driver ?? "Pavan Kumar",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: b * 14,
                    ),
                  ),
                  sh(5),
                  Text(
                    res?.fleetAssigned!.modelName ?? 'Toyota Etios',
                    style: TextStyle(
                      color: Color(0xff3f3d56),
                      fontSize: b * 12,
                    ),
                  ),
                  sh(3),
                  Text(
                    res?.fleetAssigned!.registerationNumber ?? 'DL 1 DS 7890',
                    style: TextStyle(
                      color: Color(0xff3f3d56),
                      fontSize: b * 12,
                    ),
                  )
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: b * 10, vertical: h * 4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Text(
                          ("4.8"),
                          style: TextStyle(
                            fontSize: b * 12,
                          ),
                        ),
                        sw(5),
                        Icon(
                          Icons.star,
                          size: b * 10,
                        )
                      ],
                    ),
                  ),
                  sh(9),
                  Text(
                    StatusLabel,
                    style: TextStyle(
                      fontSize: b * 12,
                      color: Color(0xff3f3d56),
                    ),
                  ),
                  sh(5),
                  Text(
                    status(res?.bookingStatus ?? ConfirmedLabel, isLocal!),
                    style: TextStyle(
                      fontSize: b * 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff3f3d56),
                    ),
                  )
                ],
              )
            ],
          ),
          (res?.bookingStatus! == PendingLabel ||
                  res?.bookingStatus! == ConfirmedLabel ||
                  (isLocal == true &&
                      (res?.bookingStatus != CompletedLabel &&
                          res?.bookingStatus != CancelledLabel &&
                          res?.bookingStatus != OnGoingLabel)))
              ? Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          // dialogBoxCancel(context, BookingHistoryModel(), true);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Color(0xffd40511),
                              size: b * 14,
                            ),
                            sw(5),
                            Text(
                              CancelRideLabel,
                              style: TextStyle(
                                color: Color(0xffd40511),
                                fontWeight: FontWeight.w700,
                                fontSize: b * 12,
                              ),
                            ),
                          ],
                        )),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: b * 14,
                            color: Colors.black,
                          ),
                          sw(5),
                          Text(
                            CallNowLabel,
                            style: TextStyle(
                              color: Color(0xff3f3d56),
                              fontWeight: FontWeight.w500,
                              fontSize: b * 12,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : sh(15),
        ],
      ),
    );
  }
}

String status(String status, bool isLocal) {
  if (status == CompletedLabel)
    return CompletedLabel;
  else if (status == OnGoingLabel)
    return OnGoingLabel;
  else if (status == CancelledLabel)
    return CancelledLabel;
  else if (status == PendingLabel)
    return YetToConfirmLabel;
  else if (status == ConfirmedLabel) return ArrivingLabel;
  return '';
}
