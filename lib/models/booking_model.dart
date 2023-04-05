import 'dart:io';

class Booking {
  dynamic bookingID;
  dynamic package;
  dynamic securityFee;
  dynamic fare;
  dynamic kmCharge;
  dynamic subtotal;
  dynamic total;
  dynamic discount;
  dynamic discountType;
  dynamic discountId;
  dynamic pickup;
  dynamic dropOff;
  dynamic typeID;
  dynamic vehicleID;
  dynamic billingType;
  dynamic totalKms;
  dynamic modelId;
  int? docType;
  List<File?>? aadaar;
  List<File?>? driveLic;
  List<File?>? overseasLic;
  List<File?>? intlLic;
  List<File?>? passport;
  int? pickupCity;
  int? dropCity;
  dynamic pickUpAdd;
  dynamic dropOffAdd;
  // ignore: non_constant_identifier_names
  dynamic per_day_charge;
  // ignore: non_constant_identifier_names
  dynamic additional_hrs;
  // ignore: non_constant_identifier_names
  dynamic per_hour_rate;
  // ignore: non_constant_identifier_names
  dynamic total_days;
  // ignore: non_constant_identifier_names
  dynamic pickup_charge;
  // ignore: non_constant_identifier_names
  dynamic dropoff_charge;

  Booking(
      // ignore: non_constant_identifier_names
      {this.per_day_charge,
      // ignore: non_constant_identifier_names
      this.additional_hrs,
      // ignore: non_constant_identifier_names
      this.per_hour_rate,
      // ignore: non_constant_identifier_names
      this.total_days,
      // ignore: non_constant_identifier_names
      this.pickup_charge,
      // ignore: non_constant_identifier_names
      this.dropoff_charge,
      this.package,
      this.securityFee,
      this.fare,
      this.kmCharge,
      this.subtotal,
      this.total,
      this.discount,
      this.discountId,
      this.billingType,
      this.dropOff,
      this.modelId,
      this.pickup,
      this.totalKms,
      this.typeID,
      this.vehicleID,
      this.docType,
      this.aadaar,
      this.driveLic,
      this.overseasLic,
      this.intlLic,
      this.passport,
      this.pickupCity,
      this.dropCity,
      this.discountType,
      this.pickUpAdd,
      this.dropOffAdd});

  Booking.fromJson(Map<dynamic, dynamic> json) {
    package = json['package'];
    securityFee = json['security_fee'];
    fare = json['fare'];
    kmCharge = json['km_charge'];
    subtotal = json['subtotal'];
    total = json['total'];
    discount = json['discount'];
    discountId = json['discount_id'];
    per_day_charge = json['per_day_charge'];
    additional_hrs = json['additional_hrs'];
    per_hour_rate = json['per_hour_rate'];
    total_days = json['total_days'];
    pickup_charge = json['pickup_charge'];
    dropoff_charge = json['dropoff_charge'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['package'] = this.package;
    data['security_fee'] = this.securityFee;
    data['fare'] = this.fare;
    data['km_charge'] = this.kmCharge;
    data['subtotal'] = this.subtotal;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['discount_id'] = this.discountId;

    data['per_day_charge'] = this.per_day_charge;
    data['additional_hrs'] = this.additional_hrs;
    data['per_hour_rate'] = this.per_hour_rate;
    data['total_days'] = this.total_days;
    data['pickup_charge'] = this.pickup_charge;
    data['dropoff_charge'] = this.dropoff_charge;

    return data;
  }
}
