// To parse this JSON data, do
//
//     final getAllOrdersResponse = getAllOrdersResponseFromJson(jsonString);

import 'dart:convert';

List<GetAllOrdersResponse> getAllOrdersResponseFromJson(String str) => List<GetAllOrdersResponse>.from(json.decode(str).map((x) => GetAllOrdersResponse.fromJson(x)));

String getAllOrdersResponseToJson(List<GetAllOrdersResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllOrdersResponse {
  GetAllOrdersResponse({
    this.id,
    this.orderId,
    this.orderDetails,
    this.truckTypeId,
    this.truckDetails,
    this.truckDriverId,
    this.truckDriver,
    this.noOfTruck,
    this.totalFare,
    this.inProgress,
    this.isAccepted,
    this.isCanceled,
    this.isInProcess,
    this.isDelievered,
    this.delieveredTime,
    this.isLoaded,
    this.loadedTime,
    this.cancelationReason,
    this.isPaid,
  });

  dynamic id;
  dynamic orderId;
  OrderDetails? orderDetails;
  dynamic truckTypeId;
  dynamic truckDetails;
  dynamic truckDriverId;
  TruckDriver? truckDriver;
  dynamic noOfTruck;
  double? totalFare;
  bool? inProgress;
  bool? isAccepted;
  bool? isCanceled;
  bool? isInProcess;
  bool? isDelievered;
  dynamic delieveredTime;
  bool? isLoaded;
  bool? isPaid;
  dynamic loadedTime;
  dynamic cancelationReason;

  factory GetAllOrdersResponse.fromJson(Map<String, dynamic> json) => GetAllOrdersResponse(
    id: json["id"],
    orderId: json["orderId"],
    orderDetails: json["orderDetails"] == null ? null : OrderDetails.fromJson(json["orderDetails"]),
    truckTypeId: json["truckTypeId"],
    truckDetails: json["truckDetails"],
    truckDriverId: json["truckDriverId"],
    truckDriver: json["truckDriver"] == null ? null : TruckDriver.fromJson(json["truckDriver"]),
    noOfTruck: json["noOfTruck"],
    totalFare: json["totalFare"],
    inProgress: json["inProgress"],
    isPaid: json["isPaid"],
    isAccepted: json["isAccepted"],
    isCanceled: json["isCanceled"],
    isInProcess: json["isInProcess"],
    isDelievered: json["isDelievered"],
    delieveredTime: json["delieveredTime"],
    isLoaded: json["isLoaded"],
    loadedTime: json["loadedTime"],
    cancelationReason: json["cancelationReason"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderId": orderId,
    "orderDetails": orderDetails?.toJson(),
    "truckTypeId": truckTypeId,
    "truckDetails": truckDetails,
    "truckDriverId": truckDriverId,
    "truckDriver": truckDriver?.toJson(),
    "noOfTruck": noOfTruck,
    "isPaid": isPaid,
    "totalFare": totalFare,
    "inProgress": inProgress,
    "isAccepted": isAccepted,
    "isCanceled": isCanceled,
    "isInProcess": isInProcess,
    "isDelievered": isDelievered,
    "delieveredTime": delieveredTime,
    "isLoaded": isLoaded,
    "loadedTime": loadedTime,
    "cancelationReason": cancelationReason,
  };
}

class OrderDetails {
  OrderDetails({
    this.orderId,
    this.title,
    this.pickUpLat,
    this.pickUpLng,
    this.pickUpAddress,
    this.pickUpLink,
    this.dropOffLink,
    this.dropOffLng,
    this.dropOffLat,
    this.dropOffAddress,
    this.isNotificationSent,
    this.contact,
    this.createdDate,
    this.userId,
    this.distance,
    this.pickUpCity,
    this.dropOffCity,
    this.user,
    this.tuckId,
    this.truckDriver,
    this.isAccepted,
    this.isCanceled,
    this.cancelationReason,
    this.isInProcess,
    this.isDelievered,
    this.delieveredTime,
    this.isLoaded,
    this.loadedTime,
  });

  dynamic orderId;
  String? title;
  String? pickUpLat;
  String? pickUpLng;
  String? pickUpAddress;
  String? pickUpLink;
  String? dropOffLink;
  String? dropOffLng;
  String? dropOffLat;
  String? dropOffAddress;
  bool? isNotificationSent;
  String? contact;
  DateTime? createdDate;
  dynamic userId;
  String? distance;
  String? pickUpCity;
  String? dropOffCity;
  User? user;
  dynamic tuckId;
  dynamic truckDriver;
  bool? isAccepted;
  bool? isCanceled;
  dynamic cancelationReason;
  bool? isInProcess;
  bool? isDelievered;
  dynamic delieveredTime;
  bool? isLoaded;
  dynamic loadedTime;

  factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
    orderId: json["orderId"],
    title: json["title"],
    pickUpLat: json["pickUpLat"],
    pickUpLng: json["pickUpLng"],
    pickUpAddress: json["pickUpAddress"],
    pickUpLink: json["pickUpLink"],
    dropOffLink: json["dropOffLink"],
    dropOffLng: json["dropOffLng"],
    dropOffLat: json["dropOffLat"],
    dropOffAddress: json["dropOffAddress"],
    isNotificationSent: json["isNotificationSent"],
    contact: json["contact"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    userId: json["userId"],
    distance: json["distance"],
    pickUpCity: json["pickUpCity"],
    dropOffCity: json["dropOffCity"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    tuckId: json["tuckId"],
    truckDriver: json["truckDriver"],
    isAccepted: json["isAccepted"],
    isCanceled: json["isCanceled"],
    cancelationReason: json["cancelationReason"],
    isInProcess: json["isInProcess"],
    isDelievered: json["isDelievered"],
    delieveredTime: json["delieveredTime"],
    isLoaded: json["isLoaded"],
    loadedTime: json["loadedTime"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "title": title,
    "pickUpLat": pickUpLat,
    "pickUpLng": pickUpLng,
    "pickUpAddress": pickUpAddress,
    "pickUpLink": pickUpLink,
    "dropOffLink": dropOffLink,
    "dropOffLng": dropOffLng,
    "dropOffLat": dropOffLat,
    "dropOffAddress": dropOffAddress,
    "isNotificationSent": isNotificationSent,
    "contact": contact,
    "createdDate": createdDate?.toIso8601String(),
    "userId": userId,
    "distance": distance,
    "pickUpCity": pickUpCity,
    "dropOffCity": dropOffCity,
    "user": user?.toJson(),
    "tuckId": tuckId,
    "truckDriver": truckDriver,
    "isAccepted": isAccepted,
    "isCanceled": isCanceled,
    "cancelationReason": cancelationReason,
    "isInProcess": isInProcess,
    "isDelievered": isDelievered,
    "delieveredTime": delieveredTime,
    "isLoaded": isLoaded,
    "loadedTime": loadedTime,
  };
}

class User {
  User({
    this.name,
    this.created,
    this.verificationToken,
    this.resetToken,
    this.resetTokenExpires,
    this.companyContact,
    this.companyCr,
    this.userRoles,
    this.userLogins,
    this.userClaims,
    this.userTokens,
    this.refreshTokens,
    this.id,
    this.userName,
    this.normalizedUserName,
    this.email,
    this.normalizedEmail,
    this.emailConfirmed,
    this.passwordHash,
    this.securityStamp,
    this.concurrencyStamp,
    this.phoneNumber,
    this.phoneNumberConfirmed,
    this.twoFactorEnabled,
    this.lockoutEnd,
    this.lockoutEnabled,
    this.accessFailedCount,
  });

  String? name;
  DateTime? created;
  String? verificationToken;
  dynamic resetToken;
  dynamic resetTokenExpires;
  String? companyContact;
  dynamic companyCr;
  List<dynamic>? userRoles;
  List<dynamic>? userLogins;
  List<dynamic>? userClaims;
  List<dynamic>? userTokens;
  List<dynamic>? refreshTokens;
  dynamic id;
  String? userName;
  String? normalizedUserName;
  String? email;
  String? normalizedEmail;
  bool? emailConfirmed;
  String? passwordHash;
  String? securityStamp;
  String? concurrencyStamp;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  dynamic lockoutEnd;
  bool? lockoutEnabled;
  dynamic accessFailedCount;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    created: json["created"] == null ? null : DateTime.parse(json["created"]),
    verificationToken: json["verificationToken"],
    resetToken: json["resetToken"],
    resetTokenExpires: json["resetTokenExpires"],
    companyContact: json["companyContact"],
    companyCr: json["companyCR"],
    userRoles: json["userRoles"] == null ? [] : List<dynamic>.from(json["userRoles"]!.map((x) => x)),
    userLogins: json["userLogins"] == null ? [] : List<dynamic>.from(json["userLogins"]!.map((x) => x)),
    userClaims: json["userClaims"] == null ? [] : List<dynamic>.from(json["userClaims"]!.map((x) => x)),
    userTokens: json["userTokens"] == null ? [] : List<dynamic>.from(json["userTokens"]!.map((x) => x)),
    refreshTokens: json["refreshTokens"] == null ? [] : List<dynamic>.from(json["refreshTokens"]!.map((x) => x)),
    id: json["id"],
    userName: json["userName"],
    normalizedUserName: json["normalizedUserName"],
    email: json["email"],
    normalizedEmail: json["normalizedEmail"],
    emailConfirmed: json["emailConfirmed"],
    passwordHash: json["passwordHash"],
    securityStamp: json["securityStamp"],
    concurrencyStamp: json["concurrencyStamp"],
    phoneNumber: json["phoneNumber"],
    phoneNumberConfirmed: json["phoneNumberConfirmed"],
    twoFactorEnabled: json["twoFactorEnabled"],
    lockoutEnd: json["lockoutEnd"],
    lockoutEnabled: json["lockoutEnabled"],
    accessFailedCount: json["accessFailedCount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "created": created?.toIso8601String(),
    "verificationToken": verificationToken,
    "resetToken": resetToken,
    "resetTokenExpires": resetTokenExpires,
    "companyContact": companyContact,
    "companyCR": companyCr,
    "userRoles": userRoles == null ? [] : List<dynamic>.from(userRoles!.map((x) => x)),
    "userLogins": userLogins == null ? [] : List<dynamic>.from(userLogins!.map((x) => x)),
    "userClaims": userClaims == null ? [] : List<dynamic>.from(userClaims!.map((x) => x)),
    "userTokens": userTokens == null ? [] : List<dynamic>.from(userTokens!.map((x) => x)),
    "refreshTokens": refreshTokens == null ? [] : List<dynamic>.from(refreshTokens!.map((x) => x)),
    "id": id,
    "userName": userName,
    "normalizedUserName": normalizedUserName,
    "email": email,
    "normalizedEmail": normalizedEmail,
    "emailConfirmed": emailConfirmed,
    "passwordHash": passwordHash,
    "securityStamp": securityStamp,
    "concurrencyStamp": concurrencyStamp,
    "phoneNumber": phoneNumber,
    "phoneNumberConfirmed": phoneNumberConfirmed,
    "twoFactorEnabled": twoFactorEnabled,
    "lockoutEnd": lockoutEnd,
    "lockoutEnabled": lockoutEnabled,
    "accessFailedCount": accessFailedCount,
  };
}

class TruckDriver {
  TruckDriver({
    this.tdId,
    this.name,
    this.iqamaNo,
    this.drivingLicenseNo,
    this.address,
    this.city,
    this.truckIsthimarah,
    this.contact,
    this.createdDate,
    this.truckDetails,
    this.truckTypeId,
    this.isOccupied,
  });

  dynamic tdId;
  String? name;
  String? iqamaNo;
  String? drivingLicenseNo;
  String? address;
  String? city;
  String? truckIsthimarah;
  String? contact;
  DateTime? createdDate;
  TruckDetails? truckDetails;
  dynamic truckTypeId;
  bool? isOccupied;

  factory TruckDriver.fromJson(Map<String, dynamic> json) => TruckDriver(
    tdId: json["tdId"],
    name: json["name"],
    iqamaNo: json["iqamaNo"],
    drivingLicenseNo: json["drivingLicenseNo"],
    address: json["address"],
    city: json["city"],
    truckIsthimarah: json["truckIsthimarah"],
    contact: json["contact"],
    createdDate: json["createdDate"] == null ? null : DateTime.parse(json["createdDate"]),
    truckDetails: json["truckDetails"] == null ? null : TruckDetails.fromJson(json["truckDetails"]),
    truckTypeId: json["truckTypeId"],
    isOccupied: json["isOccupied"],
  );

  Map<String, dynamic> toJson() => {
    "tdId": tdId,
    "name": name,
    "iqamaNo": iqamaNo,
    "drivingLicenseNo": drivingLicenseNo,
    "address": address,
    "city": city,
    "truckIsthimarah": truckIsthimarah,
    "contact": contact,
    "createdDate": createdDate?.toIso8601String(),
    "truckDetails": truckDetails?.toJson(),
    "truckTypeId": truckTypeId,
    "isOccupied": isOccupied,
  };
}

class TruckDetails {
  TruckDetails({
    this.id,
    this.farePerKm,
    this.truckName,
    this.truckType,
  });

  dynamic id;
  dynamic farePerKm;
  String? truckName;
  String? truckType;

  factory TruckDetails.fromJson(Map<String, dynamic> json) => TruckDetails(
    id: json["id"],
    farePerKm: json["farePerKM"],
    truckName: json["truckName"],
    truckType: json["truckType"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "farePerKM": farePerKm,
    "truckName": truckName,
    "truckType": truckType,
  };
}
