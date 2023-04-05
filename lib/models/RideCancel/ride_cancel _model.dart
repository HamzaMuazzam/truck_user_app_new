import 'dart:convert';

RideCancelModel rIdeCancelModelFromJson(String str) => RideCancelModel.fromJson(json.decode(str));

String? rIdeCancelModelToJson(RideCancelModel data) => json.encode(data.toJson());

class RideCancelModel {
  RideCancelModel({
    this.id,
    this.status,
    this.startAddress,
    this.endAddress,
    this.startLat,
    this.startLng,
    this.endLat,
    this.endLng,
    this.distanceKm,
    this.isMultiDestination,
    this.isRecurring,
    this.isScheduled,
    this.isRecurringActive,
    this.recurringCount,
    this.isDiscountedRide,
    this.priceAfterDiscount,
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

  bool? isMultiDestination;
  bool? isRecurring;
  bool? isScheduled;
  bool? isRecurringActive;
  int? recurringCount;
  bool? isDiscountedRide;
  int? priceAfterDiscount;
  int? userId;
  int? boughtSubscriptionId;
  int? assignedTo;
  int? cancelledBy;
  int? fairId;

  factory RideCancelModel.fromJson(Map<String?, dynamic> json) => RideCancelModel(
        id: json["id"],
        status: json["status"],
        startAddress: json["startAddress"],
        endAddress: json["endAddress"],
        startLat: json["startLat"] != null ? json["startLat"] : null,
        startLng: json["startLng"] != null ? json["startLng"] : null,
        endLat: json["endLat"] != null ? json["endLat"] : null,
        endLng: json["endLng"] != null ? json["endLng"] : null,
        distanceKm: json["distanceKM"],
        isMultiDestination: json["isMultiDestination"],
        isRecurring: json["isRecurring"],
        isScheduled: json["isScheduled"],
        isRecurringActive: json["isRecurringActive"],
        recurringCount: json["recurringCount"],
        isDiscountedRide: json["isDiscountedRide"],
        priceAfterDiscount: json["priceAfterDiscount"],
        userId: json["userId"],
        boughtSubscriptionId: json["boughtSubscriptionId"],
        assignedTo: json["assignedTo"],
        cancelledBy: json["cancelledBy"],
        fairId: json["fairId"],
      );

  Map<String?, dynamic> toJson() => {
        "id": id,
        "status": status,
        "startAddress": startAddress,
        "endAddress": endAddress,
        "startLat": startLat,
        "startLng": startLng,
        "endLat": endLat,
        "endLng": endLng,
        "distanceKM": distanceKm,
        "isMultiDestination": isMultiDestination,
        "isRecurring": isRecurring,
        "isScheduled": isScheduled,
        "isRecurringActive": isRecurringActive,
        "recurringCount": recurringCount,
        "isDiscountedRide": isDiscountedRide,
        "priceAfterDiscount": priceAfterDiscount,
        "userId": userId,
        "boughtSubscriptionId": boughtSubscriptionId,
        "assignedTo": assignedTo,
        "cancelledBy": cancelledBy,
        "fairId": fairId,
      };
}
