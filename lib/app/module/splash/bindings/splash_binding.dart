
import 'package:get/get.dart';
import 'package:taxi_app/app/module/auth/controllers/auth_controller.dart';

import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController(),);

    Get.put(AuthController(), permanent: true);
   }
}
