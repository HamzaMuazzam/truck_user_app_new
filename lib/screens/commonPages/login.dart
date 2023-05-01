import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/screens/commonPages/phone_verify.dart';
import 'package:sultan_cab/screens/commonPages/register_with_phone.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/utils/const.dart';

import '../TruckBooking/navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool? fromRoot;

  LoginScreen({Key? key, this.fromRoot}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isError = false;
  bool terms = false;
  late AuthProvider authProvider;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
   var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SizedBox(
        width: Get.width > 700 ?
          Get.width/2  :Get.width ,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                sh(100),
                Text(
                  "Join us via phone Number",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                sh(20),
                sh(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: MaterialButton(
                    onPressed: () async {
                      AppConst.startProgress();
                      if (_formKey.currentState!.validate()) {
                        bool status = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return VerifyPhoneScreen();
                            },
                          ),
                        );
                        AppConst.stopProgress();

                        if (status) {
                          bool result = await authProvider.signInWithMobile();
                          if (result) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (BuildContext context) {
                              return NavigationScreen();
                            }));
                          } else if (!result) {
                            await AppConst.infoSnackBar("User Not Exist, Please create account");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return RegisterWithPhoneScreen();
                                },
                              ),
                            );
                          }
                        }
                      }
                    },
                    padding: EdgeInsets.symmetric(vertical: h * 15),
                    elevation: 0,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    color: greenColor,
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
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
