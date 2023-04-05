import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/Disputes/all_disputes.dart';
import 'package:sultan_cab/screens/Dispute/dispute_messages_response.dart';
import 'package:sultan_cab/services/apiServices/api_services.dart';
import 'package:sultan_cab/services/apiServices/api_urls.dart';
import 'package:sultan_cab/utils/commons.dart';
import 'dart:convert';

import 'package:sultan_cab/utils/const.dart';

import '/services/apiServices/StorageServices/get_storage.dart';

DisputeProvider disputeProvider = Provider.of<DisputeProvider>(Get.context!, listen: false);

class DisputeProvider extends ChangeNotifier {
  TextEditingController createDisputeCtrl = TextEditingController();
  TextEditingController message = TextEditingController();
  ScrollController scrollController = ScrollController();

  bool dataLoaded = false;

  Future<bool> createDispute(int reqId) async {
    Map<String, String> fields = {"requestId": "${reqId}", "message": createDisputeCtrl.text};

    String response = await ApiServices.postMethod(feedUrl: ApiUrls.CREATE_DISPUTE, fields: fields);
    logger.i(response);

    CreateDisputeResponse createDisputeResponse = createDisputeResponseFromJson(response);
    if (response.isEmpty) {
      return false;
    }
    AppConst.successSnackBar(createDisputeResponse.message ?? "");
    createDisputeCtrl.clear();
    return true;
  }

  GetAllDisputesResponse? getAllDisputesResponse;
  List<DisputeData>? disputeData = <DisputeData>[];
  List<DisputeHistory>? disputeHistory = <DisputeHistory>[];
  void getAllDisputes() async {
    dataLoaded = false;
    String response = await ApiServices.getMethod(feedUrl: ApiUrls.GET_ALL_DISPUTES);
    if (response.isEmpty) return;
    logger.i(response);

    getAllDisputesResponse = getAllDisputesResponseFromJson(response);
    disputeData = getAllDisputesResponse!.data;
    dataLoaded = true;

    notifyListeners();
  }

  List<AllMessages>? allMessages = [];

  Future<bool> getDisputeMessages(int disputeId) async {
    Map<String, String> fields = {
      'disputeId': disputeId.toString(),
    };
    String response = await ApiServices.getMethodWithBody(ApiUrls.GET_DISPUTE_MESSAGES, fields);
    if (response.isEmpty) {
      return false;
    }
    logger.i(response);
    allMessages = disputeMessagesResponseFromJson(response).data;

    notifyListeners();
    return true;
  }

  Future<void> onSendDisputeMessage(int disputeId) async {
    if (message.text.isNotEmpty) {
      var text = message.text;
      message.clear();
      allMessages!.add(
        AllMessages.fromJson(
          {
            "id": null,
            "message": text,
            "createdAt": DateTime.now().toIso8601String(),
            "updatedAt": DateTime.now().toIso8601String(),
            "sentById": StorageCRUD.getUser().id,
            "disputeId": disputeId,
          },
        ),
      );
      await Future.delayed(Duration(microseconds: 700));
      notifyListeners();
      Map<String, String> fields = {
        'message': text,
        "disputeId": disputeId.toString(),
      };
      String res = await ApiServices.postMethod(
        feedUrl: ApiUrls.SEND_DISPUTE_MESSAGE,
        fields: fields,
      );

      logger.i(res);
      getDisputeMessages(disputeId);
    } else {
      AppConst.errorSnackBar("Enter Some Text");
    }
  }
}

CreateDisputeResponse createDisputeResponseFromJson(String str) =>
    CreateDisputeResponse.fromJson(json.decode(str));

String createDisputeResponseToJson(CreateDisputeResponse data) => json.encode(data.toJson());

class CreateDisputeResponse {
  CreateDisputeResponse({
    this.error,
    this.errorCode,
    this.message,
    this.data,
  });

  bool? error;
  int? errorCode;
  String? message;
  Data? data;

  factory CreateDisputeResponse.fromJson(Map<String, dynamic> json) => CreateDisputeResponse(
        error: json["error"],
        errorCode: json["errorCode"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
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
    this.disputeCreated,
    this.disputeMessage,
  });

  DisputeCreated? disputeCreated;
  DisputeMessage? disputeMessage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        disputeCreated:
            json["disputeCreated"] != null ? DisputeCreated.fromJson(json["disputeCreated"]) : null,
        disputeMessage:
            json["disputeMessage"] != null ? DisputeMessage.fromJson(json["disputeMessage"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "disputeCreated": disputeCreated?.toJson(),
        "disputeMessage": disputeMessage?.toJson(),
      };
}

class DisputeCreated {
  DisputeCreated({
    this.id,
    this.disputeById,
    this.status,
    this.requestId,
    this.updatedAt,
    this.createdAt,
  });

  int? id;
  int? disputeById;
  String? status;
  String? requestId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory DisputeCreated.fromJson(Map<String, dynamic> json) => DisputeCreated(
        id: json["id"],
        disputeById: json["disputeById"],
        status: json["status"],
        requestId: json["requestId"],
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "disputeById": disputeById,
        "status": status,
        "requestId": requestId,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}

class DisputeMessage {
  DisputeMessage({
    this.id,
    this.message,
    this.sentById,
    this.disputeId,
    this.updatedAt,
    this.createdAt,
  });

  int? id;
  String? message;
  int? sentById;
  int? disputeId;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory DisputeMessage.fromJson(Map<String, dynamic> json) => DisputeMessage(
        id: json["id"],
        message: json["message"],
        sentById: json["sentById"],
        disputeId: json["disputeId"],
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "sentById": sentById,
        "disputeId": disputeId,
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
      };
}
