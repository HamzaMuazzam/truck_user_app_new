import 'package:flutter/widgets.dart';
import 'package:sultan_cab/services/booking_services.dart';

class TrackProvider extends ChangeNotifier {
  Future getPickDropAddress({required int bookingID}) async {
    try {
      final res = await BookingServices.getBookingByID();

      List<String> addr = [];

      addr.add(res['data'][0]['pickup_addr']);
      addr.add(res['data'][0]['dest_addr']);

      return addr;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
