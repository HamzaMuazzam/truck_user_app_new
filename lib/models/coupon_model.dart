class DiscountModel {
  String? success;
  String? message;
  List<Data>? data;

  DiscountModel({this.success, this.message, this.data});

  DiscountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? couponId;
  String? discountType;
  int? maxValue;
  String? couponCode;
  int? discountValue;
  String? discount;
  String? couponType;

  Data(
      {this.couponId,
      this.discountType,
      this.maxValue,
      this.couponCode,
      this.discountValue,
      this.discount,
      this.couponType});

  Data.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    discountType = json['discount_type'];
    maxValue = json['max_value'];
    couponCode = json['coupon_code'];
    discountValue = json['discount_value'];
    discount = json['discount'];
    couponType = json['coupon_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_id'] = this.couponId;
    data['discount_type'] = this.discountType;
    data['max_value'] = this.maxValue;
    data['coupon_code'] = this.couponCode;
    data['discount_value'] = this.discountValue;
    data['discount'] = this.discount;
    data['coupon_type'] = this.couponType;
    return data;
  }
}
