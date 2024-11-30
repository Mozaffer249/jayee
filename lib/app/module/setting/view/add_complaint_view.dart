import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/basic_textfield.dart';
import 'package:taxi_app/app/module/setting/controller/setting_controller.dart';

class AddComplaintView extends GetView<SettingController> {
  const AddComplaintView({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        title: Text("تقديم شكوى",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body: Obx(()
        => LoadingOverlay(
          isLoading: controller.isReLoading.value,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                //   child: BasicTextField(
                //     labelText: "نوع الشكوى",
                //     labelTextStyle: TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w500,
                //         color:
                //         AppColors.blueDarkColor),
                //     hintText: "الرجاء إدخال نوع الشكوى هنا",
                //     hintTextStyle: TextStyle(
                //         fontSize: 10,
                //         fontWeight: FontWeight.w400,
                //         color: AppColors.blueDarkColor),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                  child: BasicTextField(
                    controller: controller.complaintTitleConrtoller,
                    labelText: "عنوان الشكوى",
                    labelTextStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color:
                        AppColors.blueDarkColor),
                    hintText: "الرجاء إدخال عنوان الشكوى هنا",
                    hintTextStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor),

                  ),


                ),

                Container(
                  margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                  child:
                  TextField(
                    controller: controller.complaintBodyConrtoller,
                    decoration: InputDecoration(
                       labelStyle: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color:
                          AppColors.blueDarkColor),
                      hintText: "الرجاء إدخال عنوان الشكوى هنا",
                      hintStyle:  TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: AppColors.grayTransparenrColor),
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.greyTransparentColor, // Color when the TextFormField is enabled but not focused
                          width: 1.0, // Width of the border
                        ),
                        borderRadius: BorderRadius.circular(8.0), // Optional: Adjust the border radius
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grayTransparenrColor),
                      ),
                    ),
                    style: TextStyle(fontSize: 16),
                    maxLines: 5,
                    minLines: 5,
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                //   child: BasicTextField(
                //     labelText: "إضافة مرفق",
                //     readOnly: true,
                //     labelTextStyle: TextStyle(
                //         fontSize: 14,
                //         fontWeight: FontWeight.w500,
                //         color:
                //         AppColors.blueDarkColor),
                //     hintText: "الرجاء إضافة مرفق إن وجد",
                //     hintTextStyle: TextStyle(
                //         fontSize: 10,
                //         fontWeight: FontWeight.w400,
                //         color: AppColors.blueDarkColor),
                //     suffix: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: SvgPicture.asset("assets/svg/upload.svg"),
                //     ),
                //   ),
                // ),
                Container(
                    margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.04),
                    child:BasicButton(
                      raduis: 8,
                      label: "إرسال شكوى",
                      fontSize: 16,
                      onPresed: ()async{

                       await controller.addComplaint();
                      },
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
