import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/screens/TruckBooking/RequestDetailsScreenWeb.dart';
import 'package:sultan_cab/screens/TruckBooking/VehicleChooseScreenWeb.dart';
import 'package:sultan_cab/screens/commonPages/register.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';
import 'package:sultan_cab/widgets/web_header.dart';
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

  _checkStates() async {
    await 0.delay();
    bool _user =
        Provider.of<AuthProvider>(Get.context!, listen: false).checkUser();
    if (!_user) {
      Navigator.of(Get.context!).pushReplacement(
        MaterialPageRoute(
          builder: (_) => VerifyPhoneScreen(),
        ),
      );
    } else {
      Navigator.of(Get.context!).pushReplacement(
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
        body: kIsWeb
            ?
        // RequestDetailsScreenWeb()
        GetStartedWeb()
            : Container(
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
                        Image.asset('assets/logo/trucking-logo.png',
                            height: Get.height),
                      ],
                    ),
                    Align(
                      alignment: Alignment(0, 0.85),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: InkWell(
                          onTap: _checkStates,
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
                                    color: greyColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
    );
  }
}

class GetStartedWeb extends StatefulWidget {
  const GetStartedWeb({Key? key}) : super(key: key);

  @override
  State<GetStartedWeb> createState() => _GetStartedWebState();
}

class _GetStartedWebState extends State<GetStartedWeb> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greybackColor,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: Image.asset("assets/images/truck_bg_web.png")),
          Container(
            height: Get.height,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: Get.height,
                    width: Get.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/logo/trucking-logo.png",
                                height: 250,
                              ),
                              Text(
                                "Affordable truck service",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30),
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc odio in et, lectus sit lorem id integer.\n",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: isLogin
                                  ? [
                                      AppTextField(
                                        label: EmailLabel,
                                        controller:
                                            authProvider.emailController,
                                        suffix: null,
                                        isVisibilty: null,
                                        validator: (value) {
                                          Pattern emailPattern =
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                          RegExp regex = new RegExp(
                                              emailPattern.toString());
                                          if (value!.isEmpty) {
                                            return FieldEmptyError;
                                          } else if ((!regex
                                              .hasMatch(value.trim()))) {
                                            return ValidEmailLabel;
                                          } else
                                            return null;
                                        },
                                      ),
                                      sh(20),
                                      AppTextFieldPassword(
                                        label: 'Enter Password',
                                        controller:
                                            authProvider.passwordController,
                                        error: false,
                                      ),
                                      sh(20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  "Don't have an account?")),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  // authProvider
                                                  //     .gotoPage(RegisterScreen());
                                                },
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                        onTap: () {
                                                          isLogin = false;
                                                          setState(() {});
                                                        },
                                                        child:
                                                            Text('Register')))),
                                          ),
                                        ],
                                      ),
                                      sh(20),
                                      Center(
                                        child: AppButton(
                                          label: LoginLabel,
                                          onPressed: () async {
                                            authProvider.loginFormValidation();
                                          },
                                        ),
                                      ),
                                    ]
                                  : [
                                      Column(
                                        children: listRegister(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Text("Have an account?")),
                                          Expanded(
                                            child: InkWell(
                                                onTap: () {
                                                  // authProvider
                                                  //     .gotoPage(RegisterScreen());
                                                },
                                                child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                        onTap: () {
                                                          isLogin = true;
                                                          setState(() {});
                                                        },
                                                        child: Text('Login')))),
                                          ),
                                        ],
                                      ),
                                      sh(40),
                                    ],
                            ),
                          ),
                        )),
                        SizedBox(
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
