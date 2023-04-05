class BookingComplete {
  dynamic id;
  dynamic isRated;
  dynamic isReported;
  dynamic orderId;
  dynamic customer;
  dynamic customerContact;
  dynamic nationality;
  dynamic vehicle;
  dynamic pickupCity;
  dynamic dropoffCity;
  dynamic currentAddress;
  dynamic documentType;
  List<dynamic>? aadharCard;
  dynamic pickupDatetime;
  dynamic dropoffDatetime;
  dynamic pickupAddr;
  dynamic destAddr;
  dynamic billingType;
  dynamic bookingStatus;
  dynamic coPassangerContact;
  dynamic note;
  dynamic paymentStatus;
  dynamic amount;
  dynamic interface;
  dynamic paymentOption;
  List<dynamic>? drivingPermit;
  List<dynamic>? internationalLicense;
  List<dynamic>? passport;
  List<dynamic>? domesticLicense;
  // ignore: non_constant_identifier_names
  List<dynamic>? pickup_uploads;
  // ignore: non_constant_identifier_names
  List<dynamic>? dropoff_uploads;

  dynamic customerId;
  dynamic vehicleId;
  dynamic isPaid;
  dynamic typeId;
  dynamic modelId;
  dynamic totalKms;
  dynamic rentalDays;
  dynamic securityFee;
  dynamic amountPaid;
  dynamic extraCharges;
  dynamic driverNote;

  BookingComplete({
    this.id,
    this.orderId,
    this.isReported,
    this.isRated,
    this.customer,
    this.customerContact,
    this.currentAddress,
    this.nationality,
    this.vehicle,
    this.pickupCity,
    this.dropoffCity,
    this.documentType,
    this.internationalLicense,
    this.drivingPermit,
    this.passport,
    this.domesticLicense,
    this.aadharCard,
    this.pickupDatetime,
    this.dropoffDatetime,
    this.pickupAddr,
    this.destAddr,
    this.billingType,
    this.bookingStatus,
    this.coPassangerContact,
    this.note,
    this.paymentStatus,
    this.amount,
    this.customerId,
    this.vehicleId,
    this.isPaid,
    this.interface,
    this.typeId,
    this.modelId,
    this.totalKms,
    this.paymentOption,
    this.rentalDays,
    this.securityFee,
    this.amountPaid,
    this.extraCharges,
    this.driverNote,
    // ignore: non_constant_identifier_names
    this.dropoff_uploads,
    // ignore: non_constant_identifier_names
    this.pickup_uploads,
  });

  BookingComplete.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    isReported = json['is_reported'];
    isRated = json['is_rated'];
    customer = json['customer'];
    customerContact = json['customer_contact'];
    currentAddress = json['current_address'];
    nationality = json['nationality'];
    vehicle = json['vehicle'];
    pickupCity = json['pickup_city'];
    dropoffCity = json['dropoff_city'];
    documentType = json['document_type'];
    if (json['international_license'] != null) {
      internationalLicense = [];
      json['international_license'].forEach((v) {
        internationalLicense!.add(v);
      });
    }
    if (json['driving_permit'] != null) {
      drivingPermit = [];
      json['driving_permit'].forEach((v) {
        drivingPermit!.add(v);
      });
    }
    if (json['passport'] != null) {
      passport = [];
      json['passport'].forEach((v) {
        passport!.add(v);
      });
    }
    if (json['pickup_uploads'] != null) {
      pickup_uploads = [];
      json['pickup_uploads'].forEach((v) {
        pickup_uploads!.add(v);
      });
    }
    if (json['dropoff_uploads'] != null) {
      dropoff_uploads = [];
      json['dropoff_uploads'].forEach((v) {
        dropoff_uploads!.add(v);
      });
    }

    domesticLicense = json['domestic_license'].cast<String>();
    aadharCard = json['aadhar_card'];
    pickupDatetime = json['pickup_datetime'];
    dropoffDatetime = json['dropoff_datetime'];
    pickupAddr = json['pickup_addr'];
    destAddr = json['dest_addr'];
    billingType = json['billing_type'];
    bookingStatus = json['booking_status'];
    coPassangerContact = json['co_passanger_contact'];
    note = json['note'];
    paymentStatus = json['payment_status'];
    amount = json['amount'];
    customerId = json['customer_id'];
    vehicleId = json['vehicle_id'];
    isPaid = json['is_paid'];
    interface = json['interface'];
    typeId = json['type_id'];
    modelId = json['model_id'];
    totalKms = json['total_kms'];
    paymentOption = json['payment_option'];
    rentalDays = json['rental_days'];
    securityFee = json['security_fee'];
    amountPaid = json['amount_paid'];
    extraCharges = json['extra_charges'];
    driverNote = json['driver_note'];
  }
}
