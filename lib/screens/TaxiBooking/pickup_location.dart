import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import '../../utils/const.dart';
import '/models/directions_model.dart';
import '/providers/taxi/app_flow_provider.dart';
import '/services/directions_services.dart';
import '/utils/api_keys.dart';
import '/utils/colors.dart';
import '/utils/sizeConfig.dart';
import '/utils/strings.dart';

class PickupLocation extends StatefulWidget {
  @override
  State<PickupLocation> createState() => _PickupLocationState();
}

class _PickupLocationState extends State<PickupLocation> {
  @override
  void initState() {
    locProv.setCurrentLocMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    final h = MediaQuery.of(context).size.height / 812;
    final b = MediaQuery.of(context).size.width / 375;
    return Consumer<AppFlowProvider>(
        builder: (BuildContext context, value, Widget? child) {
        return Column(
          children: [
            InkWell(
              onTap: () async {
                LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                    PlacePicker(GoogleMapApiKey),
                // MapLocationPicker(apiKey: GoogleMapApiKey, onNext: (GeocodingResult ) async {
                //   await Provider.of<AppFlowProvider>(context, listen: false)
                //       .changeBookingStage(BookingStage.DropOffLocation);
                // },)
                ));

                if(result!=null)
                  {
                    appProvider.currentAdd = result!.formattedAddress;
                    await appProvider.setPickUpLoc(
                        result.latLng!, result.formattedAddress ?? "");
                    if (appProvider.currentAdd == null) {
                      await AppConst.infoSnackBar(ChooseStartingMsg);
                      return;
                    } else {

                      await Provider.of<AppFlowProvider>(context, listen: false)
                          .changeBookingStage(BookingStage.DropOffLocation);

                    }
                  }
                if (appFlowProvider.pickupLocation?.latLng != null) {

                  Directions? dir = await DirectionServices()
                      .getDirections(
                      origin: appProvider.currentLoc!,
                      dest: appProvider.destLoc ?? LatLng(0.0, 0.0));
                  if(dir!=null)
                    {
                      await appProvider.setDirections(dir);

                    }
                }
              },
              child: Container(
                margin: EdgeInsets.only(
                  // top: widget.widgetHeight * 50,
                  // left: widget.widgetWidth * 15,
                  // right: widget.widgetWidth * 15,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: b * 20,
                  vertical: h * 20,
                  // vertical: widget.widgetHeight * 15,
                  // horizontal: widget.widgetWidth * 24,
                ),
                decoration: allBoxDecoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Load Location",
                        style: TextStyle(color: secondaryColor, fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search,
                          size:h * 18,
                        ),
                        sw(10),
                        Expanded(
                          child: Text(
                            appProvider.currentAdd ?? ChooseYourLocLabel,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: h * 12),
                          ),
                        ),
                        sw(10),
                        Icon(
                          Icons.location_pin,
                          size: h* 18,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            sh(40),
            // AppButton(
            //   label: ProceedLabel,
            //   onPressed: () async {
            //     if (appProvider.currentAdd == null) {
            //       await AppConst.infoSnackBar(ChooseStartingMsg);
            //       return;
            //     } else {
            //
            //         await Provider.of<AppFlowProvider>(context, listen: false)
            //             .changeBookingStage(BookingStage.DropOffLocation);
            //
            //     }
            //   },
            // )
          ],
        );
      }
    );
  }
}
