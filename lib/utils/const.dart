import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/colors.dart';

class AppConst {
  static const String countryCode = '+966';

  static Future startProgress({bool barrierDismissible=true}) async {
    if (!Get.isDialogOpen!)
      await 0.delay();
      await 0.delay();
      await 0.delay();
      await Get.generalDialog(barrierDismissible: barrierDismissible ,barrierLabel: "barrierLabel",pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Center(
          child: SpinKitCircle(itemBuilder: (BuildContext context, index) {
            return Container(
              width: 10,
              height: 10,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100), color: secondaryColor),
            );
          }),
        );
      });
  }

  static Future<void> stopProgress() async {
    if (Get.isDialogOpen!) Get.back();
  }

  static Future<void> successSnackBar(String message) async {
    await Get.snackbar(
      "Status : Success",
      message,
      colorText: Colors.white,
      backgroundColor: Colors.black,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      icon: Icon(
        Icons.check,
        color: Colors.green,
        size: 40,
      ),
    );
  }

  static Future<void> errorSnackBar(String message) async {
    await Get.snackbar(
      duration: Duration(seconds: 3),
      "Error",
      message,
      colorText: Colors.white,
      backgroundColor: Colors.black,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      icon: Icon(
        Icons.cancel,
        color: Colors.red,
        size: 40,
      ),
    );
  }

  static Future<void> infoSnackBar(String message) async {
    await Get.snackbar(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.black,
      margin: EdgeInsets.zero,
      borderRadius: 0,
      "Alert",
      message,
      colorText: Colors.white,
      icon: Icon(
        Icons.info_outline,
        color: Colors.white,
        size: 40,
      ),
    );
  }

  static String? arrangePhoneNumberFormat(String _phoneNumCtrlTxt) {
    if (_phoneNumCtrlTxt.length < 11 && _phoneNumCtrlTxt.length == 10) {
      return '$countryCode$_phoneNumCtrlTxt';
    } else if (_phoneNumCtrlTxt.length == 11 && _phoneNumCtrlTxt.split('').first == '0') {
      return _phoneNumCtrlTxt.replaceFirst('0', countryCode);
    } else if (_phoneNumCtrlTxt.length == 14 && _phoneNumCtrlTxt.startsWith
      ('+966')) {
      return _phoneNumCtrlTxt;
    // } else if (_phoneNumCtrlTxt.length == 14 && _phoneNumCtrlTxt.startsWith('0092')) {
    //   return _phoneNumCtrlTxt.replaceFirst('0092', countryCode);
    } else {
      return null;
    }
  }
}
