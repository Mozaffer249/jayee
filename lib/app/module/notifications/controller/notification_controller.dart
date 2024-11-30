import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;  // Observable list of notifications

  @override
  void onInit() {
    super.onInit();
    loadNotifications();  // Load notifications when the controller is initialized
  }

  void loadNotifications() {
    final box = GetStorage();
    // Get the notifications from GetStorage
    List<dynamic>? storedNotifications = box.read('notifications');

    if (storedNotifications != null) {
      notifications.assignAll(storedNotifications.cast<Map<String, dynamic>>());
    }
  }

  void clearNotifications() {
    final box = GetStorage();
    box.remove('notifications');
    notifications.clear();
  }
}
