import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '/providers/GoogleMapProvider/location_and_map_provider.dart';
import '/utils/sizeConfig.dart';
import '/services/sockets/sockets.dart';
import 'start_booking.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

GoogleMapController? mapController;

class _HomePageState extends State<HomePage> {
  late LocationAndMapProvider gMapProv;
  Completer<GoogleMapController> _controller = Completer();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    gMapProv = Provider.of<LocationAndMapProvider>(context, listen: false);
    gMapProv.setCurrentLocMarker();
    AppSockets.initSockets();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return

      StartBooking();
  }
}
