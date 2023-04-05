import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:sultan_cab/models/brand_model.dart';
import 'package:sultan_cab/models/city_model.dart';
import 'package:sultan_cab/models/hub_model.dart';
import 'package:sultan_cab/models/vehicle_class_model.dart';
import 'package:sultan_cab/models/vehicle_model.dart';
import 'package:sultan_cab/services/catalogue_services.dart';
import 'package:sultan_cab/services/preferences.dart';

class HomeProvider extends ChangeNotifier {
  String? _city;
  String? get city => _city;

  List<City> _cities = [];
  List<City> get cities => [..._cities];

  List<VehicleClass> _vehicleClass = [];
  List<VehicleClass> get vehicleClass => [..._vehicleClass];

  List<VehicleModel> _availableModel = [];
  List<VehicleModel> get availableModel => [..._availableModel];

  List<Map<String, List<BrandModel>>> _brandModel = [];
  List<Map<String, List<BrandModel>>> get brandModel => [..._brandModel];

  List<Hub> _allHub = [];
  List<Hub> get allHub => [..._allHub];

  Future<bool> checkForCity() async {
    final res = await PreferencesUtils.getPref(PreferencesUtils.currentCity);

    if (res != null) {
      _city = await PreferencesUtils.getPref(PreferencesUtils.currentCity);
      return true;
    } else
      return false;
  }

  Future<void> getCities() async {
    try {
      final res = await BasicServices.getCities();

      List<City> _items = [];
      if (res['success'] == '1') {
        res['data'].forEach((element) {
          _items.add(City.fromJson(element));
        });
      }
      _cities = _items;

      final res2 = await BasicServices.getHub();

      List<Hub> _items2 = [];

      res2['data'].forEach((ele) {
        _items2.add(Hub.fromJson(ele));
      });

      _allHub = _items2;
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> saveCity(String city) async {
    await PreferencesUtils.setPref(PreferencesUtils.currentCity, city);
  }

  Future<void> getVehicleClasses() async {
    try {
      final res = await BasicServices.getVehicleClasses();

      List<VehicleClass> _items = [];

      if (res['success'] == '1') {
        res['data'].forEach((element) {
          _items.add(VehicleClass.fromJson(element));
        });
      }
      _vehicleClass = _items;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getModelByDateCity() async {
    try {
      if (_cities.length == 0) await getCities();

      final res = await BasicServices.getModelByDateCity();

      List<VehicleModel> _items = [];

      if (res['success'] == '1') {
        res['data'].forEach((element) {
          _items.add(VehicleModel.fromJson(element));
        });
      }
      _availableModel = _items;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
