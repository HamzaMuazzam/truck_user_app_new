import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';

class DocWarningDialog extends StatelessWidget {
  DocWarningDialog({Key? key, @required this.ctx, @required this.onYesPressed, @required this.msg})
      : super(key: key);

  final BuildContext? ctx;
  final void Function()? onYesPressed;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: b * 20),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(b * 10),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: b * 16, vertical: h * 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_rounded,
              color: primaryColor,
              size: b * 80,
            ),
            sh(10),
            Text(
              msg ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: b * 14,
                color: Colors.black,
              ),
            ),
            sh(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                sw(10),
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
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(b * 4),
                      ),
                      child: Text(
                        NoLabel,
                        style: TextStyle(
                          letterSpacing: 0.6,
                          fontSize: b * 12,
                          height: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                sw(20),
                Expanded(
                  child: AppButton(
                    label: ConfirmLabel,
                    onPressed: onYesPressed,
                  ),
                ),
                sw(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
