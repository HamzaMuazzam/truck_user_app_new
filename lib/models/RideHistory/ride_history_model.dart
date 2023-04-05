import 'dart:convert';

RideHistoryModel rideHistoryModelFromJson(String str) =>
    RideHistoryModel.fromJson(json.decode(str));

String rideHistoryModelToJson(RideHistoryModel data) => json.encode(data.toJson());

class RideHistoryModel {
  RideHistoryModel({
    required this.error,
    required this.errorCode,
    required this.message,
    this.data,
  });

  bool error;
  int? errorCode;
  String message;
  List<Datum>? data;

  factory RideHistoryModel.fromJson(Map<String, dynamic> json) => RideHistoryModel(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode,
        "message": message,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
      };
}

class Datum {
  Datum({
    this.id,
    this.status,
    this.startAddress,
    this.endAddress,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
    this.distanceKm,
    this.acceptedAt,
    this.arrivedAt,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
    this.isMultiDestination,
    this.isRecurring,
    this.isScheduled,
    this.isRecurringActive,
    this.scheduledTime,
    this.recurringCount,
    this.isDiscountedRide,
    this.priceAfterDiscount,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.boughtSubscriptionId,
    this.assignedTo,
    this.cancelledBy,
    this.fairId,
    this.multiDestinations,
    this.user,
  });

  int? id;
  String? status;
  String? startAddress;
  String? endAddress;
  double? startLat;
  double? startLng;
  double? endLat;
  double? endLng;
  int? distanceKm;
  DateTime? acceptedAt;
  DateTime? arrivedAt;
  DateTime? startedAt;
  DateTime? completedAt;
  DateTime? cancelledAt;
  bool? isMultiDestination;
  bool? isRecurring;
  bool? isScheduled;
  bool? isRecurringActive;
  dynamic scheduledTime;
  int? recurringCount;
  bool? isDiscountedRide;
  int? priceAfterDiscount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? boughtSubscriptionId;
  int? assignedTo;
  int? cancelledBy;
  int? fairId;
  List<MultiDestination>? multiDestinations;
  User? user;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        status: json["status"],
        startAddress: json["startAddress"],
        endAddress: json["endAddress"],
        startLat: json["startLat"] != null ? json["startLat"].toDouble() : null,
        startLng: json["startLng"] != null ? json["startLng"].toDouble() : null,
        endLat: json["endLat"] != null ? json["endLat"].toDouble() : null,
        endLng: json["endLng"] != null ? json["endLng"].toDouble() : null,
        distanceKm: json["distanceKM"],
        acceptedAt: json["acceptedAt"] != null ? DateTime.parse(json["acceptedAt"]) : null,
        arrivedAt: json["arrivedAt"] == null ? null : DateTime.parse(json["arrivedAt"]),
        startedAt: json["startedAt"] == null ? null : DateTime.parse(json["startedAt"]),
        completedAt: json["completedAt"] == null ? null : DateTime.parse(json["completedAt"]),
        cancelledAt: json["cancelledAt"] == null ? null : DateTime.parse(json["cancelledAt"]),
        isMultiDestination: json["isMultiDestination"],
        isRecurring: json["isRecurring"],
        isScheduled: json["isScheduled"],
        isRecurringActive: json["isRecurringActive"],
        scheduledTime: json["scheduledTime"],
        recurringCount: json["recurringCount"],
        isDiscountedRide: json["isDiscountedRide"],
        priceAfterDiscount: json["priceAfterDiscount"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        userId: json["userId"],
        boughtSubscriptionId: json["boughtSubscriptionId"],
        assignedTo: json["assignedTo"],
        cancelledBy: json["cancelledBy"] == null ? null : json["cancelledBy"],
        fairId: json["fairId"],
        multiDestinations: json["multi_destinations"] != null
            ? List<MultiDestination>.from(
                json["multi_destinations"].map((x) => MultiDestination.fromJson(x)))
            : null,
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "startAddress": startAddress,
        "endAddress": endAddress,
        "startLat": startLat,
        "startLng": startLng,
        "endLat": endLat,
        "endLng": endLng,
        "distanceKM": distanceKm,
        "acceptedAt": acceptedAt?.toIso8601String(),
        "arrivedAt": arrivedAt == null ? null : arrivedAt?.toIso8601String(),
        "startedAt": startedAt == null ? null : startedAt?.toIso8601String(),
        "completedAt": completedAt == null ? null : completedAt?.toIso8601String(),
        "cancelledAt": cancelledAt == null ? null : cancelledAt?.toIso8601String(),
        "isMultiDestination": isMultiDestination,
        "isRecurring": isRecurring,
        "isScheduled": isScheduled,
        "isRecurringActive": isRecurringActive,
        "scheduledTime": scheduledTime,
        "recurringCount": recurringCount,
        "isDiscountedRide": isDiscountedRide,
        "priceAfterDiscount": priceAfterDiscount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
        "boughtSubscriptionId": boughtSubscriptionId,
        "assignedTo": assignedTo,
        "cancelledBy": cancelledBy == null ? null : cancelledBy,
        "fairId": fairId,
        "multi_destinations": multiDestinations != null
            ? List<dynamic>.from(multiDestinations!.map((x) => x.toJson()))
            : null,
        "user": user?.toJson(),
      };
}

class MultiDestination {
  MultiDestination({
    this.id,
    this.lat,
    this.lng,
    this.estimatedTimeTill,
    this.estimatedFairTill,
    this.customWaitingTime,
    this.addressTill,
    this.createdAt,
    this.updatedAt,
    this.requestId,
  });

  int? id;
  double? lat;
  double? lng;
  String? estimatedTimeTill;
  String? estimatedFairTill;
  String? customWaitingTime;
  String? addressTill;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? requestId;

  factory MultiDestination.fromJson(Map<String, dynamic> json) => MultiDestination(
        id: json["id"],
        lat: json["lat"] != null ? json["lat"].toDouble() : null,
        lng: json["lng"] != null ? json["lng"].toDouble() : null,
        estimatedTimeTill: json["estimatedTimeTill"],
        estimatedFairTill: json["estimatedFairTill"],
        customWaitingTime: json["customWaitingTime"],
        addressTill: json["addressTill"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lng": lng,
        "estimatedTimeTill": estimatedTimeTill,
        "estimatedFairTill": estimatedFairTill,
        "customWaitingTime": customWaitingTime,
        "addressTill": addressTill,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "requestId": requestId,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.mobileNumber,
    this.loginId,
    this.password,
    this.isSocialLogin,
    this.socialType,
    this.profileImage,
    this.isActive,
    this.isBlocked,
    this.isSuspended,
    this.userType,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? mobileNumber;
  String? loginId;
  String? password;
  bool? isSocialLogin;
  String? socialType;
  String? profileImage;
  bool? isActive;
  bool? isBlocked;
  bool? isSuspended;
  String? userType;
  int? amount;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        mobileNumber: json["mobileNumber"],
        loginId: json["loginId"],
        password: json["password"],
        isSocialLogin: json["isSocialLogin"],
        socialType: json["socialType"],
        profileImage: json["profileImage"],
        isActive: json["isActive"],
        isBlocked: json["isBlocked"],
        isSuspended: json["isSuspended"],
        userType: json["userType"],
        amount: json["amount"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobileNumber": mobileNumber,
        "loginId": loginId,
        "password": password,
        "isSocialLogin": isSocialLogin,
        "socialType": socialType,
        "profileImage": profileImage,
        "isActive": isActive,
        "isBlocked": isBlocked,
        "isSuspended": isSuspended,
        "userType": userType,
        "amount": amount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
