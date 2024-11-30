
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> fetchRoute(var startLocation,var destinationLocation,polylineCoordinates) async {
  if (startLocation.value != LatLng(0, 0) && destinationLocation.value != LatLng(0, 0)) {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startLocation.value.latitude},${startLocation.value.longitude}&destination=${destinationLocation.value.latitude},${destinationLocation.value.longitude}&key=AIzaSyALj2eP7Jf_2D4jAmgmaHEDoOFBIG6Aqoo';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String encodedPolyline = data['routes'][0]['overview_polyline']['points'];
      polylineCoordinates.value = _decodePolyline(encodedPolyline);
    }
  }
}

List<LatLng> _decodePolyline(String encoded) {
  List<LatLng> polyline = [];
  int index = 0, len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1F) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1F) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lng += dlng;

    polyline.add(LatLng(lat / 1E5, lng / 1E5));
  }

  return polyline;
}