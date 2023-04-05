import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/Disputes/all_disputes.dart';
import 'package:sultan_cab/providers/Dispute/dispute_provider.dart';
import 'dispute_chat_room.dart';

class AllDisputeList extends StatefulWidget {
  const AllDisputeList({Key? key}) : super(key: key);

  @override
  State<AllDisputeList> createState() => _AllDisputeListState();
}

class _AllDisputeListState extends State<AllDisputeList> {
  @override
  initState() {
    super.initState();
    disputeProvider.getAllDisputes();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DisputeProvider>(builder: (builder, data, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'All Disputes',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: data.dataLoaded
              ? data.disputeData!.length == 0
                  ? Center(
                      child: Container(
                        child: Text('No dispute available'),
                      ),
                    )
                  : ListView.builder(
                      itemCount: data.disputeData!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DisputeData disputeData = data.disputeData![index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 5, left: 15.0, right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                      color: Colors.grey.withOpacity(.1))
                                ],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    disputeData.request?.status?.toUpperCase() ?? "",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "${data.disputeData?[index].request?.createdAt?.day}/${data.disputeData?[index].request?.createdAt?.month}/${data.disputeData?[index].request?.createdAt?.year}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${data.disputeData?[index].request?.createdAt?.hour}:${data.disputeData?[index].request?.createdAt?.minute}:${data.disputeData?[index].request?.createdAt?.second}",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/blue_cirle.svg',
                                              width: 17,
                                            ),
                                            SizedBox(height: 19),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.disputeData?[index].request
                                                            ?.startAddress ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Transform.translate(
                                          offset: Offset(3, 0),
                                          child: Icon(
                                            Icons.more_vert,
                                            color: Color(0xff999999),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/choose_city.svg',
                                              color: Colors.red,
                                              height: 20,
                                            ),
                                            SizedBox(height: 19),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.disputeData?[index].request?.endAddress ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Disputed At",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "${data.disputeData?[index].createdAt?.day}/${data.disputeData?[index].createdAt?.month}/${data.disputeData?[index].createdAt?.year}",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            "${data.disputeData?[index].createdAt?.hour}:${data.disputeData?[index].createdAt?.minute}:${data.disputeData?[index].createdAt?.second}",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      FloatingActionButton(
                                        heroTag: index,
                                        backgroundColor: Colors.black,
                                        child: Icon(
                                          Icons.navigate_next,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Get.to(
                                            DisputeDetail(
                                              disputeId: int.parse(
                                                disputeData.id.toString(),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      );
    });
  }
}
