import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;

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
    return "Profile updated successfully!";
  }
}
