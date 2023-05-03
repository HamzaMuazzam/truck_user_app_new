import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/fair_provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import '../../providers/GoogleMapProvider/location_and_map_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../utils/strings.dart';
import 'home_page.dart';
import 'navigation_screen.dart';
import 'searching_widget.dart';

class BookingTime extends StatefulWidget {
  @override
  _BookingTimeState createState() => _BookingTimeState();
}

class _BookingTimeState extends State<BookingTime> {
  FairTruckProvider fairTruckProvider =
  Provider.of(Get.context!, listen: false);

  @override
  void initState() {
    super.initState();
  }

  late double h, b;
  var dropdownValue='1';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    h = SizeConfig.screenHeight / 812;
    b = SizeConfig.screenWidth / 375;
    final appProvider = Provider.of<AppFlowProvider>(context);


    return Scaffold(
      backgroundColor: greybackColor,
      appBar: AppBar(
        backgroundColor: textYellowColor,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Booking",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: scaffoldColor),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: b * 15,
                          vertical: h * 15,
                        ),
                        padding:
                        EdgeInsets.fromLTRB(b * 17, h * 20, b * 17, h * 20),
                        decoration: BoxDecoration(
                          color: greybackColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      /// loading date
                                      Text(
                                        "Choose Loading Date and Time-Slot:",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: textYellowColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            sh(30),

                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: Get.width * 0.5,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade600,
                                        borderRadius: BorderRadius.circular(10),


                                      ),
                                      child:DropdownButton<String>(
                                        value: dropdownValue='1',
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>['One', 'Two', 'Free', 'Four']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                            sh(10),
                            Container(
                              color: Colors.grey,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AppButton(
              label: "Submit",
              onPressed: () async {

                  Get.to(()=>SearchingWidget());
              },
            ),
          ),
          sh(20)
        ],
      ),
    );
  }

  String getSelectedTrucks() {
    List<String> list = [];
    fairTruckProvider.getTruckFareResponse!.forEach((element) {
      String trucks = '';
      if (element.quantity > 0) {
        if (element.truckType != '') {
          trucks = ' ( ' + element.truckType! + ' )';
        }
        list.add(element.truckName! + trucks);
      }
    });
    return list.isEmpty ? "" : list.join("\n");
  }
}
