import 'package:get/get.dart';
import 'package:taxi_app/app/module/add_payment_card/controller/add_payment_card_controller.dart';

class AddPaymentCardBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AddPaymentCardController() );
  }
}