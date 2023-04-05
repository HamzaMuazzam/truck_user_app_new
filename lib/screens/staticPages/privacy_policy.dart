import 'package:flutter/material.dart';
import 'package:sultan_cab/utils/app_texts.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: buttonGradient),
          child: Column(
            children: [
              AppBarText(
                txt: PrivacyPolicyLabel,
                icon: 'assets/icons/privacy_icon.svg',
                actionIcon: null,
                isBackButton: true,
              ),
              Expanded(
                child: Container(
                  decoration: constBoxDecoration,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: b * 30),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sh(42),
                        Text(
                          LastUpdate + ": 28th Nov 2021",
                          style: TextStyle(
                            fontSize: b * 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                          ),
                        ),
                        sh(25),
                        Text(
                          CompanyPrivacy,
                          style: TextStyle(
                            fontSize: b * 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                          ),
                        ),
                        sh(21),
                        Text(
                          DummyTnC,
                          style: TextStyle(
                            fontSize: b * 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
