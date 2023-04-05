import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';
import 'package:provider/provider.dart';
import '../../plugins/intel_phone_field/intl_phone_field.dart';
import '../../widgets/app_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isPwdVisible = false;
  bool isConfVisible = false;

  bool isError = false;
  bool isError1 = false;

  bool isMisMatch = false;

  bool phoneVerified = false;

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 600;

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
                  padding: EdgeInsets.only(left: h * 7),
                  width: h * 30,
                  height: h * 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc4c4c4).withOpacity(0.4),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: h * 16,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  if(Get.width>700)
                    Expanded(
                        flex:2,
                        child: Container()),
                  Expanded(
                    flex:7,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: b * 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  labelText: 'Phone Number',

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
                                  authProvider.phoneController.text =
                                      phone.completeNumber;
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

                            ),
                            sh(20),
                            AppTextFieldPassword(
                              label: CnfmPasswordLabel,
                              isMisMatch: isMisMatch,
                              controller: authProvider.password2Controller,

                              error: isError1,

                            ),


                            sh(20),
                            AppTextField(
                              label: CompanyCR,
                              controller: authProvider.companyCR,
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
                              label: 'Company ContactNo',
                              controller: authProvider.companyContact,
                              suffix: null,
                              isVisibilty: null,
                              validator: (val) {
                                if (authProvider.nameController.text.trim() == "")
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
                                  await authProvider.registrationFormValidation();
                                },
                              ),
                            ),
                            sh(40),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if(Get.width>700)
                    Expanded(
                        flex:2,
                        child: Container()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
