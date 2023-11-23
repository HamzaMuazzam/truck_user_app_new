import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  static LanguageController get to => Get.put(LanguageController());

  final _locale = ''.obs;

  String get locale => _locale.value;

  @override
  void onInit() {
    super.onInit();
    _locale.value = GetStorage().read('locale') ?? 'en';
  }

  Future<void> changeLocale(String newLocale) async {
    await GetStorage().write('locale', newLocale);
    _locale.value = newLocale;
    await Get.updateLocale(Locale(newLocale));
  }
}
