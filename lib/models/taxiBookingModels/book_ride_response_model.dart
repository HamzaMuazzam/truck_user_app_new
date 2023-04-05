import 'dart:convert';

BookARideResponseModel bookARideResponseModelFromJson(String str) =>
    BookARideResponseModel.fromJson(json.decode(str));

String bookARideResponseModelToJson(BookARideResponseModel data) => json.encode(data.toJson());

class BookARideResponseModel {
  BookARideResponseModel({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  Data? data;

  factory BookARideResponseModel.fromJson(Map<String, dynamic> json) => BookARideResponseModel(
        error: json["error"] ?? null,
        errorCode: json["errorCode"] ?? null,
        message: json["message"] ?? null,
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.fairValue,
    this.request,
    this.originalRequest,
    this.recurringData,
  });

  String? fairValue;
  Request? request;
  OriginalRequest? originalRequest;
  List<dynamic>? recurringData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        fairValue: json["fairValue"],
        request: Request.fromJson(json["request"]),
        originalRequest: OriginalRequest.fromJson(json["originalRequest"]),
        recurringData: List<dynamic>.from(json["recurringData"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fairValue": fairValue,
        "request": request?.toJson(),
        "originalRequest": originalRequest?.toJson(),
        "recurringData": List<dynamic>.from(recurringData!.map((x) => x)),
      };
}

class OriginalRequest {
  OriginalRequest({
    this.vehicleTypeId,
    this.estimatedTime,
    this.distanceKm,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
    this.fairId,
    this.fairValue,
    this.startAddress,
    this.endAddress,
    this.userId,
  });

  String? vehicleTypeId;
  String? estimatedTime;
  String? distanceKm;
  String? startLat;
  String? startLng;
  String? endLat;
  String? endLng;
  String? fairId;
  String? fairValue;
  String? startAddress;
  String? endAddress;
  int? userId;

  factory OriginalRequest.fromJson(Map<String, dynamic> json) => OriginalRequest(
        vehicleTypeId: json["vehicleTypeId"],
        estimatedTime: json["estimatedTime"],
        distanceKm: json["distanceKM"],
        startLat: json["startLat"],
        startLng: json["startLng"],
        endLat: json["endLat"],
        endLng: json["endLng"],
        fairId: json["FairId"],
        fairValue: json["fairValue"],
        startAddress: json["startAddress"],
        endAddress: json["endAddress"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "vehicleTypeId": vehicleTypeId,
        "estimatedTime": estimatedTime,
        "distanceKM": distanceKm,
        "startLat": startLat,
        "startLng": startLng,
        "endLat": endLat,
        "endLng": endLng,
        "FairId": fairId,
        "fairValue": fairValue,
        "startAddress": startAddress,
        "endAddress": endAddress,
        "userId": userId,
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
    this.fair,
    this.boughtSubscription,
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
  dynamic acceptedAt;
  dynamic arrivedAt;
  dynamic startedAt;
  dynamic completedAt;
  dynamic cancelledAt;
  bool? isMultiDestination;
  bool? isRecurring;
  bool? isScheduled;
  bool? isRecurringActive;
  dynamic scheduledTime;
  int? recurringCount;
  bool? isDiscountedRide;
  dynamic priceAfterDiscount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  dynamic boughtSubscriptionId;
  dynamic assignedTo;
  dynamic cancelledBy;
  int? fairId;
  User? user;
  Fair? fair;
  dynamic boughtSubscription;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        id: json["id"],
        status: json["status"],
        startAddress: json["startAddress"],
        endAddress: json["endAddress"],
        startLat: json["startLat"] != null ? json["startLat"].toDouble() : null,
        startLng: json["startLng"]?.toDouble(),
        endLat: json["endLat"]?.toDouble(),
        endLng: json["endLng"]?.toDouble(),
        distanceKm: json["distanceKM"],
        acceptedAt: json["acceptedAt"],
        arrivedAt: json["arrivedAt"],
        startedAt: json["startedAt"],
        completedAt: json["completedAt"],
        cancelledAt: json["cancelledAt"],
        isMultiDestination: json["isMultiDestination"],
        isRecurring: json["isRecurring"],
        isScheduled: json["isScheduled"],
        isRecurringActive: json["isRecurringActive"],
        scheduledTime: json["scheduledTime"],
        recurringCount: json["recurringCount"],
        isDiscountedRide: json["isDiscountedRide"],
        priceAfterDiscount: json["priceAfterDiscount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        boughtSubscriptionId: json["boughtSubscriptionId"],
        assignedTo: json["assignedTo"],
        cancelledBy: json["cancelledBy"],
        fairId: json["fairId"],
        user: User.fromJson(json["user"]),
        fair: Fair.fromJson(json["fair"]),
        boughtSubscription: json["bought_subscription"],
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
        "acceptedAt": acceptedAt,
        "arrivedAt": arrivedAt,
        "startedAt": startedAt,
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
        "fair": fair?.toJson(),
        "bought_subscription": boughtSubscription,
      };
}

class Fair {
  Fair({
    this.id,
    this.ratePerKm,
    this.waitingCharges,
    this.isActive,
    this.minFairPercentage,
    this.maxFairPercentage,
    this.cancellationCharges,
    this.createdAt,
    this.updatedAt,
    this.vehicleTypeId,
    this.userId,
  });

  int? id;
  int? ratePerKm;
  int? waitingCharges;
  bool? isActive;
  int? minFairPercentage;
  int? maxFairPercentage;
  int? cancellationCharges;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? vehicleTypeId;
  dynamic userId;

  factory Fair.fromJson(Map<String, dynamic> json) => Fair(
        id: json["id"],
        ratePerKm: json["ratePerKM"],
        waitingCharges: json["waitingCharges"],
        isActive: json["isActive"],
        minFairPercentage: json["minFairPercentage"],
        maxFairPercentage: json["maxFairPercentage"],
        cancellationCharges: json["cancellationCharges"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        vehicleTypeId: json["vehicleTypeId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ratePerKM": ratePerKm,
        "waitingCharges": waitingCharges,
        "isActive": isActive,
        "minFairPercentage": minFairPercentage,
        "maxFairPercentage": maxFairPercentage,
        "cancellationCharges": cancellationCharges,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "vehicleTypeId": vehicleTypeId,
        "userId": userId,
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
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
