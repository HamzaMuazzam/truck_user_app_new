import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';

class LogOutDialog extends StatelessWidget {
  final Function()? onConfirm;
  LogOutDialog({this.onConfirm, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: h * 30),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(b * 10),
      ),
      child: Container(
        width: Get.width<700 ?Get.width/1.3
        :Get.width/1.7,
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
              ConfirmLogoutMsg,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: h * 14,
                color: textColor
              ),
            ),
            sh(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: h * 16),
                      decoration: BoxDecoration(
                        color: greyColor,

                        border: Border.all(color: greyColor),
                        borderRadius: BorderRadius.circular(h * 4),
                      ),
                      child: Text(
                        NoLabel,
                        style: TextStyle(
                          letterSpacing: 0.6,
                          fontSize: h * 15,
                          height: 1,
                          fontWeight: FontWeight.w700,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
                sw(20),
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

Future<bool> dialogBoxLogout(BuildContext context) async {
  bool status = false;
  await showDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (BuildContext context) {
      return LogOutDialog(
        onConfirm: () {
          Navigator.pop(context);
          status = true;
        },
      );
    },
  );
  return status;
}
