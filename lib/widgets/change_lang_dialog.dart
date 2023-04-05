import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';

class ChangeLangDialog extends StatefulWidget {
  const ChangeLangDialog({Key? key}) : super(key: key);

  @override
  _ChangeLangDialogState createState() => _ChangeLangDialogState();
}

class _ChangeLangDialogState extends State<ChangeLangDialog> {
  final languageMap = {
    'en': 'English',
    'pt': 'Portuguese',
  };

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var b = SizeConfig.screenWidth / 375;
    var h = SizeConfig.screenHeight / 812;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: b * 15),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(b * 10),
      ),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: b * 20, vertical: h * 20),
              child: Row(
                children: [
                  Text(
                    changeLanguage,
                    style: TextStyle(
                      fontSize: b * 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Container(
              color: borderColor,
              height: h * 2,
              width: SizeConfig.screenWidth,
            ),
            Column(
              children: [
                ...context.supportedLocales.map((e) => ListTile(
                      title: Text(
                        languageMap[e.toLanguageTag()]!,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: context.locale.toLanguageTag() == e.toLanguageTag()
                          ? Icon(
                              Icons.check,
                              color: secondaryColor,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          context.setLocale(e);
                        });
                        if (Platform.isAndroid) {
                          SystemNavigator.pop();
                        } else if (Platform.isIOS) {
                          exit(0);
                        }
                      },
                    )),
                Text(
                  RestartApp,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: b * 10.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                sh(15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
