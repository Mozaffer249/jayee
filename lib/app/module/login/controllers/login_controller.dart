
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/module/auth/controllers/auth_controller.dart';
import 'package:taxi_app/app/provider/customer/identity/customer_identity.dart';
import 'package:taxi_app/app/routes/app_pages.dart';
import 'package:taxi_app/app/utils/dialog_utils.dart';


class LoginController extends GetxController {
  final count = 0.obs;

  TextEditingController mobileConrtoller = TextEditingController();
  TextEditingController otpConrtoller = TextEditingController();
  TextEditingController emailConrtoller = TextEditingController();
  TextEditingController passwordConrtoller = TextEditingController();
  TextEditingController newPasswordConrtoller = TextEditingController();
  // OtpFieldController otpCtrl = OtpFieldController();
  final countryPicker = const FlCountryCodePicker();
  CountryCode countryCode = CountryCode(name: 'Saudi Arabia', code: "SA", dialCode: "+966");

 final AuthController authController = Get.find<AuthController>();

  final RxBool isReLoading = false.obs;
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormState> resetFormKey = GlobalKey();

  final _showPassword = false.obs;
  get showPassword => this._showPassword.value;
  set showPassword(value) => this._showPassword.value = value;
  var isButtonEnabled = false.obs;
  @override
  void onInit() {
    super.onInit();
  mobileConrtoller.text="555540000";
    validatePhoneNumber("555540000");
  }

  Future<void>login()async {
    _isLoading(true);
    final result =await CustomerIdentity.login("966${mobileConrtoller.text.trim()}");
    _isLoading(false);
    result.fold((l){
      isButtonEnabled.value=false;
      Get.toNamed(Routes.VERIFY_OTP_LOGIN);
      update();
    }, (r){
      showSnackbar(title: "Error".tr, message: r!.tr);
    }
    );

  }

  Future<void>verifyOtp()async {
    _isLoading(true);
    final result =await CustomerIdentity.verifyOtpAndPhone(
        phoneNumber: "966${mobileConrtoller.text.trim()}",
        otp: otpConrtoller.text);
    _isLoading(false);
    result.fold((l)async{
      CommonVariables.userData.write("token", "${l["returnData"]["token"]}");
      CommonVariables.userData.write("expiration", "${l["returnData"]["expiration"]}");
      CommonVariables.userData.write("isAuthed", true);
      CommonVariables.userData.write('firstLaunch',false);
       await  getProfile();
    }, (r){
      showSnackbar(title: "Error".tr, message: r.tr);
    }
    );

  }

  Future<void>getProfile()async{

    final result=await CustomerIdentity.getProfile();
    result.fold((l){
      authController.currentUser=l;
      CommonVariables.userData.write("userData", authController.currentUser!.toJson());
      update();
      Get.toNamed(Routes.PROFILE,arguments: true);
    }, (r){

    }
    );
  }

  void validateOtp(String value) {
    if(value.length == 4 )
    {
     isButtonEnabled.value=true;
     update();
    }
    else {
      isButtonEnabled.value = false;
      update();
    }
  }
  void validatePhoneNumber(String value) {
    if (value.length == 9 && value.startsWith('5')) {
        isButtonEnabled.value = true;
        update();
    } else {
        isButtonEnabled.value = false;
        update();
    }
  }


  Future<void> updateToken() async {
    // String? token = await FirebaseMessaging.instance.getToken();
    // print(token);
  //  await UserProvider.updateToken(authController.currentUser!.id!, token);
  }
}
