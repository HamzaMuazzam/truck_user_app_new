import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;

class PaymentServices {
  static Future createPaymentOrder() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/createPaymentOrder.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future verifyPayment() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/verifyPayment.json');
    final data = jsonDecode(jsondata);
    return data;
  }
}
