import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:sultan_cab/models/coupon_model.dart';

class BookingServices {
  static Future getFareServices() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/limitedPrice.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future bookServices() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/saveSelfDrive.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future getBookingHistory() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/bookingHistory.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future applyCoupns() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/applyCoupon.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future cancelBooking() async {
    return "Booking cancelled successfully!";
  }

  static Future<DiscountModel?> getCoupons(String? typeId) async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/coupons.json');
    final data = jsonDecode(jsondata);
    return DiscountModel.fromJson(data);
  }

  static Future getBookingByID() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/viewBooking.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future updateBooking() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/updateBooking.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future rateBooking() async {
    return "Ratings and Review submitted successfully!";
  }

  static Future getReportData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/gerReport.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future sendReply() async {
    return "Reply has been sent successfully!";
  }

  static Future getTrackingID() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/getTrackingID.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future getVehicleTrackDetails() async {
    return "Success";
  }
}
