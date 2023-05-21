import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/screens/TruckBooking/pickup_location.dart';

import '../../models/directions_model.dart';
import '../../providers/GoogleMapProvider/location_and_map_provider.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../services/directions_services.dart';
import '../../utils/api_keys.dart';
import '../../utils/commons.dart';
import '../../utils/const.dart';
import '../../utils/strings.dart';
import '../../widgets/app_snackBar.dart';
import '../../widgets/app_text_field.dart';
import 'booking_summary.dart';
import 'choose_vehicle.dart';

class VehicleChooseScreenWeb extends StatefulWidget {
  const VehicleChooseScreenWeb({Key? key}) : super(key: key);

  @override
  State<VehicleChooseScreenWeb> createState() => _VehicleChooseScreenWebState();
}

class _VehicleChooseScreenWebState extends State<VehicleChooseScreenWeb> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVehicles();
  }
  int selectedTruck=-1;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<FairTruckProvider>(builder: (_, data, __) {
        return Column(
          children: [
            SizedBox(
              height: 60,
            ),
            stepper(1),
            SizedBox(
              height: 100,
            ),
            Container(
              width: Get.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      List.generate(data.getTruckFareResponse!.length, (index) {
                    var truck = data.getTruckFareResponse![index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          selectedTruck=index;
                          setState(() {
                          });
                          fairTruckProvider.getTruckFareResponse![index].quantity=1;
                        },
                        child: Container(
                          height: 150,
                          width: 250,
                          child: Stack(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 150,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      color:
                                      selectedTruck==index?Colors.green:
                                      Color(0xe8ffffff),
                                      borderRadius: BorderRadius.circular(10),
                                      // image: DecorationImage(image: Image.asset("assets/logo/trucking-logo.png").image)

                                    ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                      Text(truck.truckName??"",style: TextStyle(color: Colors.black),),
                                      Text("Friendly with all types of goods",style: TextStyle(color: Colors.blueGrey),),
                                        SizedBox(height: 5,)
                                    ],),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: Image.asset("assets/logo/trucking-logo.png").image)),
                              ),
                            ],
                          ),

                          // ChooseCar(),
                        ),
                      ),
                    );
                  }),
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

                    bool where = fairTruckProvider.getTruckFareResponse!.where((element) => element.quantity>0).isNotEmpty;
                    if(where){
                      // await fairTruckProvider.getAllCities();
                      appFlowProvider.changeWebWidget(BookingStage.Summary);



                      // Get.to(BookingSummary());
                    }else{
                      AppConst.errorSnackBar("Please select one trailer at least");
                      return;
                    }


                    // if(dropAddress==null || pickaddress==null){
                    //   return;
                    // }
                    // appFlowProvider.changeWebWidget(BookingStage.Vehicle)
                  },
                  child: Container(
                    height: 55,
                    width: 150,
                    child: Center(
                      child: Text(
                        "Next",
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
            )
          ],
        );
      }),
    );
  }

  void getVehicles() async {
    await fairTruckProvider.getAllTruckFairs();
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
              "Order",
              style: TextStyle(
                  color: index == 0 || index > 0 ? Colors.green : Colors.white),
            ),
            Text("Type of vehicle service",
                style: TextStyle(
                    color:
                        index == 1 || index > 1 ? Colors.green : Colors.white)),
            Text("Request details",
                style: TextStyle(
                    color:
                        index == 2 || index > 2 ? Colors.green : Colors.white)),
            Text("Delivered ",
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
