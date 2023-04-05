import 'dart:convert';

GetAllDisputesResponse getAllDisputesResponseFromJson(String str) =>
    GetAllDisputesResponse.fromJson(json.decode(str));

class GetAllDisputesResponse {
  GetAllDisputesResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  List<DisputeData>? data;

  factory GetAllDisputesResponse.fromJson(Map<String, dynamic> json) => GetAllDisputesResponse(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: json["data"] != null
            ? List<DisputeData>.from(json["data"].map((x) => DisputeData.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode,
        "message": message,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
      };
}

class DisputeData {
  DisputeData({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.disputeById,
    this.requestId,
    this.disputeHistories,
    this.request,
  });

  int? id;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? disputeById;
  int? requestId;
  List<DisputeHistory>? disputeHistories;
  Request? request;

  factory DisputeData.fromJson(Map<String, dynamic> json) => DisputeData(
        id: json["id"],
        status: json["status"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        disputeById: json["disputeById"],
        requestId: json["requestId"],
        disputeHistories: json["dispute_histories"] != null
            ? List<DisputeHistory>.from(
                json["dispute_histories"].map((x) => DisputeHistory.fromJson(x)))
            : null,
        request: json["request"] != null ? Request.fromJson(json["request"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "disputeById": disputeById,
        "requestId": requestId,
        "dispute_histories": disputeHistories != null
            ? List<dynamic>.from(disputeHistories!.map((x) => x.toJson()))
            : null,
        "request": request?.toJson(),
      };
}

class DisputeHistory {
  DisputeHistory({
    this.id,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.sentById,
    this.disputeId,
  });

  int? id;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? sentById;
  int? disputeId;

  factory DisputeHistory.fromJson(Map<String, dynamic> json) => DisputeHistory(
        id: json["id"],
        message: json["message"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        sentById: json["sentById"],
        disputeId: json["disputeId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "sentById": sentById,
        "disputeId": disputeId,
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
  int? priceAfterDiscount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? boughtSubscriptionId;
  int? assignedTo;
  int? cancelledBy;
  int? fairId;

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
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "cancelledAt": cancelledAt,
        "isMultiDestination": isMultiDestination,
        "isRecurring": isRecurring,
        "isScheduled": isScheduled,
        "isRecurringActive": isRecurringActive,
        "scheduledTime": scheduledTime,
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
