import 'dart:convert';

GetLastRideModel getLastRideModelFromJson(String str) {
  return GetLastRideModel.fromJson(json.decode(str));
}

String getLastRideModelToJson(GetLastRideModel data) {
  return json.encode(data.toJson());
}

class GetLastRideModel {
  GetLastRideModel({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  Data? data;

  factory GetLastRideModel.fromJson(Map<String, dynamic> json) => GetLastRideModel(
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
    this.scheduledTime,
    this.scheduledDay,
    this.rideRepeatCount,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.assignedTo,
    this.cancelledBy,
    this.fairId,
    this.fair,
    this.user,
    this.multiDestinations,
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
  DateTime? scheduledTime;
  DateTime? scheduledDay;
  int? rideRepeatCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  String? assignedTo;
  String? cancelledBy;
  int? fairId;
  Fair? fair;
  dynamic user;
  List<MultiDestination>? multiDestinations;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        status: json["status"],
        startAddress: json["startAddress"],
        endAddress: json["endAddress"],
        startLat: json["startLat"],
        startLng: json["startLng"],
        endLat: json["endLat"],
        endLng: json["endLng"],
        distanceKm: json["distanceKM"],
        acceptedAt: json["acceptedAt"],
        arrivedAt: json["arrivedAt"],
        startedAt: json["startedAt"],
        completedAt: json["completedAt"],
        cancelledAt: json["cancelledAt"],
        isMultiDestination: json["isMultiDestination"],
        isRecurring: json["isRecurring"],
        isScheduled: json["isScheduled"],
        scheduledTime: json["scheduledTime"],
        scheduledDay: json["scheduledDay"],
        rideRepeatCount: json["rideRepeatCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        assignedTo: json["assignedTo"],
        cancelledBy: json["cancelledBy"],
        fairId: json["fairId"],
        fair: Fair.fromJson(json["fair"]),
        user: json["user"],
        multiDestinations: List<MultiDestination>.from(
            json["multi_destinations"].map((x) => MultiDestination.fromJson(x))),
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
        "scheduledTime": scheduledTime,
        "scheduledDay": scheduledDay,
        "rideRepeatCount": rideRepeatCount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
        "assignedTo": assignedTo,
        "cancelledBy": cancelledBy,
        "fairId": fairId,
        "fair": fair?.toJson(),
        "user": user,
        "multi_destinations": multiDestinations != null
            ? List<dynamic>.from(multiDestinations!.map((x) => x.toJson()))
            : null,
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
  int? userId;

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
  int? lat;
  int? lng;
  String? estimatedTimeTill;
  String? estimatedFairTill;
  String? customWaitingTime;
  String? addressTill;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? requestId;

  factory MultiDestination.fromJson(Map<String, dynamic> json) => MultiDestination(
        id: json["id"],
        lat: json["lat"],
        lng: json["lng"],
        estimatedTimeTill: json["estimatedTimeTill"],
        estimatedFairTill: json["estimatedFairTill"],
        customWaitingTime: json["customWaitingTime"],
        addressTill: json["addressTill"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
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
