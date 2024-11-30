import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverModel {
   String? id;
   String? name;
   double? lat;
   double? long ;
   double? direction;
   LatLng? location;


   DriverModel({
    this.id,
    this.name,
    this.lat ,
    this.long ,
    this.direction ,
    this.location ,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      name: json['name'],
      lat : json['latitude'],
      long : json['longitude'],
      direction : json['direction'],
    );
  }
}
