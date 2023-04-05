import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/appBar.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_snackBar.dart';
import 'package:sultan_cab/widgets/app_text_field.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController messageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool isPressed = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // getData();
    super.initState();
  }

  // Future getData() async {
  //   final user = Provider.of<AuthProvider>(context, listen: false).user;
  //   if (user != null) {
  //     nameController.text = user.userName!;
  //     emailController.text = user.emailid!;
  //     phoneController.text = user.phone!;
  //   }
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return Scaffold(
      appBar: appBarCommon(context, h, b, ContactUsLabel),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: b * 30, right: b * 30),
              decoration: constBoxDecoration,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      sh(40),
                      AppTextField(
                        label: NameLabel,
                        controller: nameController,
                        suffix: null,
                        size: b * 12,
                        isVisibilty: null,
                        validator: (val) {
                          if (nameController.text.trim() == "")
                            return FieldEmptyError;
                          else
                            return null;
                        },
                      ),
                      sh(20),
                      AppTextField(
                        label: EnterEmail,
                        controller: emailController,
                        suffix: null,
                        size: b * 12,
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
                      AppTextField(
                        label: PhoneNoLabel,
                        controller: phoneController,
                        maxLength: 10,
                        suffix: Text(
                          "+91",
                          style: TextStyle(
                            fontSize: b * 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        size: b * 12,
                        isVisibilty: null,
                        inputType: TextInputType.number,
                        validator: (val) {
                          if (phoneController.text.trim() == "")
                            return FieldEmptyError;
                          else if (phoneController.text.length != 10)
                            return "* Enter a valid number";
                          else
                            return null;
                        },
                      ),
                      sh(20),
                      AppTextField(
                        label: MessageInquiryLabel,
                        controller: messageController,
                        suffix: null,
                        isVisibilty: null,
                        size: b * 12,
                        maxLines: 6,
                        minLines: 6,
                        vertPad: h * 13,
                        hint: WriteMessageLabel,
                      ),
                      sh(50),
                      isPressed
                          ? LoadingButton()
                          : AppButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();

                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isPressed = true;
                                  });

                                  if (messageController.text != '') {
                                    setState(() {
                                      isPressed = false;
                                    });

                                    appSnackBar(
                                      context: context,
                                      msg: SuccessfullyLabel,
                                      isError: false,
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    setState(() {
                                      isPressed = false;
                                    });
                                    appSnackBar(
                                      context: context,
                                      msg: WriteMsgToProceedLabel,
                                      isError: true,
                                    );
                                  }
                                }
                              },
                              label: SubmitLabel,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
