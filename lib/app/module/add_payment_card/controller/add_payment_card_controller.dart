import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPaymentCardController extends GetxController{
  var cardNumber = ''.obs;
  var expiryDate = ''.obs;
  var cardHolderName = ''.obs;
  var cvvCode = ''.obs;
  RxBool isCvvFocused = false.obs;
  RxBool useGlassMorphism = false.obs;
  RxBool useBackgroundImage = false.obs;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    // TODO: implement onInit
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.onInit();
  }
}