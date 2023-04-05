import 'dart:convert';

GetVehicleTypesModel getVehicleTypesModelFromJson(String str) =>
    GetVehicleTypesModel.fromJson(json.decode(str));

String getVehicleTypesModelToJson(GetVehicleTypesModel data) => json.encode(data.toJson());

class GetVehicleTypesModel {
  GetVehicleTypesModel({
    required this.error,
    required this.errorCode,
    required this.message,
    required this.data,
  });

  bool error;
  int errorCode;
  String message;
  List<Datum> data;

  factory GetVehicleTypesModel.fromJson(Map<String, dynamic> json) => GetVehicleTypesModel(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "errorCode": errorCode,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.typeName,
    required this.typeIcon,
    required this.status,
  });

  int id;
  String typeName;
  String typeIcon;
  bool status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        typeName: json["typeName"],
        typeIcon: json["typeIcon"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "typeName": typeName,
        "typeIcon": typeIcon,
        "status": status,
      };
}
