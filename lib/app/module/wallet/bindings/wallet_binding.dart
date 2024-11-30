import 'package:get/get.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';

class WalletBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(WalletController());
  }

}