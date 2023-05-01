import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sultan_cab/models/directions_model.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/truck_booking_provider.dart';
import 'package:sultan_cab/services/directions_services.dart';
import 'package:sultan_cab/utils/api_keys.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_snackBar.dart';

import '../../../providers/truck_provider/app_flow_provider.dart';

class MultipleDestination extends StatefulWidget {
  const MultipleDestination({Key? key}) : super(key: key);

  @override
  State<MultipleDestination> createState() => _MultipleDestinationState();
}

class _MultipleDestinationState extends State<MultipleDestination> {
  late AppFlowProvider appProvider;
  late TruckBookingProvider taxiProvider;
  final PanelController panelController = PanelController();

  @override
  void initState() {
    appProvider = Provider.of<AppFlowProvider>(context, listen: false);
    taxiProvider = Provider.of<TruckBookingProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;
    var b = SizeConfig.screenWidth / 375;

    return Stack(
      children: [
        if (appProvider.stage == BookingStage.PickUp)
          SlidingUpPanel(
            controller: panelController,
            panel: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                sh(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () async {
                      panelController.close();
                      if (appProvider.currentAdd != null) {
                        LocationResult? result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PlacePicker(GoogleMapApiKey),
                          ),
                        );
                        if (result != null) if (result.latLng != null) {
                          await appProvider.setDestinationLoc(
                              result.latLng!, result.formattedAddress ?? "");
                          // String time = await getStayTime();

                          Directions? dir = await DirectionServices()
                              .getDirections(origin: appProvider.currentLoc!, dest: result.latLng!);
                          if (dir != null) await appProvider.setDirections(dir);

                          if (appProvider.destinationType == DestinationType.Multiple) {
                            appProvider.addMultiDestination(
                              MultiDestinationsModel(
                                locationResult: result,
                                distance: dir!.totalDistance.toString().replaceAll("km", ""),
                                // waitingTime: time.isEmpty ? "" : time,
                                travelTime: (dir.durationSeconds! / 60).round().toString(),
                              ),
                            );
                          }
                          panelController.open();
                        }
                      } else
                        appSnackBar(context: context, msg: ChooseStartingMsg, isError: true);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              height: h * 50,
                              decoration: BoxDecoration(
                                color: Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.search),
                                  sw(14),
                                  Expanded(
                                    child: Text(
                                      appProvider.destAdd == null || appProvider.destAdd == ''
                                          ? SearchDestLabel
                                          : appProvider.destAdd!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: b * 12,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(width: 10),
                        FloatingActionButton(
                          mini: true,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.green,
                          onPressed: () async {
                            panelController.close();
                            if (appProvider.currentAdd != null) {
                              LocationResult? result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PlacePicker(GoogleMapApiKey),
                                ),
                              );
                              if (result != null) if (result.latLng != null) {
                                await appProvider.setDestinationLoc(
                                    result.latLng!, result.formattedAddress ?? "");
                                // String time = await getStayTime();

                                Directions? dir = await DirectionServices().getDirections(
                                    origin: appProvider.currentLoc!, dest: result.latLng!);
                                if (dir != null) await appProvider.setDirections(dir);

                                if (appProvider.destinationType == DestinationType.Multiple) {
                                  appProvider.addMultiDestination(
                                    MultiDestinationsModel(
                                      locationResult: result,
                                      distance: dir!.totalDistance.toString().replaceAll("km", ""),
                                      // waitingTime: time.isEmpty ? "" : time,
                                      travelTime: (dir.durationSeconds! / 60).round().toString(),
                                    ),
                                  );
                                }
                                panelController.open();
                              }
                            } else
                              appSnackBar(context: context, msg: ChooseStartingMsg, isError: true);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (appProvider.multiDestinationList.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: Get.width * .3,
                        child: AppButton(
                          label: "Confirm",
                          onPressed: () async {
                            panelController.close();
                            appProvider.changeBookingStage(BookingStage.Destination);
                            appProvider.getMultipleAddressAndDistance();

                            /// TODO: GET Fair Value
                          },
                        ),
                      ),
                    ],
                  ),
                sh(10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: appProvider.multiDestinationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final data = appProvider.multiDestinationList[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Material(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListTile(
                              dense: true,
                              style: ListTileStyle.drawer,
                              shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              leading: Text("${index + 1}"),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.locationResult?.formattedAddress ?? ""),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Stay ${data.travelTime} min",
                                          style: TextStyle(
                                              color: Colors.green, fontWeight: FontWeight.w300)),
                                      Text("${data.distance}",
                                          style: TextStyle(
                                              color: Colors.green, fontWeight: FontWeight.w300)),
                                    ],
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    appFlowProvider.removeMultiDestination(index);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }

  // Future<String> getStayTime() async {
  //   GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //   TextEditingController textEditingController = TextEditingController();
  //
  //   return await Get.defaultDialog(
  //     title: "Waiting Time",
  //     content: Form(
  //       key: formKey,
  //       child: Column(
  //         children: [
  //           AppTextField(
  //             validator: (v) {
  //               if (v!.isEmpty) return "* required";
  //               return null;
  //             },
  //             inputType: TextInputType.number,
  //             label: 'Time~in minutes',
  //             suffix: null,
  //             controller: textEditingController,
  //             isVisibilty: true,
  //           ),
  //           sh(20),
  //           AppButton(
  //             label: "Submit",
  //             onPressed: () {
  //               if (formKey.currentState!.validate()) {
  //                 Get.back(result: textEditingController.text);
  //               }
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
