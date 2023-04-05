import 'package:sultan_cab/models/vehicle_model.dart';

class BookingHistoryModel {
  int? bookingId;
  // ignore: non_constant_identifier_names
  int? is_reported;
  // ignore: non_constant_identifier_names
  int? is_rated;
  String? orderId;
  String? pickupDate;
  String? returnDate;
  String? billingType;
  String? rideStatus;
  String? totalAmount;
  String? paymentStatus;
  VehicleModel? vehicleDetails;

  BookingHistoryModel(
      {this.bookingId,
      this.orderId,
      // ignore: non_constant_identifier_names
      this.is_rated,
      // ignore: non_constant_identifier_names
      this.is_reported,
      this.pickupDate,
      this.returnDate,
      this.billingType,
      this.rideStatus,
      this.totalAmount,
      this.paymentStatus,
      this.vehicleDetails});

  BookingHistoryModel.fromJson(Map<String, dynamic> map) {
    bookingId = map['booking_id'];
    is_rated = map['is_rated'];
    is_reported = map['is_reported'];
    orderId = map['order_id'];
    pickupDate = map['pickup_date'];
    returnDate = map['return_date'];
    billingType = map['billing_type'];
    rideStatus = map['ride_status'];
    totalAmount = map['total_amount'];
    paymentStatus = map['payment_status'];
    vehicleDetails = VehicleModel.fromJson(map['vehicle_details']);
  }
}
