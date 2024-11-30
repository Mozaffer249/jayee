import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/module/home/controllers/home_controller.dart';
import 'package:ultra_map_place_picker/ultra_map_place_picker.dart';

class SearchPlaceView extends GetView<HomeController> {
  const SearchPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UltraMapPlacePicker(
        googleApiKey: kGoogleApiKey, // Replace with your API key
        onPlacePicked: (place) {
          Get.back(result: place); // Return the selected place to the previous screen
        },
        initialPosition:LocationModel(controller.currentPosition.value!.latitude, controller.currentPosition.value!.longitude) ,
        mapTypes: (bool isHuaweiDevice)=>isHuaweiDevice?  [UltraMapType.normal]:UltraMapType.values,

      ),
    );
  }
}
