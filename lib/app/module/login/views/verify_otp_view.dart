
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:pinput/pinput.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/module/login/controllers/login_controller.dart';

import '../../../data/common/constants.dart';

class VerifyOtpLoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("كود التحقق",style: TextStyle(
        fontSize: 16
      ),),backgroundColor:white,leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios,color: AppColors.blackColor,)),),
      body: Obx(
            ()=> LoadingOverlay(
            isLoading: controller.isLoading,
            child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height*.02,),
                  Center(child: SvgPicture.asset("assets/svg/Verifcation.svg",)),
                  Container(
                    margin: EdgeInsets.only(top: size.height*.05,
                        right: size.width*.04,
                        left: size.width*.04,
                    ),
                    child: Text("التحقق من رقم الهاتف",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height*.01,
                        right: size.width*.04,
                        left: size.width*.04,
                    ),
                    child: Row(
                      children: [
                        Text("أدخل الكود المرسل الى الرقم ",style: TextStyle(
                          fontSize: 12,
                        ),),
                        Text("${controller.mobileConrtoller.text}",style: TextStyle(
                          fontSize: 12,
                        ),),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: size.height*.03,
                        right: size.width*.04,
                        left: size.width*.04,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: [
                        Text("كود التحقق",style: TextStyle(
                          fontSize: 15,
                        ),),
                        // Text("00:59",style: TextStyle(
                        //   fontSize: 15,
                        //   color: kMainColor
                        // ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding:   EdgeInsets.only(
                      top:   size.height*.01,
                        right: size.width*.02,left:size.width*.02),
                    child:  Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Pinput(
                                onChanged:  (val)=>controller.validateOtp(val),
                                autofocus: true,
                                onCompleted: (pin) {
                                  controller.otpConrtoller.text=pin;
                                  controller.update();
                                  controller.isButtonEnabled.value=true;
                                  },
                                length:4,
                                defaultPinTheme: PinTheme(
                                    width: 56,
                                    height: 56,
                                    textStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.blackColor),
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                ),

                                focusedPinTheme: PinTheme(
                                    width: 56,
                                    height: 56,
                                    textStyle: TextStyle(fontSize: 14, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: kMainColor),
                                      borderRadius: BorderRadius.circular(8),
                                    )
                                ),
                                // disabledPinTheme: ,
                              ),
                            ),
                          ],
                        ),
                      ),

                  ),
                  Padding(
                    padding:  EdgeInsets.only(
                        top: size.height*.06,
                        right: size.width*.02,left:size.width*.02
                    ),
                    child: BasicButton(
                      fontSize: 14,
                      label: "تحقق",
                      raduis: 8,
                      onPresed:controller.isButtonEnabled.value
                          ? ()async {
                        await controller.verifyOtp();
                      } : null,
                    ),
                  ),
                  SizedBox(height: size.height*.01,),
                  // Center(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text("لم تتلق الرمز؟",style: TextStyle(color: AppColors.blueDarkColor,fontSize: 13,fontWeight: FontWeight.w500),),
                  //       TextButton(
                  //           onPressed: (){}, child: Text("إعادة إرسال",style:  TextStyle(color: AppColors.blueDarkColor,fontSize: 13,fontWeight: FontWeight.w700),)
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            )
        ),
      )

    );
  }
  Widget buildSmallBox() {
    return Container(
      margin: const EdgeInsets.only(right: 22.0),
      width: 45.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0xFF8AE0E5),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
