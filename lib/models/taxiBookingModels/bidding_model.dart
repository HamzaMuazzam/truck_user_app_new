import 'dart:convert';

BiddingModel biddingModelFromJson(String str) => BiddingModel.fromJson(json.decode(str));

class BiddingModel {
  BiddingModel({
     this.bidCreated,
    this.userRating,
    this.time=20

  });

  BidCreated? bidCreated;
  UserRating? userRating;
  int time;

  factory BiddingModel.fromJson(Map<String, dynamic> json) => BiddingModel(
        bidCreated: json["bidCreated"]!=null?BidCreated.fromJson(json["bidCreated"]):null,
        userRating: json["userRating"] != null ? UserRating.fromJson(json["userRating"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "bidCreated": bidCreated?.toJson(),
        "userRating": userRating?.toJson(),
      };
}

class BidCreated {
  BidCreated({
     this.id,
     this.bidAmount,
     this.status,
     this.createdAt,
     this.updatedAt,
     this.userId,
     this.requestId,
     this.user,
  });

  int ?id;
  int ?bidAmount;
  String? status;
  DateTime? createdAt;
  DateTime ?updatedAt;
  int ?userId;
  int ?requestId;
  User ?user;

  factory BidCreated.fromJson(Map<String, dynamic> json) => BidCreated(
        id: json["id"],
        bidAmount: json["bidAmount"],
        status: json["status"],
        createdAt:json["createdAt"]!=null? DateTime.parse(json["createdAt"]):null,
        updatedAt:json["updatedAt"] !=null?DateTime.parse(json["updatedAt"]):null,
        userId: json["userId"],
        requestId: json["requestId"],
        user:json["user"]!=null? User.fromJson(json["user"]):null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bidAmount": bidAmount,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
        "requestId": requestId,
        "user": user?.toJson(),
      };
}

class User {
  User({
     this.name,
     this.id,
     this.profileImage,
  });

  String ?name;
  int? id;
  String? profileImage;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "profileImage": profileImage,
      };
}

class UserRating {
  UserRating({
     this.avgRating,
  });

  int? avgRating;

  factory UserRating.fromJson(Map<String, dynamic> json) => UserRating(
        avgRating: json["avgRating"],
      );

  Map<String, dynamic> toJson() => {
        "avgRating": avgRating,
      };
}
