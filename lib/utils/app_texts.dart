import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';

class AppBarText extends StatelessWidget {
  const AppBarText({
    Key? key,
    @required this.txt,
    this.icon,
    this.isBackButton,
    @required this.actionIcon,
    this.fun,
  }) : super(key: key);

  final String? txt;
  final String? icon;
  final bool? isBackButton;
  final String? actionIcon;
  final Function()? fun;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return Container(
      decoration: BoxDecoration(
color: Colors.transparent,
        gradient: buttonGradient,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isBackButton!
              ? InkWell(
                  onTap: () {
                    if (fun == null) {
                      Navigator.pop(context);
                    } else {
                      fun!;
                      print('back');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: h * 22,
                      horizontal: b * 20,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: h * 18,
                      color: secondaryColor,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: h * 22,
                    horizontal: b * 20,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: h * 18,
                    color: Colors.transparent,
                  ),
                ),
          Spacer(),
          Text(
            txt!,
            style: TextStyle(
              fontSize: h * 20,
              fontWeight: FontWeight.w700,
              color: secondaryColor,
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
