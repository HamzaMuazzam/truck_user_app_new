import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/GoogleMapProvider/location_and_map_provider.dart';
import 'package:sultan_cab/providers/auth_provider.dart';

import '../providers/truck_provider/app_flow_provider.dart';
import '../utils/colors.dart';
import 'app_widgets.dart';

class WebHeader extends StatefulWidget {
  const WebHeader({Key? key}) : super(key: key);

  @override
  State<WebHeader> createState() => _WebHeaderState();
}

class _WebHeaderState extends State<WebHeader> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppFlowProvider>(builder: (context, data, child) {
      return Container(
        width: Get.width,
        color: greybackColor,
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            sectionOneHeader(),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 0.25,
              color: Colors.white,
              width: Get.width,
            ),
            SizedBox(
              height: 15,
            ),
            sectionTwoHeader(),
            SizedBox(
              height: 12,
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF35B66D),
                    Color(0xFFF1E41B)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              height: 15,
            ),
          ],
        ),
      );
    });
  }

  Widget sectionOneHeader() {
    return Row(
      children: [
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(
            left: 80,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Saudi Arabia\nRiyadh",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 80,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Work time\n09:00 am to 01:00 pm",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(flex: 4, child: Container()),
        Row(
          children: [
            Icon(
              Icons.phone,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "+966 123456789\n+966 123456789",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        Expanded(child: Container()),
      ],
    );
  }

  Widget sectionTwoHeader() {
    return Container(
        width: Get.width,
        child: Row(
          children: [
            Expanded(child: Container()),
            Padding(
                padding: const EdgeInsets.only(
                  left: 80,
                ),
                child: Image.asset(
                  "assets/logo/trucking-logo.png",
                  height: 55,
                )),
            Expanded(child: Container()),
            Expanded(
                flex: 3,
                child: Container(
                    child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          appFlowProvider.changeWebWidget(BookingStage.WebHome);
                        },
                        child: Text(
                          "Home",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          appFlowProvider.changeWebWidget(BookingStage.OurServices);
                        },
                        child: Text(
                          "Our Services",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          appFlowProvider.changeWebWidget(BookingStage.OurMessage);
                        },
                        child: Text(
                          "Our Message",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          appFlowProvider.changeWebWidget(BookingStage.AboutUs);

                        },
                        child: Text(
                          "About us",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ))),
            Expanded(child: Container()),
            authProvider.checkUser()
                ? Container()
                : LinearGradientButton(
                    text: 'Register or Login',
                    onPressed: () {},
                  ),
            Expanded(child: Container()),
          ],
        ));
  }
}
