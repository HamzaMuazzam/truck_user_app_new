import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/screens/TruckBooking/searching_widget.dart';

import '../../providers/Truck _provider/fair_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../services/apiServices/StorageServices/get_storage.dart';
import '../../utils/colors.dart';
import 'booking_summary.dart';

class RequestDetailsScreenWeb extends StatefulWidget {
  const RequestDetailsScreenWeb({Key? key}) : super(key: key);

  @override
  State<RequestDetailsScreenWeb> createState() =>
      _RequestDetailsScreenWebState();
}

class _RequestDetailsScreenWebState extends State<RequestDetailsScreenWeb> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int selectedTruck = -1;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<FairTruckProvider>(builder: (_, data, __) {
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              stepper(2),
              SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 150,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "  Address of order".tr,
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.orangeAccent,
                              ),
                              Text(
                                " ${appProvider.currentAddress ?? "Pick up address".tr}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.transparent,
                              ),
                              Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              Text(
                                " ${StorageCRUD.getUser().name ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.transparent,
                              ),
                              Icon(
                                Icons.phone_android,
                                color: Colors.grey,
                              ),
                              Text(
                                " ${StorageCRUD.getUser().phoneNumber ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.blueAccent,
                              ),
                              Text(
                                " ${appProvider.destAdd ?? "Pick up address".tr}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.transparent,
                              ),
                              Icon(
                                Icons.person,
                                color: Colors.grey,
                              ),
                              Text(
                                " ${StorageCRUD.getUser().name ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.transparent,
                              ),
                              Icon(
                                Icons.phone_android,
                                color: Colors.grey,
                              ),
                              Text(
                                " ${StorageCRUD.getUser().phoneNumber ?? ""}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   getSelectedTrucks(),
                        //   style: TextStyle(
                        //       fontSize:18,
                        //       color: textGreyColor
                        //   ),
                        // ),
                        Container(
                          height: 100,
                          width: 250,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  height: 100,
                                  width: 250,
                                  child: Row(
                                    children: [
                                      Expanded(child: Container()),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(getSelectedTrucks()),
                                          )),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  child: Center(
                                    child: Image.asset(
                                        "assets/logo/trucking-logo.png"),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Loading Time".tr,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.transparent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              DateTime.now().toLocal().toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.transparent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.gas_meter_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Volumes of Good".tr,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.transparent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "12 Tons".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),

                        Row(
                          children: [
                            Icon(
                              Icons.indeterminate_check_box,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Row Size".tr,
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.date_range_outlined,
                              color: Colors.transparent,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "14m x 2m x 2m".tr,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 100.0, right: 100, top: 25),
                child: Container(
                  height: 120,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: phoneBoxBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: fairTruckProvider.deliveryNote,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Delivery Note'.tr,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      bookOrder();
                    },
                    child: Container(
                      height: 55,
                      width: 150,
                      child: Center(
                        child: Text(
                          "Next".tr,
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        );
      }),
    );
  }

  void getVehicles() async {
    if (fairTruckProvider.getTruckFareResponse!.isEmpty) {
      await fairTruckProvider.getAllTruckFairs();
    }
  }
}

Widget stepper(int index) {
  return Column(
    children: [
      Container(
        width: Get.width * 0.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Information".tr,
              style: TextStyle(
                  color: index == 0 || index > 0 ? Colors.green : Colors.white),
            ),
            Text("Type of vehicle service".tr,
                style: TextStyle(
                    color:
                        index == 1 || index > 1 ? Colors.green : Colors.white)),
            Text("Request details".tr,
                style: TextStyle(
                    color:
                        index == 2 || index > 2 ? Colors.green : Colors.white)),
            Text("Delivered".tr,
                style: TextStyle(
                    color:
                        index == 3 || index > 3 ? Colors.green : Colors.white))
          ],
        ),
      ),
      Container(
        height: 40,
        width: Get.width * 0.75,
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF35B66D), Color(0xFFF1E41B)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  height: 5,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 30,
                            color: index == 0 || index > 0
                                ? Colors.green
                                : Colors.white),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 30,
                            color: index == 1 || index > 1
                                ? Colors.green
                                : Colors.white),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 30,
                            color: index == 2 || index > 2
                                ? Colors.green
                                : Colors.white),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.circle,
                            size: 30,
                            color: index == 3 || index > 3
                                ? Colors.green
                                : Colors.white),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
