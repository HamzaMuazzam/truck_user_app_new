import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sultan_cab/models/booking_history_model.dart';
import 'package:sultan_cab/models/booking_model.dart';
import 'package:sultan_cab/models/report_model.dart';
import 'package:sultan_cab/models/user_model.dart';
import 'package:sultan_cab/services/booking_services.dart';
import 'package:sultan_cab/services/payment_services.dart';
import 'package:sultan_cab/utils/strings.dart';

class BookingProvider extends ChangeNotifier {
  Booking _currentBooking = Booking(docType: 1);

  Booking get currentBooking => _currentBooking;

  List<BookingHistoryModel> _bookingHistory = [];
  List<BookingHistoryModel> get bookingHistory => [..._bookingHistory];

  Future<num> setAddressAndDistance(
      {@required String? pick,
      @required String? drop,
      @required LatLng? pickLatLng,
      @required LatLng? dropLatLong}) async {
    _currentBooking.pickUpAdd = pick ?? "";
    _currentBooking.dropOffAdd = drop ?? "";

    double kms = 100;
    _currentBooking.totalKms = (kms.ceil()) ~/ 1000;

    return (kms.ceil()) ~/ 1000;
  }

  Future<void> getFare(Booking booking) async {
    try {
      var res = await BookingServices.getFareServices();
      _currentBooking.pickup = booking.pickup;
      _currentBooking.dropOff = booking.dropOff;
      _currentBooking.typeID = booking.typeID;
      _currentBooking.modelId = booking.modelId;
      _currentBooking.billingType = booking.billingType;
      _currentBooking.pickupCity = booking.pickupCity;
      _currentBooking.dropCity = booking.dropCity;
      _currentBooking.vehicleID = booking.vehicleID;
      _currentBooking.per_day_charge = res['data']['per_day_charge'] ?? 0;
      _currentBooking.additional_hrs = res['data']['additional_hrs'] ?? 0;
      _currentBooking.per_hour_rate = res['data']['per_hour_rate'] ?? 0;
      _currentBooking.total_days = res['data']['total_days'] ?? 0;
      _currentBooking.pickup_charge = res['data']['pickup_charge'] ?? 0;
      _currentBooking.dropoff_charge = res['data']['dropoff_charge'] ?? 0;

      _currentBooking.package = res['data']['package'] ?? '';
      _currentBooking.securityFee = res['data']['security_fee'] ?? 0;
      _currentBooking.fare = res['data']['fare'] ?? 0;
      _currentBooking.kmCharge = res['data']['km_charge'] ?? 0;
      _currentBooking.subtotal = res['data']['subtotal'] ?? 0;
      _currentBooking.total = res['data']['total'] ?? 0;
      _currentBooking.discount = res['data']['discount'] ?? 0;
      _currentBooking.discountId = res['data']['discount_id'] ?? "";
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> setFile(int fileCode, List<File?> doc) async {
    _currentBooking.docType = fileCode < 2 ? 1 : 0;
    if (fileCode == 0) {
      _currentBooking.aadaar = doc;
    } else if (fileCode == 1) {
      _currentBooking.driveLic = doc;
    } else if (fileCode == 2) {
      _currentBooking.overseasLic = doc;
    } else if (fileCode == 3) {
      _currentBooking.intlLic = doc;
    } else if (fileCode == 4) {
      _currentBooking.passport = doc;
    }
  }

  Future<void> setDocType(int type) async {
    _currentBooking.docType = type;
  }

  Future<void> bookSelfDrive(Userinfo user, String paymentMethod, String coPassengerNo) async {
    try {
      _currentBooking.total = _currentBooking.total! - _currentBooking.discount!;
      final req = await BookingServices.bookServices();

      print(req['data']['order_id']);
      _currentBooking.bookingID = req['data']['order_id'];
      print("Success");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> clearBooking() async {
    _currentBooking = Booking(docType: 1);
  }

  Future<void> getBookingHistory() async {
    try {
      final res = await BookingServices.getBookingHistory();

      List<BookingHistoryModel> _items = [];

      res['data'].forEach((ele) {
        _items.add(BookingHistoryModel.fromJson(ele));
      });

      _bookingHistory = _items;

      print("Success");
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> applyCoupon({@required String? couponCode}) async {
    try {
      final res = await BookingServices.applyCoupns();

      final data = res['data'];

      _currentBooking.discountId = data['coupon_id'] ?? -1;
      _currentBooking.discount = data['discount_amount'] ?? 0;
      _currentBooking.discountType = data['discount'] ?? "";

      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future createPayment(String bookID, String uid) async {
    try {
      final res = await PaymentServices.createPaymentOrder();

      return res['data']['order_id'];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }



  Future<void> cancelBooking(int bookingID) async {
    try {
      await BookingServices.cancelBooking();

      bookingHistory.where((element) {
        if (element.bookingId == bookingID)
          return true;
        else
          return false;
      });
      int index = bookingHistory.indexWhere((element) {
        if (element.bookingId == bookingID)
          return true;
        else
          return false;
      });

      bookingHistory[index].rideStatus = CancelledLabel;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }


  Future<void> updateBooking(
      {required String bookingID,
      required String pickupDateTime,
      required String dropoffDateTime,
      required String pickupCity,
      required String dropoffCity,
      required String pickAdd,
      required String dropAdd}) async {
    try {
      await BookingServices.updateBooking();

      int index = bookingHistory.indexWhere((element) {
        if (element.bookingId == int.parse(bookingID))
          return true;
        else
          return false;
      });

      bookingHistory[index].pickupDate = pickupDateTime;
      bookingHistory[index].returnDate = dropoffDateTime;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future getTrackingID({required String orderID}) async {
    try {
      final ref = await BookingServices.getTrackingID();
      print("Tracking ID : " + ref['data']['tracking_id'].toString());
      return ref['data'];
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future getVehicleTrackDetails({required String trackID}) async {
    try {
      final ref = await BookingServices.getVehicleTrackDetails();

      final dataList = ref['data'];
      double lat = 28.7041;
      double long = 77.1025;

      dataList.forEach((element) {
        if (element['deviceId'].toString() == trackID) {
          lat = double.parse(element['latitude']);
          long = double.parse(element['longitude']);
        }
      });

      LatLng latLng = LatLng(lat, long);
      return latLng;
    } catch (e) {
      print(e);
      throw GenericError;
    }
  }

  Future<ReportModel?> getReportData() async {
    try {
      final res = await BookingServices.getReportData();

      ReportModel reportModel = ReportModel.fromJson(res['data']);
      return reportModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> sendReplyOnReport(
      {required int ticketID, required String reply, required int userID}) async {
    try {
      await BookingServices.sendReply();
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
