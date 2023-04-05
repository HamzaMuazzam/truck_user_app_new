import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/ChatProvider/chat_provider.dart';
import 'package:sultan_cab/services/ApiServices/StorageServices/get_storage.dart';
import '../models/getAllMessages.dart';

class ChatRoom extends StatefulWidget {
  final int rideId;
  final int nextUserId;

  ChatRoom({required this.rideId, required this.nextUserId});

  @override
  _ChatRoomState createState() => _ChatRoomState(this.rideId, this.nextUserId);
}

class _ChatRoomState extends State<ChatRoom> {
  int rideId;
  int nextUserId;
  _ChatRoomState(this.rideId, this.nextUserId);
  late ChatProvider chatProvider;

  @override
  void initState() {
    chatProvider = Provider.of<ChatProvider>(context, listen: false);

    chatProvider.getAllMessages(rideId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text("Chat".tr),
        ),
        body: Consumer<ChatProvider>(builder: (_, data, __) {
          return Column(
            children: [
              Expanded(
                child: Container(
                    // height: size.height / 1.25,
                    width: size.width,
                    child: ListView.builder(
                      // reverse: true,

                      // shrinkWrap: true,
                      controller: data.scrollController,
                      itemCount: data.allMessages!.length,
                      itemBuilder: (context, index) {
                        return messages(size, data.allMessages![index]);
                      },
                    )),
              ),
              Container(
                height: size.height / 10,
                width: size.width,
                alignment: Alignment.center,
                child: Container(
                  height: size.height / 12,
                  width: size.width / 1.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: size.height / 17,
                        width: size.width / 1.3,
                        child: TextField(
                          textDirection: TextDirection.ltr,
                          controller: data.message,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            focusColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2)),
                            hintTextDirection: TextDirection.ltr,
                            hintText: "Send Message".tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.black,
                            size: 35,
                          ),
                          onPressed: () {
                            data.onSendMessage(rideId, nextUserId);
                          }),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget messages(Size size, Message message) {
    return Container(
      width: size.width,
      alignment: message.messageSentBy == StorageCRUD.getUser()!.id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: message.messageSentBy == StorageCRUD.getUser()!.id
                  ? Radius.circular(0)
                  : Radius.circular(10),
              topLeft: message.messageSentBy == StorageCRUD.getUser()!.id
                  ? Radius.circular(10)
                  : Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color: message.messageSentBy == StorageCRUD.getUser()!.id
              ? Colors.blue
              : Colors.redAccent,
        ),
        child: Column(
          children: [
            Text(
              message.messageText!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
