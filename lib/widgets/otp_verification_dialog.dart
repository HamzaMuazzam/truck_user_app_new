import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';

class OtpSendDialog extends StatelessWidget {
  OtpSendDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: b * 15),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(b * 10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: b * 16,
          vertical: h * 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/activate_email_illus.png',
              height: h * 110,
            ),
            sh(20),
            Text(
              ActivateEmailSendMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: b * 14,
                color: Colors.black,
              ),
            ),
            sh(15),
            MaterialButton(
              color: primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                OkayLabel,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: b * 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

dialogBoxActivationLinkSent(BuildContext context) async {
  await showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    builder: (BuildContext context) {
      return OtpSendDialog();
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 300),
  );
}
