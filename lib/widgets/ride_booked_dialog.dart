import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';

import '../providers/GoogleMapProvider/location_and_map_provider.dart';
import '../providers/truck_provider/app_flow_provider.dart';
import '../screens/TruckBooking/navigation_screen.dart';

class BookRideDialog extends StatelessWidget {
  final Function()? onConfirm;
  BookRideDialog({this.onConfirm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: b * 30),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(b * 10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: b * 16, vertical: h * 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/activate_email_illus.png',
              height: h * 100,
            ),
            sh(10),
            Text(
              'Ride Booking Request has been received',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: b * 14,
                  color: textColor
              ),
            ),
            sh(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Expanded(
                //   child: InkWell(
                //     splashColor: Colors.transparent,
                //     highlightColor: Colors.transparent,
                //     onTap: () {
                //       Navigator.pop(context);
                //     },
                //     child: Container(
                //       alignment: Alignment.center,
                //       padding: EdgeInsets.symmetric(vertical: h * 16),
                //       decoration: BoxDecoration(
                //         color: greyColor,
                //
                //         border: Border.all(color: greyColor),
                //         borderRadius: BorderRadius.circular(b * 4),
                //       ),
                //       child: Text(
                //         NoLabel,
                //         style: TextStyle(
                //           letterSpacing: 0.6,
                //           fontSize: b * 12,
                //           height: 1,
                //           fontWeight: FontWeight.w700,
                //           color: textColor,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // sw(20),
                Expanded(
                  child: AppButton(
                    onPressed: onConfirm,
                    label: OkayLabel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> dialogBoxRideBook(BuildContext context) async {
  bool status = false;
  await showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (BuildContext context) {
      return BookRideDialog(
        onConfirm: () {
          appFlowProvider.stage= BookingStage.PickUp;
          authProvider.gotoPage(NavigationScreen(), isClosePrevious: true);

        },
      );
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 300),
  );
  return status;
}
