// To parse this JSON data, do
//
//     final tabPaymentDetails = tabPaymentDetailsFromJson(jsonString);

import 'dart:convert';

TabPaymentDetails tabPaymentDetailsFromJson(String str) => TabPaymentDetails.fromJson(json.decode(str));

String tabPaymentDetailsToJson(TabPaymentDetails data) => json.encode(data.toJson());

class TabPaymentDetails {
  String? tranRef;
  String? tranType;
  String? cartId;
  String? cartDescription;
  String? cartCurrency;
  String? cartAmount;
  String? tranCurrency;
  String? tranTotal;
  String? callback;
  dynamic tabPaymentDetailsReturn;
  String? redirectUrl;
  int? serviceId;
  int? profileId;
  int? merchantId;
  String? trace;

  TabPaymentDetails({
    this.tranRef,
    this.tranType,
    this.cartId,
    this.cartDescription,
    this.cartCurrency,
    this.cartAmount,
    this.tranCurrency,
    this.tranTotal,
    this.callback,
    this.tabPaymentDetailsReturn,
    this.redirectUrl,
    this.serviceId,
    this.profileId,
    this.merchantId,
    this.trace,
  });

  factory TabPaymentDetails.fromJson(Map<String, dynamic> json) => TabPaymentDetails(
    tranRef: json["tran_ref"],
    tranType: json["tran_type"],
    cartId: json["cart_id"],
    cartDescription: json["cart_description"],
    cartCurrency: json["cart_currency"],
    cartAmount: json["cart_amount"],
    tranCurrency: json["tran_currency"],
    tranTotal: json["tran_total"],
    callback: json["callback"],
    tabPaymentDetailsReturn: json["_return"],
    redirectUrl: json["redirect_url"],
    serviceId: json["serviceId"],
    profileId: json["profileId"],
    merchantId: json["merchantId"],
    trace: json["trace"],
  );

  Map<String, dynamic> toJson() => {
    "tran_ref": tranRef,
    "tran_type": tranType,
    "cart_id": cartId,
    "cart_description": cartDescription,
    "cart_currency": cartCurrency,
    "cart_amount": cartAmount,
    "tran_currency": tranCurrency,
    "tran_total": tranTotal,
    "callback": callback,
    "_return": tabPaymentDetailsReturn,
    "redirect_url": redirectUrl,
    "serviceId": serviceId,
    "profileId": profileId,
    "merchantId": merchantId,
    "trace": trace,
  };
}
