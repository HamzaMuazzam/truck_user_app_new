import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../FCM.dart';
import '../../utils/colors.dart';
import '../../utils/sizeConfig.dart';
import '../commonPages/settings.dart';
import 'get_all_orders.dart';
import 'home_page.dart';

class NavigationScreen extends StatefulWidget {
  final int index;

  const NavigationScreen({Key? key, this.index = 0}) : super(key: key);
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  int _index = 0;
  late List<Widget> _screens;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _index = widget.index;
    _screens = [
      HomePage(),
      GetAllOrders(),
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

    return Scaffold(
      bottomNavigationBar: Container(
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
      body: PageStorage(
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
