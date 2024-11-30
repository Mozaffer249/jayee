import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ultra_map_place_picker/ultra_map_place_picker.dart';

class Place {
    double? latitude;
    double? longitude;
    String? description;
    String? address;
    String? city;
    String? country;

  Place({
      this.description,
      this.latitude,
      this.longitude,
      this.address,
      this.city,
      this.country
  });
    // Optional: Create a factory method to convert from PickResultModel
    factory Place.fromPickResult(PickResultModel place) {
        final description = place.formattedAddress;
        String? address;
        String? city;
        String? country;
        for (var component in place.addressComponents!) {
            final types = component.types;
            if (types.contains('route')) {
                address = component.longName;
            } else if (types.contains('locality')) {
                city = component.longName;
            } else if (types.contains('country')) {
                country = component.longName;
            }
        }
        return Place(
            latitude: place.geometry?.location.lat,
            longitude: place.geometry?.location.lng,
            description: description?? '',
            address:address ?? '',
            city: city,
            country: country
        );
    }
    Place.fromJson(Map<String, dynamic> json) {
        latitude =double.parse(json['orderLatitude']);
        longitude = double.parse(json['orderLongitude']);
        address = json['orderDescriptionLocation'];
    }
    // Factory constructor using Position and other parameters
    factory Place.fromComponents({required Position position,required Placemark placemark}) {
        return Place(
            latitude: position.latitude,
            longitude: position.longitude,
            description: placemark.street ?? '',
            address: '${placemark.street ?? ''}, ${placemark.subLocality ?? ''}',
            city: placemark.locality,
            country: placemark.country,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['orderLatitude'] = this.latitude;
        data['orderLongitude'] = this.longitude;
        data['orderDescriptionLocation'] = this.address;
        return data;
    }
}
