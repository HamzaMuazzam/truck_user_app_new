import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:sultan_cab/models/vehicleDetail.dart';

class BasicServices {
  static Future getCities() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/cities.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future getVehicleClasses() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/vehicleClasses.json');
    final data = jsonDecode(jsondata);
    return data;
  }

  static Future getModelByDateCity() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/allCars.json');
    final data = jsonDecode(jsondata);

    return data;
  }

  static Future updateProfile() async {
    return "Profile updated successfully!";
  }

  static Future<VehicleDetailModel?> getVehcileDetails() async {
    final jsondata = await rootBundle.rootBundle
        .loadString('assets/json/vehicleDetails.json');
    final data = jsonDecode(jsondata);

    return VehicleDetailModel.fromJson(data);
  }

  static Future getHub() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/json/hubs.json');
    final data = jsonDecode(jsondata);
    return data;
  }
}
