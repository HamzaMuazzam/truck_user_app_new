import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/screens/commonPages/register.dart';
import 'package:sultan_cab/screens/staticPages/privacy_policy.dart';
import 'package:sultan_cab/screens/staticPages/tnc.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import '../../widgets/app_text_field.dart';

class VerifyPhoneScreen extends StatefulWidget {
  VerifyPhoneScreen({Key? key}) : super(key: key);

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final formKey = GlobalKey<FormState>();
  bool isPhVerify = false;
  bool terms = false;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: formKey,
        child: SafeArea(
          child: Consumer<AuthProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return LayoutBuilder(
                  builder: ((BuildContext context, BoxConstraints constraints) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: b * 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sh(30),
                        Center(
                          child: Image.asset(
                            'assets/images/joinUs.png',
                            height: h * 227,
                            width: b * 234,
                          ),
                        ),
                        sh(40),
                        Row(
                          children: [
                            if (Get.width > 700)
                              Expanded(flex: 2, child: Container()),
                            Expanded(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Log in",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Get.height / 20,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 0.65,
                                            // backgroundColor: primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  sh(30),
                                  AppTextField(
                                    label: EmailLabel,
                                    controller: authProvider.emailController,
                                    suffix: null,
                                    isVisibilty: null,
                                    validator: (value) {
                                      Pattern emailPattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex =
                                          new RegExp(emailPattern.toString());
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
                                    controller: authProvider.passwordController,
                                    error: false,
                                  ),
                                  sh(20),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            side: BorderSide(
                                                color: Color(0xffcccccc),
                                                width: h * 1),
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity:
                                                VisualDensity.compact,
                                            activeColor: Colors.black,
                                            checkColor: Colors.white,
                                            value: terms,
                                            onChanged: (v) {
                                              setState(() {
                                                terms = v!;
                                              });
                                            },
                                          ),
                                          sh(2),

                                          Expanded(
                                            child:
                                            Padding(
                                              padding: EdgeInsets.only
                                                (top:paddings()),
                                              child: RichText(

                                                  text: TextSpan(
                                                      style: TextStyle(
                                                        height: 1.6,
                                                        fontSize: h * 15,
                                                        color: Colors.white,

                                                      ),
                                                      children: [
                                                    TextSpan(text: AgreeLabel),
                                                    TextSpan(
                                                        text: TnCLabel,
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                  MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        TnCScreen(),
                                                                  ),
                                                                );
                                                              }),
                                                        TextSpan(text:   ' $AndLabel '),
                                                        TextSpan(
                                                            text:  PrivacyPolicyLabel
                                                                .toLowerCase() +
                                                                ".",
                                                            recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap = () {
                                                                Navigator.of(
                                                                    context)
                                                                    .push(
                                                                  MaterialPageRoute(
                                                                    builder: (_) =>
                                                                        PrivacyPolicyScreen(),
                                                                  ),
                                                                );
                                                              }),
                                                  ])),
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                  sh(20),
                                  Center(
                                    child: AppButton(
                                      label: LoginLabel,
                                      onPressed: () async {
                                        if (!terms) {
                                          AppConst.errorSnackBar(
                                              "Please Accept Terms & conditions");

                                          return;
                                        }
                                        authProvider.loginFormValidation();
                                        // Get.to(() => VerifyPhoneNumberScreen(
                                        //     phoneNumber: authProvider.phoneController.text));
                                      },
                                    ),
                                  ),
                                  sh(22),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child:
                                              Text("Don't have an account?")),
                                      Expanded(
                                        child: InkWell(
                                            onTap: () {
                                              authProvider
                                                  .gotoPage(RegisterScreen());
                                            },
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text('Register'))),
                                      ),
                                    ],
                                  ),
                                  // Center(child: Text('OR', style: TextStyle(color:
                                  // primaryColor),)),
                                  // sh(22),
                                  // Center(
                                  //   child: GoogleSignInButton(
                                  //     label: 'Login With Google',
                                  //     onPressed: () async {
                                  //       if (!terms) {
                                  //         AppConst.errorSnackBar("Please Accept Terms & conditions");
                                  //
                                  //         return;
                                  //       }
                                  //       await authProvider.signInWithGoogle();
                                  //     },
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            if (Get.width > 700)
                              Expanded(flex: 2, child: Container()),
                          ],
                        ),
                        SizedBox(height: 50,)
                      ],
                    ),
                  ),
                );
              }));
            },
          ),
        ),
      ),
    );
  }
  double paddings(){
    double widths=0.0;
    if(Get.width<1107 && Get.width>392)
      return 14.0;
    if(Get.width<392)
      return 30.0;
    return widths;
  }
}

extension PasswordValidator on String {
  bool isValidPassword() {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);
  }
}
