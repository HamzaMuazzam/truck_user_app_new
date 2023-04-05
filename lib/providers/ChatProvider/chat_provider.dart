import 'package:flutter/material.dart';
import 'package:sultan_cab/services/apiServices/StorageServices/get_storage.dart';
import 'package:sultan_cab/utils/commons.dart';

import '../../models/getAllMessages.dart';
import '../../services/ApiServices/api_services.dart';
import '../../services/ApiServices/api_urls.dart';

class ChatProvider extends ChangeNotifier {
  List<Message>? allMessages = [];

  ScrollController scrollController = new ScrollController();

  Future<void> getAllMessages(rideId) async {
    var body =
        await ApiServices.getMethodWithBody(ApiUrls.GET_CHAT_MESSAGES, {"requestId": '$rideId'});

    if (body.isNotEmpty) {
      allMessages = getAllMessagesFromJson(body).singleMessage;
      await Future.delayed(Duration(microseconds: 700));
      notifyListeners();
      scrollList();
    }
  }

  scrollList() {
    try {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      print(e);
    }
  }

  TextEditingController message = TextEditingController();

  void onSendMessage(
    int rideId,
    int nextUserId,
  ) async {
    if (message.text.isNotEmpty) {
      var text = message.text;
      message.clear();

      allMessages!.add(Message.fromJson({
        "id": null,
        "messageText": text,
        "createdAt": DateTime.now().toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
        "messageSentBy": StorageCRUD.getUser()!.id.toString(),
        "messageSentTo": nextUserId,
        "requestId": rideId,
      }));
      await Future.delayed(Duration(microseconds: 700));
      scrollList();
      notifyListeners();

      Map<String, String> fields = {
        'messageText': text,
        'messageSentTo': nextUserId.toString(),
        'messageSentBy': StorageCRUD.getUser()!.id.toString(),
        'requestId': rideId.toString()
      };
      String response = await ApiServices.postMethod(feedUrl: ApiUrls.SEND_MESSAGE, fields: fields);
      logger.i(response);
      getAllMessages(rideId);
    } else {
      print("Enter Some Text");
    }
  }
}
