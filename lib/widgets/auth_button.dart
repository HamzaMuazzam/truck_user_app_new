import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({Key? key, @required this.label, @required this.onPress, @required this.color})
      : super(key: key);

  final String? label;
  final void Function()? onPress;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return MaterialButton(
      elevation: 0,
      padding: EdgeInsets.zero,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(b * 5),
      ),
      onPressed: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: h * 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(b * 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              label != RegisterLabel ? Icons.login_rounded : Icons.person_add,
              color: Colors.white,
              size: b * 20,
            ),
            sw(5),
            Text(
              label!,
              style: TextStyle(
                color: Colors.white,
                fontSize: b * 14,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
