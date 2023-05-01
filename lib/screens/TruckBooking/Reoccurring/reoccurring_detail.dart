import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/widgets/app_button.dart';

class ReoccurringDetail extends StatelessWidget {
  ReoccurringDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reoccurring Detail",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(.3), spreadRadius: 1, blurRadius: 10),
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 50, backgroundColor: Colors.black),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 5),
                        Text("Khuram Shabbir"),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.car_crash),
                        SizedBox(width: 5),
                        Text("Honda CD-70/ ABC_5410"),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.call),
                        SizedBox(width: 5),
                        Text("+923134905014"),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 30),
                Container(height: 1, color: Colors.grey.withOpacity(.5)),

                /// Location
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/blue_cirle.svg'),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Load Location",
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    Transform.translate(
                      offset: Offset(-1 * 3, 0),
                      child: Icon(
                        Icons.more_vert,
                        color: Color(0xff999999),
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/choose_city.svg',
                          color: Color(0xffD40511),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Destination",
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 10),
                Container(height: 1, color: Colors.grey.withOpacity(.5)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pickup Time",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text("11:00:AM", style: TextStyle(fontSize: 16, color: Colors.grey))
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                      days.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                (days[index] == "Sunday" || days[index] == "Saturday")
                                    ? Icon(Icons.cancel, color: Colors.red)
                                    : Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 10),
                                Text(
                                  days[index],
                                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )),
                ),

                /// Remove Button

                optionButton(),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];
  Widget optionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /// remove
        GestureDetector(
          onTap: () async {
            await confirmation();
          },
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
