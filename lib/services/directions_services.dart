import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sultan_cab/models/directions_model.dart';
import 'package:sultan_cab/services/ApiServices/api_urls.dart';

class DirectionServices {
  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng dest,
  }) async {
    try {
      final res = await http.Client().get(Uri.parse(ApiUrls.BASE_URL_TRUCK+ApiUrls.GET_DISTANCE+"?origin=${origin.latitude},${origin.longitude}&destination=${dest.latitude},${dest.longitude}")).timeout(Duration(seconds: 15));
      if (res.statusCode == 200) {
        return Directions.fromMap(jsonDecode(res.body));
      }

      return null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
