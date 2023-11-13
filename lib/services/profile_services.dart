import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get_utils/get_utils.dart';

class ProfileServices {
  static Future getNationalityServices() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/nationality.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future getProfileData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/profile2.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future updateProfile() async {
    return "Profile updated successfully!".tr;
  }
}
