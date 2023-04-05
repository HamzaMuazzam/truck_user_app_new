import 'dart:convert';

DriverArrivalModel driverArrivalModelFromJson(String str) =>
    DriverArrivalModel.fromJson(json.decode(str));

String driverArrivalModelToJson(DriverArrivalModel data) => json.encode(data.toJson());

class DriverArrivalModel {
  DriverArrivalModel({
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
    this.createdAt,
    this.updatedAt,
    this.userId,
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  int? assignedTo;
  int? cancelledBy;
  int? fairId;

  factory DriverArrivalModel.fromJson(Map<String, dynamic> json) => DriverArrivalModel(
        id: json["id"],
        status: json["status"],
        startAddress: json["startAddress"],
        endAddress: json["endAddress"],
        startLat: json["startLat"] != null ? json["startLat"].toDouble() : null,
        startLng: json["startLng"] != null ? json["startLng"].toDouble() : null,
        endLat: json["endLat"] != null ? json["endLat"].toDouble() : null,
        endLng: json["endLat"] != null ? json["endLat"].toDouble() : null,
        distanceKm: json["distanceKM"],
        acceptedAt: json["acceptedAt"] != null ? DateTime.parse(json["acceptedAt"]) : null,
        arrivedAt: json["arrivedAt"] != null ? DateTime.parse(json["arrivedAt"]) : null,
        startedAt: json["startedAt"] != null ? DateTime.parse(json["startedAt"]) : null,
        completedAt: json["completedAt"] != null ? DateTime.parse(json["completedAt"]) : null,
        cancelledAt: json["cancelledAt"] != null ? DateTime.parse(json["cancelledAt"]) : null,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        userId: json["userId"],
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
        "startedAt": startedAt,
        "completedAt": completedAt,
        "cancelledAt": cancelledAt,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
        "assignedTo": assignedTo,
        "cancelledBy": cancelledBy,
        "fairId": fairId,
      };
}
