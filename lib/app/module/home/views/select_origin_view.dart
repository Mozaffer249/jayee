
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/data/models/place.dart';
import 'package:taxi_app/app/module/home/controllers/home_controller.dart';
import 'package:ultra_map_place_picker/ultra_map_place_picker.dart';

class SelectOriginView extends GetView<HomeController> {
  const SelectOriginView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() => LoadingOverlay(
          isLoading: controller.isLoading,
          child: Scaffold(
            body: Stack(
              children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: UltraMapPlacePicker(
                      googleApiKey: kGoogleApiKey,
                      initialPosition:initialPosition(),
                      mapTypes:(isHuaweiDevice)=>isHuaweiDevice?  [UltraMapType.normal]:UltraMapType.values,
                      myLocationButtonCooldown: 5,
                      useCurrentLocation: true,
                      resizeToAvoidBottomInset: false,
                        desiredLocationAccuracy: LocationAccuracy.high,
                        hintText: "",
                        searchingText: "searching place",
                        enableMapTypeButton: false,
                      selectInitialPosition: true,
                      autocompleteOnTrailingWhitespace: false,
                      selectedPlaceWidgetBuilder: (context,place, state, isSearch) {
                        if (place != null)  {
                          final newPlace = Place.fromPickResult(place);
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (controller.isSelectingOrigin) {
                              controller.placeOrigin.value = newPlace;
                              controller.mapOperation.setOriginMarker(
                                  LatLng( controller.placeOrigin.value!.latitude!, controller.placeOrigin.value!.longitude!)
                              );
                              controller.mapOperation.focusCameraOnMarkers();
                            } else {
                              controller.placeDestination.value = newPlace;
                              controller.mapOperation.setDestinationMarker(LatLng( controller.placeDestination.value!.latitude!, controller.placeDestination.value!.longitude!)
                              );
                              controller.mapOperation.focusCameraOnMarkers();
                             }
                          });
                          return Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child:
                              buildPlaceCard(context,controller.isSelectingOrigin)
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )
                ),
          ],
            ),
         ),
        ));
  }

  Widget buildPlaceCard(BuildContext context, bool isSelectingOrigin) {
    final size = MediaQuery.of(context).size;

    // Determine which place to use based on the flag
    final place = isSelectingOrigin ? controller.placeOrigin.value : controller.placeDestination.value;

    if (place == null) {
      return Center(child: Text('No place selected.'));
    }

    final description = place.description ?? '';
    final address = place.address ?? '';

    return Container(
      height: size.height * .3,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(size.height * .01),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.location_on_outlined,
                    color: kMainColor,
                  ),
                ),
                title: Text(
                  "${address.length > 25 ? address.substring(0, 25) : address}",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  "${description.length > 60 ? description.substring(0, 60) : description}",
                ),
              ),
            ),
            SizedBox(height: size.height * .04),
            Padding(
              padding: EdgeInsets.all(size.height * .01),
              child: BasicButton(
                label: "Done".tr,
                raduis: 4,
                onPresed: () => Get.back(result: true),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LocationModel initialPosition(){
     if (controller.isSelectingOrigin) {
      // When selecting origin, use placeOrigin if available
      if (controller.placeOrigin.value != null) {
     return LocationModel(
          controller.placeOrigin.value!.latitude!,
          controller.placeOrigin.value!.longitude!,
        );
      } else {
        return LocationModel(
          controller.currentLocation.value.latitude,
          controller.currentLocation.value.longitude,
        );
      }
    }
     else {
      // When selecting destination, use placeDestination if available
      if (controller.placeDestination.value != null) {
        return LocationModel(
          controller.placeDestination.value!.latitude!,
          controller.placeDestination.value!.longitude!,
        );
      } else {
        return LocationModel(
          controller.currentLocation.value.latitude,
          controller.currentLocation.value.longitude,
        );
      }
    }
  }
}
