import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../providers/GoogleMapProvider/location_and_map_provider.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../providers/truck_provider/app_flow_provider.dart';
import '../../utils/const.dart';

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
                      child: Column(
                        children: [
                          Container(
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
                                        fairTruckProvider.getTruckFareResponse![index].quantity>0?Colors.green:
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
                                        Text(truck.truckName??"",style: TextStyle(color: Colors.black),maxLines: 1),
                                        Text(truck.truckType??"N/A",style: TextStyle(color: Colors.black),maxLines: 1),
                                        Text("Friendly with all types of goods",style: TextStyle(color: Colors.blueGrey),maxLines: 1),
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
                          Container(
                            width: 250,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: (){
                                        if(fairTruckProvider.getTruckFareResponse![index].quantity>0){
                                          fairTruckProvider.getTruckFareResponse![index].quantity--;
                                        }
                                        setState(() {});
                                      },
                                      child: Text("-",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)),

                                  // Icon(Icons.minimize,color: Colors.white,size: 25,),
                                Text("${fairTruckProvider.getTruckFareResponse![index].quantity}",),
                                InkWell(
                                    onTap: (){
                                      fairTruckProvider.getTruckFareResponse![index].quantity++;
                                      setState(() {

                                      });
                                    },
                                    child: Icon(Icons.add,color: Colors.white,size: 25,)),
                              ],),
                            ),
                          )
                        ],
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
