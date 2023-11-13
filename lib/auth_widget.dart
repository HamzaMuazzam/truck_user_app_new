import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/plugins/intel_phone_field/intl_phone_field.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/screens/commonPages/register.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';

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
    _checkStates();
  }

  _checkStates() async {
    await 2.delay();
    bool _user =
        Provider.of<AuthProvider>(Get.context!, listen: false).checkUser();
    if (!_user) {
      if (!GetPlatform.isWeb) {
        Navigator.of(Get.context!).pushReplacement(
          MaterialPageRoute(
            builder: (_) => VerifyPhoneScreen(),
          ),
        );
      }
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
                  ],
                ),
              ));
  }
}

class GetStartedWeb extends StatefulWidget {
  const GetStartedWeb({Key? key}) : super(key: key);

  @override
  State<GetStartedWeb> createState() => _GetStartedWebState();
}

class _GetStartedWebState extends State<GetStartedWeb> {
  Set<int> checks = {};
  Set<int> checks2 = {};
  String crNo = "";

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
                                "Move your heavy load at the touch of a button!"
                                    .tr,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30),
                              ),
                              Text(
                                "An all-in-one truck aggregation platform developed to fulfill the needs of businesses, brokers, and fleet owners.\n"
                                    .tr,
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
                                        label: 'Enter Password'.tr,
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
                                                  "Don't have an account?".tr)),
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
                                                        child: Text(
                                                            'Register'.tr)))),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: listRegister(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child:
                                                  Text("Have an account?".tr)),
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
                                                        child:
                                                            Text('Login'.tr)))),
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

  List<Widget> listRegister() {
    return [
      sh(20),
      Text(
        CreateAccountLbl,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: h * 20,
          letterSpacing: 0.5,
        ),
      ),
      sh(30),
      Text(
        PersonalDetailsLabel,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: h * 15,
          letterSpacing: 0.5,
        ),
      ),
      sh(30),
      SizedBox(
        child: IntlPhoneField(
          // style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            // fillColor: primaryColor,

            filled: true,
            labelText: 'Phone Number'.tr,

            labelStyle: TextStyle(
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
            ),
          ),
          initialCountryCode: 'SA',

          onChanged: (phone) {
            authProvider.phoneController.text = phone.completeNumber;
          },
        ),
      ),
      sh(0),
      AppTextField(
        label: NameLabel,
        controller: authProvider.nameController,
        suffix: null,
        isVisibilty: null,
        validator: (val) {
          if (authProvider.nameController.text.trim() == "")
            return FieldEmptyError;
          else
            return null;
        },
      ),
      sh(20),
      AppTextField(
        label: EmailLabel,
        controller: authProvider.emailController,
        suffix: null,
        isVisibilty: null,
        validator: (value) {
          Pattern emailPattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(emailPattern.toString());
          if (value!.isEmpty) {
            return FieldEmptyError;
          } else if ((!regex.hasMatch(value.trim()))) {
            return ValidEmailLabel;
          } else
            return null;
        },
      ),
      sh(20),
      AppTextFieldPassword(
        label: PasswordLabel,
        controller: authProvider.passwordController,
        isMisMatch: isMisMatch,
        error: isError,
        validator: (value) {
          // if(isPasswordCompliant(value)){
          //   return null;
          // }else{
          //   return "Password must contain digit, capital, small and special character.";
          // }
        },
        onChanged: (text) {
          checks = isPasswordCompliant(text);

          setState(() {});
        },
      ),
      checks.contains(0)
          ? Text(
              "~Password must be greater than 8.".tr,
              style: TextStyle(
                  color: checks.contains(0) ? Colors.red : Colors.grey),
            )
          : Container(),
      checks.contains(1)
          ? Text("~Must contain capital letter".tr,
              style: TextStyle(
                  color: checks.contains(1) ? Colors.red : Colors.grey))
          : Container(),
      checks.contains(2)
          ? Text(
              "~Must contain number".tr,
              style: TextStyle(
                  color: checks.contains(2) ? Colors.red : Colors.grey),
            )
          : Container(),
      checks.contains(3)
          ? Text(
              "~Must contain lower case letter".tr,
              style: TextStyle(
                  color: checks.contains(3) ? Colors.red : Colors.grey),
            )
          : Container(),
      checks.contains(4)
          ? Text("~Must contain special character.".tr,
              style: TextStyle(
                  color: checks.contains(4) ? Colors.red : Colors.grey))
          : Container(),
      sh(20),
      AppTextFieldPassword(
        label: CnfmPasswordLabel,
        isMisMatch: isMisMatch,
        controller: authProvider.password2Controller,
        error: isError1,
        validator: (value) {
          // if(isPasswordCompliant(value)){
          //   return null;
          // }else{
          //   return "Password must contain digit, capital, small and special character.";
          // }
        },
        onChanged: (text) {
          checks2 = isPasswordCompliant(text);

          setState(() {});
        },
      ),
      checks2.contains(0)
          ? Text(
              "~Password must be greater than 8.".tr,
              style: TextStyle(
                  color: checks2.contains(0) ? Colors.red : Colors.grey),
            )
          : Container(),
      checks2.contains(1)
          ? Text("~Must contain capital letter".tr,
              style: TextStyle(
                  color: checks2.contains(1) ? Colors.red : Colors.grey))
          : Container(),
      checks2.contains(2)
          ? Text(
              "~Must contain number".tr,
              style: TextStyle(
                  color: checks2.contains(2) ? Colors.red : Colors.grey),
            )
          : Container(),
      checks2.contains(3)
          ? Text(
              "~Must contain lower case letter".tr,
              style: TextStyle(
                  color: checks2.contains(3) ? Colors.red : Colors.grey),
            )
          : Container(),
      checks2.contains(4)
          ? Text("~Must contain special character.".tr,
              style: TextStyle(
                  color: checks2.contains(4) ? Colors.red : Colors.grey))
          : Container(),
      sh(20),
      AppTextField(
        label: CompanyCR,
        inputType: TextInputType.number,
        controller: authProvider.companyCR,
        suffix: null,
        isVisibilty: null,
        maxLength: 10,
        onChange: (text) {
          crNo = text;
          setState(() {});
        },
        // validator: (val) {
        //   if (authProvider.companyCR.text.trim() == "")
        //     return FieldEmptyError;
        //   else if (authProvider.companyCR.text.length<10){
        //     return "CR can't be less then 10 digits";
        //   }
        //   else if (authProvider.companyCR.text.length>10){
        //     return "CR can't be more then 10 digits";
        //   }
        //   else
        //     return null;
        // },
      ),
      sh(5),
      if (crNo.isEmpty)
        Text(
          "CR number can't be empty".tr,
          style: TextStyle(color: Colors.red),
        ),
      if (crNo.length < 10)
        Text(
          "CR number can't be less than 10".tr,
          style: TextStyle(color: Colors.red),
        ),
      if (crNo.length > 10)
        Text(
          "CR number can't be greater than 10".tr,
          style: TextStyle(color: Colors.red),
        ),
      sh(20),
      AppTextField(
        label: 'Company ContactNo'.tr,
        controller: authProvider.companyContact,
        suffix: null,
        isVisibilty: null,
        validator: (val) {
          if (authProvider.companyContact.text.trim() == "")
            return FieldEmptyError;
          else
            return null;
        },
      ),
      sh(30),
      Center(
        child: AppButton(
          label: RegisterLabel,
          onPressed: () async {
            if (checks.isNotEmpty || checks2.isNotEmpty) return;
            await authProvider.registrationFormValidation();
          },
        ),
      ),
      sh(40),
    ];
  }
}
