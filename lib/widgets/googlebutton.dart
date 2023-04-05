import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    @required this.label,
    this.width,
    this.onPressed,
    this.isShadow,
    this.vertPad,
    this.height,
  });

  final String? label;
  final double? width;
  final bool? isShadow;
  final double? vertPad;
  final double? height;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: SizeConfig.screenWidth,
        height: height ?? h * 49,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: vertPad != null ? vertPad! : h * 16,
        ),
        decoration: BoxDecoration(
          color:primaryColor,
          borderRadius: BorderRadius.circular(b * 4),
          border: Border.all(color: Colors.grey)
        ),
        child: Container(
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset('assets/images/googleIcon'
                      '.png'
                    , height: h * 27,
                    width: b * 20,
                  ),
                ),
                Text(
                  label!.toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    fontSize: b * 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key, this.width}) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Container(
      width: SizeConfig.screenWidth,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: h * 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(b * 5),
      ),
      child: SpinKitCircle(
        color: secondaryColor,
        size: b * 20,
      ),
    );
  }
}
