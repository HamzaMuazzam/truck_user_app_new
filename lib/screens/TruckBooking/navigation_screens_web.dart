import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/truck_provider/app_flow_provider.dart';

import '../../utils/colors.dart';

class WebHomeScreem extends StatefulWidget {
  const WebHomeScreem({Key? key}) : super(key: key);

  @override
  State<WebHomeScreem> createState() => _WebHomeScreemState();
}

class _WebHomeScreemState extends State<WebHomeScreem> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      height: Get.height,
      width: Get.width,
      child: Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Affordable truck service",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w900,fontSize: 60),),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc odio in et, lectus sit lorem id integer.\n",style: TextStyle(color: Colors.white,fontSize: 18),),
                InkWell(
                  onTap: (){
                    appFlowProvider.changeWebWidget(BookingStage.PickUp);
                  },
                  child: Container(
                    height: 45,
                    width: 180,
                    decoration: BoxDecoration(
                        color: yellowColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: Text(
                          "Order Now",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

