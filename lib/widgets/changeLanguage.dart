import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

import '../../languages/LanguageController.dart';

class LanguageChangeDialog extends StatelessWidget {
  const LanguageChangeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final languageController = LanguageController.to;
    return AlertDialog(
      title: Text('Change Language'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('English'.tr),
            leading: Radio(
              value: 'en',
              groupValue: languageController.locale,
              onChanged: (value) {
                languageController.changeLocale("en");
                Get.back();
              },
            ),
          ),
          ListTile(
            title: Text('Arabic'.tr),
            leading: Radio(
              value: 'ar',
              groupValue: languageController.locale,
              onChanged: (value) {
                languageController.changeLocale("ar");
                Phoenix.rebirth(context);
                // Get.offAll(AuthWidget());
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'.tr),
        ),
      ],
    );
  }
}

void showLanguageChangeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return LanguageChangeDialog();
    },
  );
}
