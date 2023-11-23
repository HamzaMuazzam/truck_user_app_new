import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/screens/commonPages/phone_verify.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';

import '../../plugins/intel_phone_field/intl_phone_field.dart';
import '../../widgets/app_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

var b = SizeConfig.screenWidth / 375;
var h = SizeConfig.screenHeight / 600;
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool isPwdVisible = false;
bool isConfVisible = false;

bool isError = false;
bool isError1 = false;

bool isMisMatch = false;

bool phoneVerified = false;

class _RegisterScreenState extends State<RegisterScreen> {
  Set<int> checks = {};
  Set<int> checks2 = {};
  String crNo = "";

  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                  if (Get.width > 700) Expanded(flex: 2, child: Container()),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: b * 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: listRegister()),
                      ),
                    ),
                  ),
                  if (Get.width > 700) Expanded(flex: 2, child: Container()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listRegister() {
    return [
      sh(20),
      Text(
        "Register Your Account".tr,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: h * 20,
          letterSpacing: 0.5,
        ),
      ),
      sh(30),
      Text(
        "Register Your Account".tr,
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
        label: "Full Name",
        controller: authProvider.nameController,
        suffix: null,
        isVisibilty: null,
        validator: (val) {
          if (authProvider.nameController.text.trim() == "")
            return "* Field can't be empty".tr;
          else
            return null;
        },
      ),
      sh(20),
      AppTextField(
        label: "Email",
        controller: authProvider.emailController,
        suffix: null,
        isVisibilty: null,
        validator: (value) {
          Pattern emailPattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regex = new RegExp(emailPattern.toString());
          if (value!.isEmpty) {
            return "* Field can't be empty".tr;
          } else if ((!regex.hasMatch(value.trim()))) {
            return "* Please enter a valid email id".tr;
          } else
            return null;
        },
      ),
      sh(20),
      AppTextFieldPassword(
        label: "Password".tr,
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
        label: "Confirm Password".tr,
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
        label: "Company CR".tr,
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
        //     return "* Field can't be empty".tr;
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
            return "* Field can't be empty".tr;
          else
            return null;
        },
      ),
      sh(30),
      Center(
        child: AppButton(
          label: "Register".tr,
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
