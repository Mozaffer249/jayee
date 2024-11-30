import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/coupon_card.dart';
import 'package:taxi_app/app/module/setting/controller/setting_controller.dart';

class CouponsView extends GetView<SettingController> {
  const CouponsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("كوبون الخصم",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body: ListView.builder(
           itemCount: 7,
          itemBuilder: (context,index){
            return CouponCard();
          }
      ),
    );
  }
}
