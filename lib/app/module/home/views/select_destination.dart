import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/data/models/place.dart';
import 'package:taxi_app/app/module/home/controllers/home_controller.dart';
import 'package:taxi_app/app/routes/app_pages.dart';
import 'package:ultra_map_place_picker/ultra_map_place_picker.dart';

class SelectDestinationView extends GetView<HomeController> {
  const SelectDestinationView({super.key});

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
                  initialPosition: LocationModel(controller.currentLocation.value.latitude, controller.currentLocation.value.longitude),
                  mapTypes:(isHuaweiDevice)=>isHuaweiDevice?  [UltraMapType.normal]:UltraMapType.values,
                  myLocationButtonCooldown: 5,
                  useCurrentLocation: true,
                  resizeToAvoidBottomInset: false,
                  desiredLocationAccuracy: LocationAccuracy.high,
                  hintText: "select your destination?",
                  searchingText: "searching place",
                  enableMapTypeButton: false,
                  selectedPlaceWidgetBuilder: (context,place, state, isSearch) {
                    if (place != null) {
                      return Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child:
                          buildPlaceCard(context,place )
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                  selectInitialPosition: true,
                )
            ),
          ],
        ),
      ),
    ));
  }
  Widget buildPlaceCard(BuildContext context,PickResultModel? place) {
    final size = MediaQuery.of(context).size;
    controller.placeDestination.value = Place.fromPickResult(place!);
    controller.update();
    print( controller.placeDestination.value!.latitude!);
    final description = controller.placeOrigin.value!.description!;
    String address=controller.placeOrigin.value!.address!;
    return Container(
      height: size.height*.3,
      child: Card(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(size.height*.01),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black12,
                    child: Icon(Icons.location_on_outlined,
                      color: kMainColor,),
                  ),
                  title:Text( "${address.length> 25 ?address.substring(0,25):address}",
                    style: TextStyle(fontWeight: FontWeight.w700),),
                  subtitle: Container(child: Text("${description.length >60 ?description.substring(0,60):description}", )),
                )
            ),
            SizedBox(height: size.height*.04,),

            Padding(
              padding:   EdgeInsets.all(size.height*.01),
              child: BasicButton(
                label: "confirm",
                raduis: 4,
                onPresed: () async {
                  await controller.mapOperation.getRoute(
                      LatLng(controller.placeOrigin.value!.latitude!, controller.placeOrigin.value!.longitude!),
                      LatLng(controller.placeDestination.value!.latitude!, controller.placeDestination.value!.longitude!)
                  );
                  Get.toNamed(Routes.SELECT_TRIP_DETAILS);
                },
              ),
            )
          ],
        ),
      ),
    );

  }
}
