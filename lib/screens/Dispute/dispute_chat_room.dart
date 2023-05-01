import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Dispute/dispute_provider.dart';
import 'package:sultan_cab/screens/Dispute/dispute_messages_response.dart';
import '../../services/apiServices/StorageServices/get_storage.dart';


class DisputeDetail extends StatefulWidget {
  final int disputeId;

  DisputeDetail({required this.disputeId});

  @override
  _DisputeDetailState createState() => _DisputeDetailState(this.disputeId);
}

class _DisputeDetailState extends State<DisputeDetail> {
  int disputeId;

  _DisputeDetailState(this.disputeId);

  @override
  void initState() {
    disputeProvider.getDisputeMessages(disputeId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Consumer<DisputeProvider>(builder: (_, data, __) {
        return Column(
          children: [
            Expanded(
              child: Container(
                  height: size.height / 1.25,
                  width: size.width,
                  child: ListView.builder(
                    // reverse: true,
                    shrinkWrap: true,
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
                          data.onSendDisputeMessage(disputeId);
                        }),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget messages(Size size, AllMessages message) {
    return Container(
      width: size.width,
      alignment: message.sentById == StorageCRUD.getUser().id
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: message.sentById == StorageCRUD.getUser().id
                  ? Radius.circular(0)
                  : Radius.circular(10),
              topLeft: message.sentById == StorageCRUD.getUser().id
                  ? Radius.circular(10)
                  : Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          color:
              message.sentById == StorageCRUD.getUser().id ? Colors.black : Colors.redAccent,
        ),
        child: Column(
          children: [
            Text(
              message.message!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     time.toDate().toString(),
            //
            //     style: TextStyle(
            //
            //       fontSize: 16,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.white,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
