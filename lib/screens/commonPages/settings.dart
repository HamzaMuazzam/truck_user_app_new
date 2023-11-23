import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/screens/commonPages/profile.dart';
import 'package:sultan_cab/utils/api_keys.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/changeLanguage.dart';
import 'package:sultan_cab/widgets/logoutDialog.dart';

import '../../auth_widget.dart';
import '../TruckBooking/navigation_screen.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;
    return Scaffold(
      appBar: Get.width < 700
          ? AppBar(
              title: Text(
                'Profile'.tr,
                style: TextStyle(
                  color: textColor,
                  fontSize: h * 12,
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    showLanguageChangeDialog(context);
                  },
                  child: Padding(
                    padding: getLocal() == "ar"
                        ? EdgeInsets.only(left: 15.0)
                        : EdgeInsets.only(right: 15.0),
                    child: Icon(Icons.language_outlined),
                  ),
                )
              ],
              centerTitle: true,
              backgroundColor: secondaryColor,
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
      body: SafeArea(
        child: Row(
          children: [
            if (Get.width > 700) Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 7,
              child: Column(children: [
                Expanded(
                  child: Container(
                    // color: Colors.white,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: b * 30),
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sh(50),
                          SettingsTile(
                            title: "Profile".tr.tr,
                            icon: 'profileIcon',
                            page: ProfileScreen(
                              isBooking: false,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: MaterialButton(
                              elevation: 0,
                              splashColor: Colors.transparent,
                              padding: EdgeInsets.zero,
                              highlightColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(h * 5),
                              ),
                              onPressed: () async {
                                bool confirmation =
                                    await dialogBoxLogout(context);

                                if (confirmation) {
                                  bool status = await Provider.of<AuthProvider>(
                                          context,
                                          listen: false)
                                      .logout();

                                  if (status) {
                                    Get.offAll(AuthWidget());
                                  }
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: h * 15),
                                decoration: BoxDecoration(
                                  border: Border.all(color: greyColor),
                                  borderRadius: BorderRadius.circular(h * 5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.logout_rounded,
                                        size: h * 16, color: secondaryColor),
                                    sw(5),
                                    Text(
                                      "Log Out".tr,
                                      style: TextStyle(
                                          fontSize: h * 12,
                                          fontWeight: FontWeight.w700,
                                          color: secondaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            if (Get.width > 700) Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final String icon;
  final dynamic page;
  final Widget? dialogBox;

  SettingsTile(
      {required this.title, required this.icon, this.page, this.dialogBox});

  @override
  Widget build(BuildContext context) {
    var h = SizeConfig.screenHeight / 900;
    var b = SizeConfig.screenWidth / 375;

    return MaterialButton(
      elevation: 0,
      splashColor: primaryColor,
      padding: EdgeInsets.zero,
      highlightColor: scaffoldColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(h * 4),
      ),
      onPressed: () {
        if (page != null)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        else if (dialogBox != null) {
          showDialog(
              context: context,
              builder: (context) {
                return dialogBox!;
              });
        } else if (title != "Rate the app".tr) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => NavigationScreen(),
            ),
            (route) => false,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: h * 18),
        decoration: BoxDecoration(
          color: phoneBoxBackground,
          borderRadius: BorderRadius.circular(h * 4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                sw(h * 10),
                SvgPicture.asset(
                  'assets/icons/${this.icon}.svg',
                  color: scaffoldColor,
                  height: h * 16,
                ),
                sw(22),
                Text(
                  this.title,
                  style: TextStyle(
                      fontSize: h * 14,
                      fontWeight: FontWeight.w700,
                      color: textColor),
                ),
              ],
            ),
            Padding(
              padding: getLocal() == "ar"
                  ? EdgeInsets.only(left: 8.0)
                  : EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
