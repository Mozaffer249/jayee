import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Obx(() => controller.authController.connectionType == 0
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.network_check_outlined,
                      size: 48, color: Colors.white),
                  Text(
                    "No internet connection".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ))
            :Center(child: Image.asset("assets/images/jayee- jpg.jpg"))
          )
    );
  }
}
