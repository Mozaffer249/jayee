// lib/services/map_service.dart
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/app/config/dio_config.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/data/models/driver.dart';

class MapService {
  Future<List<DriverModel>> fetchNearbyDrivers(LatLng location) async {
    // Fetch drivers from your backend or a mock response
    return [
      DriverModel(id: '1', name: 'Driver 1', lat: location.latitude + 0.01, long: location.longitude + 0.01),
      DriverModel(id: '2', name: 'Driver 2', lat: location.latitude - 0.01, long: location.longitude - 0.01),
    ];
  }

  Future<List<LatLng>> fetchRoute(LatLng start, LatLng end) async {
    // Fetch route from your backend or a mock response
    return [
      start,
      LatLng((start.latitude + end.latitude) / 2, (start.longitude + end.longitude) / 2),
      end,
    ];
  }

}

class DirectionsModel {
  Future<Map<String, dynamic>> getDirections(
      String origin, String destination) async {
    final String apiKey = kGoogleApiKey;
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';

    try {
      Response response = await DioClient.DIO_CLIENT.get(url);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load directions');
      }
    } catch (e) {
      throw Exception('Failed to load directions: $e');
    }
  }
}
List<LatLng>  decodePolyline(String encoded) {
  var poly = encoded;
  var list = <LatLng>[];
  var index = 0;
  var len = poly.length;
  var lat = 0;
  var lng = 0;

  while (index < len) {
    var b;
    var shift = 0;
    var result = 0;

    do {
      b = poly.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);

    var dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lat += dlat;

    shift = 0;
    result = 0;

    do {
      b = poly.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);

    var dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lng += dlng;

    var p = LatLng(
      (lat / 1E5).toDouble(),
      (lng / 1E5).toDouble(),
    );
    list.add(p);
  }

  return list;
}

