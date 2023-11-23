import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../languages/LanguageController.dart';
import '../languages/RestartWidget.dart';

class LanguageChangeDialog extends StatelessWidget {
  LanguageChangeDialog({super.key});
  final languageController = LanguageController.to;
  @override
  Widget build(BuildContext context) {
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
                onChanged: onChange),
          ),
          ListTile(
            title: Text('Arabic'.tr),
            leading: Radio(
                value: 'ar',
                groupValue: languageController.locale,
                onChanged: onChange),
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

  onChange(value) async {
    await languageController.changeLocale(value);
    RestartWidget.restartApp(Get.context!);
    Get.back();
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
