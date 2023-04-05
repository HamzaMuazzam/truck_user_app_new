import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_snackBar.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String token;
  ResetPasswordScreen({Key? key, required this.email, required this.token}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController newPwdController = TextEditingController();
  TextEditingController confPwdController = TextEditingController();

  bool isError = false;
  bool isError1 = false;

  bool isMisMatch = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: b * 30, vertical: b * 30),
          child: Form(
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
                    'assets/images/forgot_pass.png',
                    height: h * 165,
                    width: b * 181,
                  ),
                ),
                sh(34),
                Text(
                  ResetPasswordLabel,
                  style: TextStyle(
                    fontSize: b * 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                sh(30),
                AppTextFieldPassword(
                  label: NewPassword,
                  controller: newPwdController,
                  isMisMatch: isMisMatch,
                  error: isError,
                  validator: (val) {
                    if (newPwdController.text.trim() == "") {
                      isError = true;
                      setState(() {});
                      return FieldEmptyError;
                    } else if (confPwdController.text != newPwdController.text) {
                      setState(() {
                        isMisMatch = true;
                        isError = true;
                      });
                      return PasswordMatchError;
                    } else {
                      setState(() {
                        isError = false;
                      });
                      return null;
                    }
                  },
                ),
                sh(20),
                AppTextFieldPassword(
                  label: CnfmPasswordLabel,
                  isMisMatch: isMisMatch,
                  controller: confPwdController,
                  error: isError1,
                  validator: (val) {
                    if (confPwdController.text.trim() == "") {
                      setState(() {
                        isError1 = true;
                      });
                      return FieldEmptyError;
                    } else if (confPwdController.text != newPwdController.text) {
                      setState(() {
                        isMisMatch = true;
                        isError1 = true;
                      });
                      return PasswordMatchError;
                    } else {
                      setState(() {
                        isMisMatch = false;
                        isError1 = false;
                      });
                      return null;
                    }
                  },
                ),
                sh(20),
                AppButton(
                  label: SubmitLabel,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (!_formKey.currentState!.validate()) return;
                    if (newPwdController.text.trim().length < 6 ||
                        newPwdController.text.trim().length > 14) {
                      appSnackBar(
                        context: context,
                        msg: PasswordLengthErrorLabel,
                        isError: true,
                      );
                    } else {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
