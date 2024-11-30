import 'package:get/get.dart';
import 'package:taxi_app/app/module/notifications/controller/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(NotificationController());
  }

}