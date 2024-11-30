
import 'dart:async';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/data/models/user_model.dart';
import 'package:taxi_app/app/routes/app_pages.dart';


class AuthController extends GetxController {


  Rxn<AppUser> _currentUser = Rxn();
  AppUser? get currentUser => _currentUser.value;
  set currentUser(AppUser? user) => _currentUser.value = user;

  final _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;
  set isAuthenticated(bool val) => _isAuthenticated.value = val;

  var connectionType = 3.obs;


  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    if(connectionType !=0 && connectionType != 3) {
      await Future.delayed(Duration(seconds: 2));
      final firstLaunch = CommonVariables.userData.read('firstLaunch') ?? true;
      if (firstLaunch) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        final isAuthed = CommonVariables.userData.read('isAuthed') ?? false;
        if (isAuthed) {
          final userData = CommonVariables.userData.read('userData');
          if (userData != null) {
             _currentUser.value = AppUser.fromJson(userData as Map<String, dynamic>);
            _isAuthenticated.value = true;
            Get.offAllNamed(Routes.MAIN);
          } else {
            CommonVariables.userData.write('isAuthed', false);
            Get.offAllNamed(Routes.LOGIN);
          }
        } else {
          CommonVariables.userData.write('isAuthed', false);
          Get.offAllNamed(Routes.LOGIN);
        }
      }
    } else{
    // await enternetConnectioDialog();
      await Future.delayed(Duration(days: 24));
    }
  }

  Future<void> logout() async {
    Get.offAllNamed(Routes.SPLASH);
    CommonVariables.userData.remove('userData');
    CommonVariables.userData.remove('isAuthed');
     _currentUser.value = null;
    _isAuthenticated(false);
    await init();
  }

  @override
  void onClose() {}

}
