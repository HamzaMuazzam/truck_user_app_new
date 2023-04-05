import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sultan_cab/screens/commonPages/login.dart';
import 'package:sultan_cab/utils/app_texts.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';

class ActivateEmailScreen extends StatefulWidget {
  final String? token;
  final String? email;
  ActivateEmailScreen({Key? key, required this.token, required this.email}) : super(key: key);

  @override
  _ActivateEmailScreenState createState() => _ActivateEmailScreenState();
}

class _ActivateEmailScreenState extends State<ActivateEmailScreen> {
  Future<int>? activateEmail;
  var h, b;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    h = SizeConfig.screenHeight / 812;
    b = SizeConfig.screenWidth / 375;

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: buttonGradient),
          child: Column(
            children: [
              AppBarText(
                txt: ActivateEmailLbl,
                icon: 'assets/icons/setting.svg',
                isBackButton: false,
                actionIcon: null,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: b * 24, vertical: h * 12),
                  decoration: BoxDecoration(
                    boxShadow: boxShadow2,
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: b * 30, vertical: h * 30),
                        child: Image.asset(
                          'assets/images/activate_email_illus.png',
                        ),
                      ),
                      FutureBuilder(
                        future: activateEmail,
                        builder: (context, AsyncSnapshot<int> snap) {
                          if (snap.connectionState == ConnectionState.done) {
                            if (snap.data == 1)
                              return onSuccessMsg();
                            else
                              return onErrorMsg();
                          } else
                            return onProcessMsg();
                        },
                      ),
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

  Widget onSuccessMsg() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.done,
              color: Colors.green,
            ),
            sw(5),
            Text(
              ActivateEmailTitle,
              style: TextStyle(fontSize: h * 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        sh(50),
        AppButton(
          label: ContinueLabel,
          width: b * 120,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (_) => LoginScreen(
                        fromRoot: false,
                      )),
              (route) => false,
            );
          },
        )
      ],
    );
  }

  Widget onErrorMsg() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            sw(5),
            Text(
              ActivationFailed,
              style: TextStyle(fontSize: h * 14, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        sh(50),
        AppButton(
          label: ContinueLabel,
          width: b * 120,
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => LoginScreen(
                  fromRoot: false,
                ),
              ),
              (route) => false,
            );
          },
        )
      ],
    );
  }

  Widget onProcessMsg() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          ActivatingAccountLabel,
          style: TextStyle(
            fontSize: b * 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        sh(h * 20),
        SpinKitCircle(
          color: primaryColor,
          size: b * 20,
        )
      ],
    );
  }
}
