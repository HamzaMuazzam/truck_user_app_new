import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';

class ChangeDateDialog extends StatelessWidget {
  ChangeDateDialog({Key? key}) : super(key: key);

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
            Icon(
              Icons.warning_rounded,
              color: primaryColor,
              size: b * 80,
            ),
            sh(10),
            Text(
              ChangeDateLabel,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: b * 14,
                color: Colors.black,
              ),
            ),
            sh(20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: b * 90),
              child: AppButton(
                label: OkayLabel,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

changeDateDialog(BuildContext context) async {
  await showAnimatedDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (BuildContext context) {
      return ChangeDateDialog();
    },
    animationType: DialogTransitionType.fadeScale,
    curve: Curves.fastOutSlowIn,
    duration: Duration(milliseconds: 3),
  );
}
