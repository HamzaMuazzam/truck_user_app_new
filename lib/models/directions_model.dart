import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds? bounds;
  final List<PointLatLng?>? polylinePoints;
  final String? totalDistance;
  final String? totalDuration;
  final int? durationSeconds;
  final int? distanceKM;

  const Directions({
    @required this.bounds,
    @required this.polylinePoints,
    @required this.totalDistance,
    @required this.totalDuration,
    @required this.durationSeconds,
    @required this.distanceKM,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    final data = Map<String, dynamic>.from(map['routes'][0]);
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );
    String distance = '';
    int distanceKM = 0;
    String duration = '';
    int durationSeconds = 0;
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];

      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
      durationSeconds = leg['duration']['value'];
      distanceKM = leg['distance']['value'];
    }

    return Directions(
      bounds: bounds,
      polylinePoints: PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
      durationSeconds: durationSeconds,
      distanceKM: distanceKM,
    );
  }
}
