import 'dart:convert';

StartRideModel startRideModelFromJson(String str) => StartRideModel.fromJson(json.decode(str));

String startRideModelToJson(StartRideModel data) => json.encode(data.toJson());

class StartRideModel {
  StartRideModel({
    this.request,
    this.driver,
  });

  Request? request;
  Driver? driver;

  factory StartRideModel.fromJson(Map<String, dynamic> json) => StartRideModel(
        request: json["request"] != null ? Request.fromJson(json["request"]) : null,
        driver: json["driver"] != null ? Driver.fromJson(json["driver"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "request": request?.toJson(),
        "driver": driver?.toJson(),
      };
}

class Driver {
  Driver({
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

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
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

class Request {
  Request({
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
  String? scheduledTime;
  int? recurringCount;
  bool? isDiscountedRide;
  DateTime? priceAfterDiscount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? boughtSubscriptionId;
  int? assignedTo;
  int? cancelledBy;
  int? fairId;
  Driver? user;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
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
        arrivedAt: json["arrivedAt"] != null ? DateTime.parse(json["arrivedAt"]) : null,
        startedAt: json["startedAt"] != null ? DateTime.parse(json["startedAt"]) : null,
        completedAt: json["completedAt"] != null ? DateTime.parse(json["completedAt"]) : null,
        cancelledAt: json["cancelledAt"] != null ? DateTime.parse(json["cancelledAt"]) : null,
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
        cancelledBy: json["cancelledBy"],
        fairId: json["fairId"],
        user: json["user"] != null ? Driver.fromJson(json["user"]) : null,
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
        "arrivedAt": arrivedAt?.toIso8601String(),
        "startedAt": startedAt?.toIso8601String(),
        "completedAt": completedAt,
        "cancelledAt": cancelledAt,
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
        "cancelledBy": cancelledBy,
        "fairId": fairId,
        "user": user?.toJson(),
      };
}
