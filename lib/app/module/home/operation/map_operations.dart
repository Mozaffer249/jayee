import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/data/models/drivers_location.dart';
import 'package:taxi_app/app/data/models/place.dart';
import 'package:taxi_app/app/module/home/controllers/home_controller.dart';
import 'package:taxi_app/app/provider/mapProvider.dart';
import 'dart:ui' as ui;


class MapOperation {
  final HomeController homeController;

   MapOperation(this.homeController);

  Future<void> checkLocationPermission({bool? isFirstLaunch}) async {
     if (!await _isLocationServiceEnabled()) {
        homeController.isLoadingMap = false;
       checkLocationPermission(isFirstLaunch: false);
       return;
    }

     if (!await _requestLocationPermission()) {
       checkLocationPermission(isFirstLaunch: false);
       return;
    }
     Position position = await Geolocator.getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);
    homeController.currentPosition.value = position;

      await _updatePlaceOrigin(position);
    await updateLocation(position);
    homeController.isLoadingMap = false;

    homeController.update();
  }

  Future<bool> _isLocationServiceEnabled() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationServiceDialog();
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      homeController.locationServiceEnabled.value = serviceEnabled;
    }
    return serviceEnabled;
  }

  Future<bool> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    bool isGranted = (permission != LocationPermission.denied && permission != LocationPermission.deniedForever);

    homeController.permissionGranted.value = isGranted;
    return isGranted;
  }

  Future<Position> _getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _updatePlaceOrigin(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    homeController.placeOrigin.value = Place.fromComponents(
      position: position,
      placemark: placemarks.first,
    );

  }

  Future<void> _showLocationServiceDialog() async {
    // Show an alert dialog to inform the user that location services are disabled
    await showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enable Location Services"),
          content: Text(
              "Location services are disabled. Please enable them in settings."),
          actions: [
            TextButton(
              child: Text("Open Settings"),
              onPressed: () {
                // Open the location settings
                Geolocator.openLocationSettings();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateLocation(Position position)async {
    _addCustomCircle(position);
    _addDirectionMarker(position);
        homeController. myMapController?.animateCamera(
          CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude, position.longitude),zoom: 14))
      );
        homeController.update();

  }

  void _addCustomCircle(Position position) {
    homeController.circles.clear();
    homeController.circles.add(
      Circle(
        circleId: CircleId('customCircle'),
        center: LatLng(position.latitude, position.longitude),
        radius: 500,
        // Customize this radius as needed
        fillColor: kMainColor.withOpacity(0.1),
        // Transparent circle fill color
        strokeColor: kMainColor.withOpacity(0.5),
        // Circle border color
        strokeWidth: 0, // Circle border width
      ),
    );
    homeController.circles.add(
      Circle(
        circleId: CircleId('customCirclePrime'),
        center: LatLng(position.latitude, position.longitude),
        radius: 100,
        // Customize this radius as needed
        fillColor: kMainColor,
        // Transparent circle fill color
        strokeColor: kMainColor,
        // Circle border color
        strokeWidth: 0, // Circle border width
      ),
    );
  }

  void _addDirectionMarker(Position position) async {
    homeController.currentLocationMarkers.value = Marker(
      markerId: MarkerId('directionMarker'),
      position: LatLng(position.latitude, position.longitude),

       icon: homeController.currentocationIcon.value!,
      rotation: position.heading,
      // Rotate marker based on the direction
      anchor: Offset(0.5, 0.5), // Center the icon
    );
    homeController.update();

  }
  // Function to set markerOrigin
  void setOriginMarker(LatLng position) async {
    homeController.markerOrigin.value = Marker(
      markerId: MarkerId('originMarker'),
      position: position,
      icon: homeController.originIcon.value!,
      anchor: Offset(0.5, 0.5), // Center the icon
    );
    if (homeController.markerOrigin.value != null &&
        homeController.markerDestination.value != null) {
      await getRoute(homeController.markerOrigin.value!.position,
          homeController.markerDestination.value!.position);
    }
  }

  // Function to set markerDestination
  void setDestinationMarker(LatLng position) async {
    homeController.markerDestination.value = Marker(
      markerId: MarkerId('destinationMarker'),
      position: position,
      icon: homeController.destinationIcon.value!,
      anchor: Offset(0.5, 0.5), // Center the icon
    );
    if (homeController.markerOrigin.value != null &&
        homeController.markerDestination.value != null) {
      await getRoute(homeController.markerOrigin.value!.position,
          homeController.markerDestination.value!.position);
    } else if (homeController.currentLocationMarkers.value != null &&
        homeController.markerDestination.value != null) {
      await getRoute(homeController.currentLocationMarkers.value!.position,
          homeController.markerDestination.value!.position);
    }
  }

  Future<void> getRoute(LatLng start, LatLng end) async {
    final String url = 'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${start.latitude},${start.longitude}'
        '&destination=${end.latitude},${end.longitude}'
        '&key=$kGoogleApiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        final points =
            decodePolyline(data['routes'][0]['overview_polyline']['points']);
        homeController.polylines.value = {
          Polyline(
            polylineId: PolylineId('route'),
            points: points,
            color: AppColors.yellowColor,
            width: 5,
          ),
        };
        homeController.update();
      }
    }
  }

  // Function to focus camera on both markers
  void focusCameraOnMarkers() {
    if (homeController.markerOrigin.value != null &&
        homeController.markerDestination.value != null) {
      // Focus on both markers and minimize view
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          homeController.markerOrigin.value!.position.latitude <
                  homeController.markerDestination.value!.position.latitude
              ? homeController.markerOrigin.value!.position.latitude
              : homeController.markerDestination.value!.position.latitude,
          homeController.markerOrigin.value!.position.longitude <
                  homeController.markerDestination.value!.position.longitude
              ? homeController.markerOrigin.value!.position.longitude
              : homeController.markerDestination.value!.position.longitude,
        ),
        northeast: LatLng(
          homeController.markerOrigin.value!.position.latitude >
                  homeController.markerDestination.value!.position.latitude
              ? homeController.markerOrigin.value!.position.latitude
              : homeController.markerDestination.value!.position.latitude,
          homeController.markerOrigin.value!.position.longitude >
                  homeController.markerDestination.value!.position.longitude
              ? homeController.markerOrigin.value!.position.longitude
              : homeController.markerDestination.value!.position.longitude,
        ),
      );
      homeController.myMapController
          ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 120));
    } else if (homeController.markerOrigin.value == null &&
        homeController.markerDestination.value != null) {
      LatLngBounds bounds = _calculateBounds(
        homeController.markerDestination.value!.position,
        homeController.currentLocationMarkers.value!.position,
      );
      homeController.myMapController
          ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 120));
    } else if (homeController.markerOrigin.value != null) {
      // Focus on origin marker only
      homeController.myMapController?.animateCamera(
          CameraUpdate.newLatLng(homeController.markerOrigin.value!.position));
    }
  }

  LatLngBounds _calculateBounds(LatLng position1, LatLng position2) {
    return LatLngBounds(
      southwest: LatLng(
        position1.latitude < position2.latitude
            ? position1.latitude
            : position2.latitude,
        position1.longitude < position2.longitude
            ? position1.longitude
            : position2.longitude,
      ),
      northeast: LatLng(
        position1.latitude > position2.latitude
            ? position1.latitude
            : position2.latitude,
        position1.longitude > position2.longitude
            ? position1.longitude
            : position2.longitude,
      ),
    );
  }

  void setProviderMarker(LatLng position) async {
    homeController.markerProvider.value = Marker(
      markerId: MarkerId('markerProvider'),
      position: position,
      icon: homeController.ProviderIcon.value!,
      anchor: Offset(0.5, 0.5), // Center the icon
    );
    homeController.myMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: position, zoom: 15.0)));
    homeController.update();
  }

  void setDriversMarkers(List<DriversLocation> driversLocationsList) async {
    homeController.driverMarkers.clear();
    for (var location in driversLocationsList) {
      homeController.driverMarkers.add(Marker(
        markerId:
            MarkerId('markerDriver${driversLocationsList.indexOf(location)}'),
        position:
            LatLng(location.providerLatitude!, location.providerLongitude!),
        icon: homeController.ProviderIcon.value!,
        anchor: Offset(0.5, 0.5), // Center the icon
      ));
    }
  }

  Future<void> initializeIcons() async {
    // carIcon.value = await BitmapDescriptor.fromBytes(await getImages("assets/images/taxiDriver.png", 50));
    homeController.currentocationIcon.value = await BitmapDescriptor.fromBytes(
        await getImages("assets/images/marker_dir.png", 20));
    homeController.originIcon.value = await BitmapDescriptor.fromBytes(
        await getImages("assets/images/origin.png", 70));
    homeController.destinationIcon.value = await BitmapDescriptor.fromBytes(
        await getImages("assets/images/destination.png", 70));
    homeController.ProviderIcon.value = await BitmapDescriptor.fromBytes(
        await getImages("assets/images/logo.png", 70));
    homeController.update();
  }

  // declared method to get Images
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  bool checkPlaces() {
    if (homeController.placeDestination.value == null) {
      return false;
    } else {
      return true;
    }
  }
}
