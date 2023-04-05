class LocalTaxiFare {
  int? statuscode;
  Body? body;
  String? message;

  LocalTaxiFare({this.statuscode, this.body, this.message});

  LocalTaxiFare.fromJson(Map<String, dynamic> json) {
    statuscode = json['statuscode'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statuscode'] = this.statuscode;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Body {
  String? vehicleTypeId;
  String? vehicleType;
  double? totalKmJourney;
  String? fareApplied;
  int? excessKm;
  int? standardFarePerKm;
  int? baseFare;
  double? additonalFare;
  double? subTotalFare;
  String? discountApplicable;
  String? typeOfOffer;
  String? discountType;
  int? discountValue;
  double? maximumDiscount;
  double? totalDiscount;
  double? totalFare;

  Body(
      {this.vehicleTypeId,
      this.vehicleType,
      this.totalKmJourney,
      this.fareApplied,
      this.excessKm,
      this.standardFarePerKm,
      this.baseFare,
      this.additonalFare,
      this.subTotalFare,
      this.discountApplicable,
      this.typeOfOffer,
      this.discountType,
      this.discountValue,
      this.maximumDiscount,
      this.totalDiscount,
      this.totalFare});

  Body.fromJson(Map<String, dynamic> json) {
    vehicleTypeId = json['vehicleTypeId'];
    vehicleType = json['vehicleType'];
    totalKmJourney = json['totalKmJourney'];
    fareApplied = json['fareApplied'];
    excessKm = json['excessKm'];
    standardFarePerKm = json['standardFarePerKm'];
    baseFare = json['baseFare'];
    additonalFare = json['additonalFare'];
    subTotalFare = json['subTotalFare'];
    discountApplicable = json['discountApplicable'];
    typeOfOffer = json['typeOfOffer'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    maximumDiscount = json['maximumDiscount'];
    totalDiscount = json['totalDiscount'];
    totalFare = json['totalFare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleTypeId'] = this.vehicleTypeId;
    data['vehicleType'] = this.vehicleType;
    data['totalKmJourney'] = this.totalKmJourney;
    data['fareApplied'] = this.fareApplied;
    data['excessKm'] = this.excessKm;
    data['standardFarePerKm'] = this.standardFarePerKm;
    data['baseFare'] = this.baseFare;
    data['additonalFare'] = this.additonalFare;
    data['subTotalFare'] = this.subTotalFare;
    data['discountApplicable'] = this.discountApplicable;
    data['typeOfOffer'] = this.typeOfOffer;
    data['discountType'] = this.discountType;
    data['discountValue'] = this.discountValue;
    data['maximumDiscount'] = this.maximumDiscount;
    data['totalDiscount'] = this.totalDiscount;
    data['totalFare'] = this.totalFare;
    return data;
  }
}
