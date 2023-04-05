import 'dart:convert';

RIdeCancelModel rIdeCancelModelFromJson(String str) => RIdeCancelModel.fromJson(json.decode(str));

class RIdeCancelModel {
  RIdeCancelModel({
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
  DateTime? scheduledTime;
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

  factory RIdeCancelModel.fromJson(Map<String, dynamic> json) => RIdeCancelModel(
        id: json["id"],
        status: json["status"],
        startAddress: json["startAddress"],
        endAddress: json["endAddress"],
        startLat: json["startLat"].toDouble(),
        startLng: json["startLng"].toDouble(),
        endLat: json["endLat"].toDouble(),
        endLng: json["endLng"].toDouble(),
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
        scheduledTime: json["scheduledTime"] != null ? DateTime.parse(json["scheduledTime"]) : null,
        recurringCount: json["recurringCount"],
        isDiscountedRide: json["isDiscountedRide"],
        priceAfterDiscount: json["priceAfterDiscount"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        userId: json["userId"],
        boughtSubscriptionId: json["boughtSubscriptionId"],
        assignedTo: json["assignedTo"],
        cancelledBy: json["cancelledBy"],
        fairId: json["fairId"],
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
        "completedAt": completedAt?.toIso8601String(),
        "cancelledAt": cancelledAt?.toIso8601String(),
        "isMultiDestination": isMultiDestination,
        "isRecurring": isRecurring,
        "isScheduled": isScheduled,
        "isRecurringActive": isRecurringActive,
        "scheduledTime": scheduledTime?.toIso8601String(),
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
      };
}
