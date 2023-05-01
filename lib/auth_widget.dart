import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'screens/TruckBooking/navigation_screen.dart';
import 'screens/commonPages/phone_verify.dart';

class AuthWidget extends StatefulWidget {
  AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  void initState() {
    super.initState();
  }

  _checkStates() {
    bool _user =  Provider.of<AuthProvider>(context, listen: false).checkUser();
    if (!_user) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => VerifyPhoneScreen(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => NavigationScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset("assets/images/splash_bg.png").image,
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo/trucking-logo.png',height:Get.height),

            ],
          ),
          Align(
            alignment: Alignment(0, 0.85),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap:_checkStates,
                child: Container(
                  height: 55,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: greyColor, fontWeight: FontWeight.bold,
                      fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
