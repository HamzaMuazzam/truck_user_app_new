import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/widgets/app_button.dart';

import 'reoccurring_detail.dart';

class ReoccurringList extends StatelessWidget {
  const ReoccurringList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reoccurring",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(.3), spreadRadius: 1, blurRadius: 10),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Driver Name",
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text("Honda CD-70/ ABC_5410"),
                      ),
                      SizedBox(height: 10),
                      optionButton(
                        onRemove: () async {
                          await confirmation();
                        },
                        onView: () {
                          Get.to(() => ReoccurringDetail());
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget optionButton({
    required VoidCallback onView,
    required VoidCallback onRemove,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// View

        GestureDetector(
          onTap: onView,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(.3), spreadRadius: 1, blurRadius: 10),
                ],
                border: Border.all(width: 1.5, color: Colors.green),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                "View",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ),

        /// remove
        GestureDetector(
          onTap: onRemove,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(.3), spreadRadius: 1, blurRadius: 10),
                ],
                border: Border.all(width: 1.5, color: Colors.red),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                "Remove",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> confirmation() async {
    await Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(top: 25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                    child: Column(
                      children: [
                        Text(
                          "Do you really want to remove from you reoccurring schedule ?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 30),
                        AppButton(label: "Confirm"),
                        SizedBox(height: 10),
                        AppButton(
                          label: "Cancel",
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Icon(
                Icons.info,
                color: Colors.orange,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
