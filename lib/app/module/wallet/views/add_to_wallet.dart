import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';
import 'package:taxi_app/app/routes/app_pages.dart';

class AddToWalletView extends GetView<WalletController> {
  const AddToWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("إضافة للمحفظة",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height*.03,right: size.width*.04,left: size.width*.04),
              child: Text(
                'أدخل المبلغ الذي تريد إضافته إلى المحفظة',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blueDarkColor
                ),
              ),
            ),
            SizedBox(height: size.height*.02),
            Container(
              margin: EdgeInsets.only(top: size.height*.01,right: size.width*.04,left: size.width*.04),
              width: size.width,
              height: size.height*.1,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.yellowColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                ()=> Center(
                  child: Text(
                    '${controller.amountToAdd.value}\$',
                    style: TextStyle(
                      color: Color(0xFF00103A),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            Container(
              margin: EdgeInsets.only(top: size.height*.01,right: size.width*.04,left: size.width*.04),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 2.5,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildAmountButton(10),
                  buildAmountButton(20),
                  buildAmountButton(30),
                  buildAmountButton(40),
                  buildAmountButton(50),
                  buildAmountButton(60),
                  buildAmountButton(100),
                  buildAmountButton(200),
                  buildAmountButton(300),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height*.06,right: size.width*.04,left: size.width*.04),
              child: BasicButton(
                fontSize: 17,
                label: "التالي",
                raduis: 8,
                onPresed: ()async{
                  final result=await  Get.toNamed(Routes.ADD_TO_WALLET_WEB_VIEW);
                  Get.back(result: true);
                } ,
              ),
            )

          ],
        ),

    );
  }
  Widget buildAmountButton(int amount) {
    return ElevatedButton(
      onPressed: () {
        controller.amountToAdd.value=amount;
        controller.update();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,


        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors.grayTransparenrColor),
        ),
      ),
      child: Text("${amount}\$",style: TextStyle(
        fontSize: 17,
        color: AppColors.blueDarkColor,
        fontWeight: FontWeight.w500
      ),),
    );
  }
}
