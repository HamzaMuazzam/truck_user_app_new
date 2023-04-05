import 'dart:convert';

BidAcceptModel bidAcceptModelFromJson(String str) => BidAcceptModel.fromJson(json.decode(str));

String bidAcceptModelToJson(BidAcceptModel data) => json.encode(data.toJson());

class BidAcceptModel {
  BidAcceptModel({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  Data? data;

  factory BidAcceptModel.fromJson(Map<String, dynamic> json) => BidAcceptModel(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
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
    this.requestData,
    this.bidData,
    this.riderData,
    this.driverData,
    this.multiDestinations,

  });

  RequestData? requestData;
  BidData? bidData;
  RiderData? riderData;
  DriverData? driverData;
  List<dynamic>? multiDestinations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requestData:json["requestData"]!=null? RequestData.fromJson(json["requestData"]):null,
    bidData:json["bidData"]!=null? BidData.fromJson(json["bidData"]):null,
        riderData:json["riderData"]!=null? RiderData.fromJson(json["riderData"]):null,
        driverData:json["driverData"]!=null? DriverData.fromJson(json["driverData"]):null,
        multiDestinations:json["multiDestinations"]!=null? List<dynamic>.from(json["multiDestinations"].map((x) => x)):null,
      );

  Map<String, dynamic> toJson() => {
        "requestData": requestData?.toJson(),
        "bidData": bidData,
        "riderData": riderData?.toJson(),
        "multiDestinations":
            multiDestinations != null ? List<dynamic>.from(multiDestinations!.map((x) => x)) : null,
      };
}
class BidData {
  BidData({
    this.id,
    this.bidAmount,
    this.status,
    this.lat,
    this.lng,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.requestId,
  });

  int ?id;
  int? bidAmount;
  String? status;
  double ?lat;
  double? lng;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int ?userId;
  int? requestId;

  factory BidData.fromJson(Map<String, dynamic> json) => BidData(
    id: json["id"],
    bidAmount: json["bidAmount"],
    status: json["status"],
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
    createdAt:json["createdAt"]!=null? DateTime.parse(json["createdAt"]):null,
    updatedAt: json["updatedAt"]!=null?DateTime.parse(json["updatedAt"]):null,
    userId: json["userId"],
    requestId: json["requestId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bidAmount": bidAmount,
    "status": status,
    "lat": lat,
    "lng": lng,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userId": userId,
    "requestId": requestId,
  };
}

class RequestData {
  RequestData({
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
  dynamic boughtSubscription;

  factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
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
        "acceptedAt": acceptedAt?.toIso8601String(),
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
        "bought_subscription": boughtSubscription,
      };
}

class RiderData {
  RiderData({
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

  factory RiderData.fromJson(Map<String, dynamic> json) => RiderData(
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

class DriverData {
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
  DateTime? createdAt;
  DateTime? updatedAt;

  DriverData({
    this.id,
    this.name,
    this.profileImage,
    this.loginId,
    this.mobileNumber,
    this.createdAt,
    this.isBlocked,
    this.isActive,
    this.isSocialLogin,
    this.isSuspended,
    this.password,
    this.socialType,
    this.updatedAt,
    this.userType,
  });
  factory DriverData.fromJson(Map<String, dynamic> json) => DriverData(
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
