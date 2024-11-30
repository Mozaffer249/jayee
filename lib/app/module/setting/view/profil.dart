import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/basic_textfield.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/module/setting/controller/setting_controller.dart';

class ProfileView extends GetView<SettingController> {
   ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل البروفايل",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading:controller.fromStart.value?Container(): IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body: Obx(
        ()=> controller.isLoading?
        Center(child: CircularProgressIndicator(color: AppColors.blueDarkColor,)):
        LoadingOverlay(
          isLoading: controller.isReLoading.value,
          child: SingleChildScrollView(
            child: Form(
                key: controller.formKey,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(height: size.height*.2,),
                      Center(
                        child: Stack(
                          children: [
                          ClipOval(
                                child: controller.profilePicturePath.value !=""
                                    ? Image.file(
                                  File(controller.profilePicturePath.value), // Display selected image
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ) : CachedNetworkImage(
                                  imageUrl: controller.imageUrl.value, // Default image
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                  width: 100.0,
                                  height: 100.0,
                                  fit: BoxFit.cover,
                                ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => controller.pickImage(), // Call the pickImage function
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor:AppColors.blueDarkColor,
                                  child:const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top:
                          size.height*.02),
                          child:BasicTextField(
                            controller: controller.fullNameConrtoller,
                            labelText: "الاسم",
                            labelTextStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                AppColors.blueDarkColor),
                            hintTextStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blueDarkColor),
                            suffix: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset("assets/svg/edit.svg",),
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name'.tr;
                              }
                              return null;
                            },

                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                          child:BasicTextField(
                            controller: controller.mobileConrtoller,
                            readOnly: true,
                            labelText: "رقم الهاتف",
                            labelTextStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                AppColors.blueDarkColor),
                            hintTextStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blueDarkColor),
                            // suffix: Padding(
                            //   padding:  EdgeInsets.all(12.0),
                            //   child: SvgPicture.asset("assets/svg/edit.svg",),
                            // ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your  phone'.tr;
                              }
                              return null;
                            },

                          )
                      ),
                      Container(
                          margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                          child:BasicTextField(
                            controller: controller.emailConrtoller,
                            labelText: "البريد الالكتروني",
                            labelTextStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                AppColors.blueDarkColor),
                            hintTextStyle: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: AppColors.blueDarkColor),
                            suffix: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset("assets/svg/edit.svg",),
                            ),
                             keyboardType: TextInputType.emailAddress,
                                validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your email'.tr;
                                      }
                                        else if (!emailRegExp.hasMatch(value)) {
                                        return 'Please enter a valid email address'.tr;
                                        }
                                         return null;
                                        },
                          )
                      ),

                      // Container(
                      //     margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                      //     child:BasicTextField(
                      //       readOnly: true,
                      //       // controller: controller.profilePictureConrtoller,
                      //       labelText: "إرفاق صورة",
                      //       labelTextStyle: TextStyle(
                      //           fontSize: 14,
                      //           fontWeight: FontWeight.w500,
                      //           color:
                      //           AppColors.blueDarkColor),
                      //       hintTextStyle: TextStyle(
                      //           fontSize: 10,
                      //           fontWeight: FontWeight.w400,
                      //           color: AppColors.blueDarkColor),
                      //       suffix: Padding(
                      //         padding: const EdgeInsets.all(12.0),
                      //         child: SvgPicture.asset("assets/svg/upload.svg",),
                      //       ),
                      //
                      //     )
                      // ),
                      Container(
                          margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                          child:BasicButton(
                            raduis: 8,
                            fontSize: 16,
                            label: "حفظ",
                            onPresed: ()async{
                            await controller.updataProfile();
                            },
                          )
                      ),
                    ],
                  ),
                )

          ),
        ),
      ),
    );
  }
}
