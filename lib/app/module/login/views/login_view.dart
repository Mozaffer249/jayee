import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/constants.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return  Obx(
          ()=> LoadingOverlay(
            isLoading: controller.isLoading,
            color: AppColors.blueDarkColor,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
                appBar: AppBar(
                    title: Text(
                      "تسجيل الدخول",
                      style: TextStyle(fontSize: 16),
                    ),
                    centerTitle: true,
                    backgroundColor: white),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                      height: size.height * .3,
                     margin: EdgeInsets.only(
                       right: size.width * .35,
                       left: size.width * .35,
                    ),
                          child: SvgPicture.asset(
                            "assets/svg/Login.svg",
                            height: size.height * .2,
                            width: size.width * .4,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * .04,
                          right: size.width * .04,
                        ),
                        child: Text("مرحباً بك في Jayee".tr,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: size.width * .04,
                          right: size.width * .04,
                        ),
                        child: Text("أدخل رقم الهاتف لتتمكن من تسجيل الدخول",
                            style: TextStyle(
                              fontSize: 12,
                            )),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: size.width * .04,
                              right: size.width * .04,
                              top: size.height * .03),
                          child: Text("phoneNumber".tr,
                              style: TextStyle(
                                  color: AppColors.blueDarkColor,
                                  fontSize: 14))),
                      Container(
                        width: double.infinity,
                        height: size.height * .06,
                        margin: EdgeInsets.only(
                            left: size.width * .04,
                            right: size.width * .04,
                            top: size.height * .01),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 3,
                                  blurRadius: 3)
                            ],
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: controller.mobileConrtoller,
                                  keyboardType: TextInputType.phone,
                                  onChanged:(value)=> controller.validatePhoneNumber(value),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.greyColor),
                                    hintText: "الرجاء إدخال رقم الهاتف".tr,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 55,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () async {
                                    // final code = await controller
                                    //     .countryPicker
                                    //     .showPicker(
                                    //   context: context,
                                    // );
                                    // if (code != null)
                                    //   controller.countryCode = code;
                                    // print(  controller.countryCode.dialCode);
                                    // controller.update();
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Icon(Icons
                                            .keyboard_arrow_down_rounded),
                                        Text(
                                          "${controller.countryCode.dialCode}",
                                          style: TextStyle(
                                              fontSize: size.width * .03),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: size.height * .02,
                                            child: controller.countryCode.flagImage,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * .05,
                            right: size.width * .04,
                            left: size.width * .04),
                        child: BasicButton(
                          raduis: 8,
                          label: "تسجيل دخول".tr,
                          fontSize: 16,
                          buttonColor:controller.isButtonEnabled.value ? AppColors.blueDarkColor : AppColors.greyColor,
                          onPresed: controller.isButtonEnabled.value
                              ? ()async {
                            await controller.login();
                          } : null,
                        ),
                      ),
                    ],
                  ),
                ))),
      ) ;
  }
}
