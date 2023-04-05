import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/models/directions_model.dart';
import 'package:sultan_cab/providers/taxi/app_flow_provider.dart';
import 'package:sultan_cab/services/directions_services.dart';
import 'package:sultan_cab/utils/api_keys.dart';
import 'package:sultan_cab/utils/colors.dart';
import 'package:sultan_cab/utils/const.dart';
import 'package:sultan_cab/utils/sizeConfig.dart';
import 'package:sultan_cab/utils/strings.dart';
import 'package:sultan_cab/widgets/app_button.dart';
import 'package:sultan_cab/widgets/app_snackBar.dart';
import 'package:sultan_cab/providers/TaxiBookingProvider/taxi_booking_provider.dart';
import '../../providers/Truck _provider/fair_provider.dart';
import '../../utils/commons.dart';

class DropOffLocation extends StatefulWidget {
  const DropOffLocation({Key? key}) : super(key: key);

  @override
  _DropOffLocationState createState() => _DropOffLocationState();
}

class _DropOffLocationState extends State<DropOffLocation> {
  late TaxiBookingProvider taxiProv;
  late AppFlowProvider appProvider;

  Marker? pickMarker;

  @override
  void initState() {
    taxiProv = Provider.of<TaxiBookingProvider>(context, listen: false);
    appProvider = Provider.of<AppFlowProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final h = MediaQuery.of(context).size.height / 812;
    final b = MediaQuery.of(context).size.width / 375;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: b * 20,
        vertical: h * 20,
      ),
      decoration: BoxDecoration(
        color: greybackColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          sh(10),
          Container(
            decoration: allBoxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Unload Location",
                    style: TextStyle(
                        color: secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (appProvider.currentAdd != null) {
                      LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlacePicker(GoogleMapApiKey),));

                      if (result != null) {
                        await appProvider.setDestinationLoc(result.latLng!, result.formattedAddress ?? "");
                        Directions? dir = await DirectionServices()
                            .getDirections(
                            origin: appProvider.currentLoc!,
                            dest: result.latLng!);

                        if (dir != null) await appProvider.setDirections(dir);
                        if (appProvider.destAdd == null) {
                          await AppConst.infoSnackBar(ChooseDestinationMsg);
                          return;
                        }
                        else if (appProvider.currentAdd == null) {
                          await AppConst.infoSnackBar(ChooseStartingMsg);
                          return;
                        }
                        else {
                          logger.i(result);
                          if (await fairTruckProvider.getAllTruckFairs())
                            await Provider.of<AppFlowProvider>(context, listen: false)
                                .changeBookingStage(BookingStage.Destination);
                          else
                            logger.e('Error in truck fairs');
                        }
                        if (appProvider.destinationType ==
                            DestinationType.Multiple) {
                          appProvider.addMultiDestination(
                            MultiDestinationsModel(
                              locationResult: result,
                              distance: dir!.totalDistance ?? "",
                            ),
                          );
                        }
                      }
                    } else
                      appSnackBar(context: context, msg: ChooseStartingMsg, isError: true);
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      height: h * 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          sw(14),
                          Expanded(
                            child: Text(
                              appProvider.destAdd == null ||
                                      appProvider.destAdd == ''
                                  ? SearchDestLabel
                                  : appProvider.destAdd!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: h * 12,
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          sh(20),
          if (appProvider.directions != null &&
              appProvider.destAdd != null &&
              appProvider.currentAdd != null)
            Column(
              children: [
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Icon(Icons.circle, color: secondaryColor, size: 15),
                //     SizedBox(width: 10),
                //     SizedBox(
                //       width: Get.width * .7,
                //       child: Text(
                //         "${appProvider.currentAdd}",
                //         style: TextStyle(),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 5),
                // Container(color: Colors.grey.withOpacity(.5), height: 1.5),
                // SizedBox(height: 5),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Icon(Icons.circle, color: Colors.green, size: 15),
                //     SizedBox(width: 10),
                //     SizedBox(
                //         width: Get.width * .7,
                //         child: Text(
                //           "${appProvider.destAdd!}",
                //           style: TextStyle(),
                //         )),
                //   ],
                // ),
              ],
            ),
          // if (appProvider.directions != null)
          //   Container(
          //     decoration: BoxDecoration(
          //       // color: Color(0xfff3f3f3),
          //       borderRadius: BorderRadius.circular(50),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Text(
          //               "Travel Time-${appProvider.directions!.totalDuration}"),
          //           Text("/"),
          //           if (appProvider.destinationType != DestinationType.Multiple)
          //             Text("Distance-${appProvider.directions!.totalDistance}"),
          //           if (appProvider.destinationType == DestinationType.Multiple)
          //             Text("Distance-${appProvider.totalDistance}"),
          //         ],
          //       ),
          //     ),
          //   ),
          sh(40),
          // AppButton(
          //   label: ProceedLabel,
          //   onPressed: () async {
          //     if (appProvider.destAdd == null) {
          //       await AppConst.infoSnackBar(ChooseDestinationMsg);
          //       return;
          //     } else if (appProvider.currentAdd == null) {
          //       await AppConst.infoSnackBar(ChooseStartingMsg);
          //       return;
          //     } else {
          //       if (await fairTruckProvider.getAllTruckFairs())
          //
          //
          //         await Provider.of<AppFlowProvider>(context, listen: false)
          //             .changeBookingStage(BookingStage.Destination);
          //     }
          //   },
          // )
        ],
      ),
    );
  }
}
