// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/services.dart' as rootBundle;
// import 'package:thrifty_cab/models/taxi/allRides.dart';
// import 'package:thrifty_cab/models/taxi/allTaxi.dart';
// import 'package:thrifty_cab/models/taxi/localTaxiFare.dart';
//
// class Services {
//   static Future<AllTaxi?> getTaxiAvailable() async {
//     final jsondata = await rootBundle.rootBundle.loadString('assets/json/taxi/allTaxi.json');
//     final data = jsonDecode(jsondata);
//     return AllTaxi.fromJson(data);
//   }
//
//   static Future<AllRides?> getAllRides() async {
//     final jsondata = await rootBundle.rootBundle.loadString('assets/json/taxi/allRides.json');
//     final data = jsonDecode(jsondata);
//     return AllRides.fromJson(data);
//   }
//
//   static Future<LocalTaxiFare?> getLocalTaxiFare() async {
//     final jsonData = await rootBundle.rootBundle.loadString('assets/json/taxi/localTaxiFare.json');
//     final data = jsonDecode(jsonData);
//     return LocalTaxiFare.fromJson(data);
//   }
// }
