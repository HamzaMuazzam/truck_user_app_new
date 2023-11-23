import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/screens/commonPages/login.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';
import 'package:sultan_cab/widgets/app_widgets.dart';

import '../TruckBooking/navigation_screen.dart';

class RegisterWithPhoneScreen extends StatefulWidget {
  const RegisterWithPhoneScreen({Key? key}) : super(key: key);

  @override
  _RegisterWithPhoneScreenState createState() =>
      _RegisterWithPhoneScreenState();
}

class _RegisterWithPhoneScreenState extends State<RegisterWithPhoneScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthProvider? authProvider;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              sh(10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.only(left: b * 7),
                  width: b * 30,
                  height: b * 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc4c4c4).withOpacity(0.4),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: b * 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: b * 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sh(20),
                      Text(
                        "Register Your Account".tr,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: b * 24,
                          letterSpacing: 0.5,
                        ),
                      ),
                      sh(30),
                      Consumer<AuthProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return AppWidgets.dpImageFile(
                            xFile: authProvider!.xFile,
                            onTap: () async {
                              authProvider!.getDpImage();
                            },
                          );
                        },
                      ),
                      sh(20),
                      AppTextField(
                        label: "Full Name".tr,
                        controller: authProvider!.nameController,
                        suffix: null,
                        isVisibilty: null,
                        validator: (val) {
                          if (authProvider!.nameController.text.trim() == "")
                            return "* Field can't be empty".tr;
                          else
                            return null;
                        },
                      ),
                      sh(20),
                      AppTextField(
                        // readOnly: true,
                        label: "Phone Number".tr,
                        controller: authProvider!.phoneController,
                        maxLength: 13,
                        suffix: null,
                        isVisibilty: null,
                        inputType: TextInputType.number,
                        validator: (val) {
                          if (authProvider!.phoneController.text.trim() == "")
                            return "* Field can't be empty".tr;
                          else if (authProvider!.phoneController.text.length !=
                              13)
                            return "* Enter a valid number".tr;
                          else
                            return null;
                        },
                      ),
                      sh(20),
                      AppButton(
                        label: "Register",
                        onPressed: () async {
                          if (authProvider!.xFile == null) {
                            AppConst.infoSnackBar(
                                "Please Add Profile Image".tr);
                            return;
                          }

                          authProvider!.phoneController.text =
                              AppConst.arrangePhoneNumberFormat(
                                  authProvider!.phoneController.text)!;

                          Map<String, String> signUpFields = {
                            'name': authProvider!.nameController.text,
                            'loginId': authProvider!.phoneController.text,
                            'isSocialLogin': 'true',
                            'socialType': 'PHONE',
                            'isActive': 'true',
                            'userType': 'Rider'
                          };

                          bool result = await authProvider!.signUp(
                              fields: signUpFields,
                              files: authProvider!.xFile!.path);

                          if (result) {
                            authProvider!.disposeControllers();
                            Get.offAll(NavigationScreen());
                          }
                        },
                      ),
                      sh(15),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: b * 10),
                              height: 1,
                              color: Color(0xffe4e4e4),
                            ),
                          ),
                          Text(
                            "Login".tr.toUpperCase(),
                            style: TextStyle(
                              fontSize: b * 12,
                              color: Color(0xffe4e4e4),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: b * 10),
                              height: 1,
                              color: Color(0xffe4e4e4),
                            ),
                          ),
                        ],
                      ),
                      sh(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?".tr + " ",
                            style: TextStyle(
                              fontSize: b * 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Login".tr,
                              style: TextStyle(
                                fontSize: b * 14,
                                color: secondaryColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      sh(30),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
