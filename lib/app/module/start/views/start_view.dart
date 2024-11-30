
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/data/common/constants.dart';


 import '../../../routes/app_pages.dart';
import '../controllers/start_controller.dart';

class StartView extends GetView<StartController> {
  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kMainColor
      ,
      body: Stack(
        children: <Widget>[


          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: appHeight / 3.0,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: appWidth * 0.28,
            ),
            child: Text(
              'chooseLanguage'.tr,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: appHeight / 2.1,
              left: 58.0,
              right: 57.0,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 34.0,
            ),
            width: 275.0,
            height: 155.0,
            decoration: BoxDecoration(
             color: kMainColor,

              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      activeColor: Colors.white,
                      title: Text(
                        'العربية',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      value: 'ar',
                      groupValue: controller.defaultLang.value,
                      onChanged: (String? val) {
                        controller.defaultLang.value = val!;
                        Get.updateLocale(
                            Locale(controller.defaultLang.value, 'SA'));
                        CommonVariables.langCode.write(LANG_CODE, 'ar');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => RadioListTile(
                      activeColor: Colors.white,
                      title: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      value: 'en',
                      groupValue: controller.defaultLang.value,
                      onChanged: (String? val) {
                        controller.defaultLang.value = val!;
                        Get.updateLocale(
                            Locale(controller.defaultLang.value, 'US'));
                        CommonVariables.langCode.write(LANG_CODE, 'en');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.only(top: appHeight / 1.6),
              alignment: Alignment.center,
              child: BasicButton(
                label: 'start'.tr,
                verticalPadding: 8.0,
                raduis: 4,
                border: true,
                fontSize: 18.0,
                onPresed: () {
                  CommonVariables.userData.write('firstLaunch', false);
                  Get.offNamed(Routes.LOGIN);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
