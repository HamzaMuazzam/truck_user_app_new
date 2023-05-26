import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sultan_cab/providers/truck_provider/app_flow_provider.dart';

import '../../FCM.dart';
import '../../providers/GoogleMapProvider/location_and_map_provider.dart';
import '../../utils/colors.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/web_header.dart';
import '../commonPages/settings.dart';
import 'GetAllOrdersScreen.dart';
import 'home_page.dart';

class NavigationScreen extends StatefulWidget {
  final int index;

  const NavigationScreen({Key? key, this.index = 0}) : super(key: key);
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}
late List<Widget> _screens;

class _NavigationScreenState extends State<NavigationScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  int _index = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _index = widget.index;
    _screens = [
      HomePage(),
      GetAllOrdersScreen(),
      Settings(),
    ];


    FCM();
    // inProgressRideProvider.getRideInProgress();
    super.initState();
  }

  List<NavigationModel> _menu = [
    NavigationModel(icon: 'assets/icons/home.svg'),
    NavigationModel(icon: 'assets/icons/history.svg'),
    NavigationModel(icon: 'assets/icons/settings.svg',),
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var h = SizeConfig.screenHeight / 812;

    return


      kIsWeb
          ?
      GetStartedWeb()
          :
      Scaffold(
      bottomNavigationBar:

      Container(
        height: h * 55,
        child: BottomNavigationBar(
          backgroundColor: greybackColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          selectedIconTheme: IconThemeData(size: h * 20),
          currentIndex: _index,
          items: _menu.map((e) {
            return BottomNavigationBarItem(
              icon: SvgPicture.asset(
                e.icon,
                color: Color(0xffcccccc),
              ),
              activeIcon: SvgPicture.asset(
                e.icon,
                color: secondaryColor,
              ),
              label: '',
            );
          }).toList(),
          onTap: (menuIndex) {
            setState(() {
              _index = menuIndex;
            });
          },
        ),
      ),
      body:

      PageStorage(
        child: _screens[_index],
        bucket: bucket,
      ),
    );
  }
}

class NavigationModel {
  String icon;
  NavigationModel({required this.icon});
}


class GetStartedWeb extends StatefulWidget {
  const GetStartedWeb({Key? key}) : super(key: key);


  @override
  State<GetStartedWeb> createState() => _GetStartedWebState();
}

class _GetStartedWebState extends State<GetStartedWeb> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appFlowProvider.changeWebWidget(BookingStage.WebHome);
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: greybackColor,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Image.asset("assets/images/truck_bg_web.png")),
            Container(
              height: Get.height,
              child: Column(
                children: [
                  WebHeader(),
                  Expanded(
                    child: Consumer<AppFlowProvider>(
                      builder: (_,data,__) {
                        return Container(
                            height: Get.height,
                            width: Get.width,
                            child: data.currentWidgetWeb);
                      }
                    ),

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}