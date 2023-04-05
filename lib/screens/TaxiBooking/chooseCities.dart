import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/Truck%20_provider/fair_provider.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import '../../utils/commons.dart';
import 'booking_summary.dart';

class ChooseCities extends StatefulWidget {
  const ChooseCities({Key? key}) : super(key: key);

  @override
  _ChooseCitiesState createState() => _ChooseCitiesState();
}

class _ChooseCitiesState extends State<ChooseCities> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Consumer<FairTruckProvider>(builder: (builder, data, child) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              label: fairTruckProvider.loadCity=='' ? 'Select Load City'
                  :'Select Unload City',
            ),
            Container(
              height: h * 380,
              color: greybackColor,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fairTruckProvider.getAllCitiesResponse!.length,
                  itemBuilder: (context, index) {
                    var City = fairTruckProvider.getAllCitiesResponse![index];
                    print(City);
                    return SingleChildScrollView(
                      child: Container(
                        // height: h * 100,
                        decoration: BoxDecoration(
                          color: greybackColor,
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                if(fairTruckProvider.loadCity==''){
                                  fairTruckProvider.loadCity =
                                      City.name.toString();
                                  setState((){});
                                }
                            else{
                                  fairTruckProvider.unloadCity =
                                      City.name.toString();
                                  Get.to(BookingSummary());
                                }

                                logger.i(fairTruckProvider.unloadCity);
                              },
                              child: Container(
                                height: 70,
                                // width:200,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    City.name.toString(),
                                    style: TextStyle(
                                        color: textYellowColor, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 90.0, right: 90),
                              child: Container(
                                color: Colors.grey,
                                height: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            // AppButton(
            //   label: BookingContinue.toUpperCase(),
            //   onPressed: () async {
            //     bool where = fairTruckProvider.getTruckFareResponse!.where((element) => element.quantity>0).isNotEmpty;
            //     if(where){
            //       Get.to(BookingSummary());
            //     }else{
            //       AppConst.errorSnackBar("Please select one trailer at least");
            //       return;
            //     }
            //
            //
            //
            //   },
            // ),
          ],
        ),
      );
    });
  }
}
