import 'dart:convert';

UserAuthModel userAuthModelFromJson(String str) => UserAuthModel.fromJson(json.decode(str));

String userAuthModelToJson(UserAuthModel data) => json.encode(data.toJson());

class UserAuthModel {
  UserAuthModel({
    this.message,
    this.data,
    this.error,
    this.userTokens,
  });

  String? message;
  String? userTokens;
  Data? data;
  bool? error;

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
        message: json["message"],
    userTokens: json["tokken"] ?? null,
        error: json["error"],
        data: Data.fromJson(json["data"]==null ?'':json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "data": data!.toJson()==null?'':data!.toJson(),
      };
}

class Data {
  Data({
    this.isBlocked = false,
    this.isSuspended = false,
    required this.id,
    required this.name,
    required this.loginId,
    this.mobileNumber,
    this.password = '',
     this.isSocialLogin,
     this.socialType,
     this.profileImage,
     this.isActive,
     this.userType,
     this.updatedAt,
     this.createdAt,
  });

  bool? isBlocked;
  bool? isSuspended;
  int? id;
  String? name;
  String? mobileNumber;
  String? loginId;
  String? password;
  bool? isSocialLogin;
  String? socialType;
  String? profileImage;
  bool? isActive;
  String? userType;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        isBlocked: json["isBlocked"],
        isSuspended: json["isSuspended"],
        id: json["id"],
        name: json["name"],
        loginId: json["loginId"],
        password: json["password"],
        mobileNumber: json["mobileNumber"],
        isSocialLogin: json["isSocialLogin"],
        socialType: json["socialType"],
        profileImage: json["profileImage"],
        isActive: json["isActive"],
        userType: json["userType"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isBlocked": isBlocked,
        "isSuspended": isSuspended,
        "id": id,
        "name": name,
        "loginId": loginId,
        "password": password,
        "mobileNumber": mobileNumber,
        "isSocialLogin": isSocialLogin,
        "socialType": socialType,
        "profileImage": profileImage,
        "isActive": isActive,
        "userType": userType,
        "updatedAt": updatedAt!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
      };
}
