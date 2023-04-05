// To parse this JSON data, do
//
//     final userRegResponse = userRegResponseFromJson(jsonString);

import 'dart:convert';

UserRegResponse userRegResponseFromJson(String str) => UserRegResponse.fromJson(json.decode(str));

String userRegResponseToJson(UserRegResponse data) => json.encode(data.toJson());

class UserRegResponse {
  UserRegResponse({
    this.name,
    this.verificationToken,
    this.resetToken,
    this.resetTokenExpires,
    this.companyContact,
    this.companyCr,
    this.userRoles,
    this.userLogins,
    this.userClaims,
    this.userTokens,
    this.refreshTokens,
    this.id,
    this.userName,
    this.email,
    this.phoneNumber,
  });

  String? name;
  dynamic verificationToken;
  dynamic resetToken;
  dynamic resetTokenExpires;
  String? companyContact;
  String? companyCr;
  dynamic userRoles;
  dynamic userLogins;
  dynamic userClaims;
  dynamic userTokens;
  List<RefreshToken>? refreshTokens;
  int? id;
  String? userName;
  String? email;
  String? phoneNumber;

  factory UserRegResponse.fromJson(Map<String, dynamic> json) => UserRegResponse(
    name: json["name"],
    verificationToken: json["verificationToken"],
    resetToken: json["resetToken"],
    resetTokenExpires: json["resetTokenExpires"],
    companyContact: json["companyContact"],
    companyCr: json["companyCR"],
    userRoles: json["userRoles"],
    userLogins: json["userLogins"],
    userClaims: json["userClaims"],
    userTokens: json["userTokens"],
    refreshTokens: List<RefreshToken>.from
      (json["refreshTokens"]==null?[]:json["refreshTokens"].map((x)
    => RefreshToken.fromJson(x))),
    id: json["id"],
    userName: json["userName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "verificationToken": verificationToken,
    "resetToken": resetToken,
    "resetTokenExpires": resetTokenExpires,
    "companyContact": companyContact,
    "companyCR": companyCr,
    "userRoles": userRoles,
    "userLogins": userLogins,
    "userClaims": userClaims,
    "userTokens": userTokens,
    "refreshTokens": List<dynamic>.from(refreshTokens!.map((x) => x.toJson())),
    "id": id,
    "userName": userName,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}

class RefreshToken {
  RefreshToken({
    this.id,
    this.jwtId,
    this.creationDate,
    this.expiryDate,
    this.used,
    this.invalidated,
    this.userId,
  });

  int? id;
  String? jwtId;
  DateTime? creationDate;
  DateTime? expiryDate;
  bool? used;
  bool? invalidated;
  int? userId;

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
    id: json["id"],
    jwtId: json["jwtId"],
    creationDate: DateTime.parse(json["creationDate"]==null?'':json["creationDate"]),
    expiryDate: DateTime.parse(json["expiryDate"]),
    used: json["used"],
    invalidated: json["invalidated"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jwtId": jwtId,
    "creationDate": creationDate!.toIso8601String(),
    "expiryDate": expiryDate!.toIso8601String(),
    "used": used,
    "invalidated": invalidated,
    "userId": userId,
  };
}
