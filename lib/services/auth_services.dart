import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class AuthServices {
  static Future loginServices() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/profile.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future<void> sendOtpServices() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/sendOTP.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future<void> verifyOtpServices() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/verifyOTP.json');
    final data = jsonDecode(jsondata);
    return data;
  }
}
