import 'package:get/get.dart';
import 'package:taxi_app/app/module/my_trip/controllers/my_trips_controller.dart';

class MyTripBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MyTripsController());
  }
}