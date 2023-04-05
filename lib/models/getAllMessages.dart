// To parse this JSON data, do
//
//     final getAllMessages = getAllMessagesFromJson(jsonString);

import 'dart:convert';

GetAllMessages getAllMessagesFromJson(String? str) => GetAllMessages.fromJson(json.decode(str!));

String? getAllMessagesToJson(GetAllMessages data) => json.encode(data.toJson());

class GetAllMessages {
  GetAllMessages({
    this.error,
    this.errorCode,
    this.message,
    this.singleMessage,
  });

  bool? error;
  int? errorCode;
  String? message;
  List<Message>? singleMessage;

  factory GetAllMessages.fromJson(Map<String, dynamic> json) => GetAllMessages(
        error: json["error"] == null ? null : json["error"],
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        message: json["message"] == null ? null : json["message"],
        singleMessage: json["data"] == null
            ? null
            : List<Message>.from(json["data"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "errorCode": errorCode == null ? null : errorCode,
        "message": message == null ? null : message,
        "data": singleMessage == null
            ? null
            : List<dynamic>.from(singleMessage!.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    this.id,
    this.messageText,
    this.createdAt,
    this.updatedAt,
    this.messageSentBy,
    this.messageSentTo,
    this.requestId,
  });

  int? id;
  String? messageText;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic messageSentBy;
  dynamic messageSentTo;
  dynamic requestId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"] == null ? null : json["id"],
        messageText: json["messageText"] == null ? null : json["messageText"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        messageSentBy: json["messageSentBy"] == null ? null : json["messageSentBy"],
        messageSentTo: json["messageSentTo"] == null ? null : json["messageSentTo"],
        requestId: json["requestId"] == null ? null : json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "messageText": messageText == null ? null : messageText,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "messageSentBy": messageSentBy == null ? null : messageSentBy,
        "messageSentTo": messageSentTo == null ? null : messageSentTo,
        "requestId": requestId == null ? null : requestId,
      };
}
