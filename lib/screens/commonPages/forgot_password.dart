import 'package:flutter/material.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/utils/const.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isMisMatch = false;
  bool isError = false;
  bool isError1 = false;
  bool isError2 = false;

  late AuthProvider authProvider;
  bool status = false;
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: b * 28, vertical: h * 30),
          child: Consumer<AuthProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
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
                        ),
                      ),
                    ),
                    sh(15),
                    Center(
                      child: Image.asset(
                        'assets/images/forgot_illus_2.png',
                        height: h * 151,
                        width: b * 252,
                      ),
                    ),
                    sh(50),
                    Text(
                      ResetPasswordLabel,
                      style: TextStyle(
                        fontSize: b * 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    sh(30),
                    // AppTextField(
                    //   label: EnterRegisterEmail,
                    //   // controller: authProvider.emailController,
                    //   suffix: null,
                    //   isVisibilty: null,
                    //   validator: (value) {
                    //     Pattern emailPattern =
                    //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    //     RegExp regex = new RegExp(emailPattern.toString());
                    //     if (value!.isEmpty) {
                    //       return FieldEmptyError;
                    //     } else if ((!regex.hasMatch(value.trim()))) {
                    //       return ValidEmailLabel;
                    //     } else
                    //       return null;
                    //   },
                    // ),
                    sh(20),
                    if (authProvider.emailOtp != null)
                      // OTPTextField(
                      //   onCompleted: (pin) {
                      //     if (pin == authProvider.emailOtp) {
                      //       status = true;
                      //     } else {
                      //       AppConst.errorSnackBar("OTP mismatch");
                      //     }
                      //   },
                      //   width: MediaQuery.of(context).size.width * .9,
                      //   length: 6,
                      //   fieldWidth: 30,
                      //   fieldStyle: FieldStyle.underline,
                      // ),
                    sh(20),
                    if (status)
                      Column(
                        children: [
                          // AppTextFieldPassword(
                          //   label: NewPassword,
                          //   controller: authProvider.newPwdController,
                          //   isMisMatch: isMisMatch,
                          //   error: isError,
                          //   validator: (val) {
                          //     if (authProvider.newPwdController.text.trim() == "") {
                          //       setState(() {
                          //         isMisMatch = false;
                          //         isError = true;
                          //       });
                          //       return FieldEmptyError;
                          //     } else if (authProvider.confPwdController.text !=
                          //         authProvider.newPwdController.text) {
                          //       setState(() {
                          //         isMisMatch = true;
                          //         isError = true;
                          //       });
                          //       return PasswordMatchError;
                          //     } else {
                          //       setState(() {
                          //         isError = false;
                          //         isMisMatch = false;
                          //       });
                          //       return null;
                          //     }
                          //   },
                          // ),
                          sh(20),
                          // AppTextFieldPassword(
                          //   label: CnfmPasswordLabel,
                          //   isMisMatch: isMisMatch,
                          //   controller: authProvider.confPwdController,
                          //   error: isError1,
                          //   validator: (val) {
                          //     if (authProvider.confPwdController.text.trim() == "") {
                          //       setState(() {
                          //         isError1 = true;
                          //         isMisMatch = false;
                          //       });
                          //       return FieldEmptyError;
                          //     } else if (authProvider.confPwdController.text !=
                          //         authProvider.newPwdController.text) {
                          //       setState(() {
                          //         isMisMatch = true;
                          //         isError1 = true;
                          //       });
                          //       return PasswordMatchError;
                          //     } else {
                          //       setState(() {
                          //         isMisMatch = false;
                          //         isError1 = false;
                          //       });
                          //       return null;
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    // Center(
                    //   child: AppButton(
                    //     label: SubmitLabel,
                    //     onPressed: () async {
                    //       FocusScope.of(context).unfocus();
                    //       if (_formKey.currentState!.validate()) {
                    //         if (authProvider.emailOtp == null) {
                    //           await authProvider.sendEmailOtp();
                    //         } else {
                    //           bool status = await authProvider.resetForgetPassword();
                    //           if (status) {
                    //             this.status = false;
                    //             authProvider.emailOtp = null;
                    //             authProvider.disposeControllers();
                    //             setState(() {});
                    //             await AppConst.infoSnackBar("Please Login Now");
                    //             Navigator.pop(context);
                    //           }
                    //         }
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
