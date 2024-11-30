import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';
import 'package:taxi_app/app/routes/app_pages.dart';

class SelectCardTypeView extends GetView<WalletController> {
  const SelectCardTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("وسيلة الدفع",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          ()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'قم بإختيار وسيلة المناسبة لك',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              buildPaymentOption(
                'creditCard',
                'credit Card',
                'assets/svg/master.svg',
              ),
              buildPaymentOption(
                'mada',
                'مدى',
                'assets/svg/madaPay.svg',
              ),
              buildPaymentOption(
                'paypal',
                'باي بال',
                'assets/svg/paypal.svg',
              ),
             Container(
               margin: EdgeInsets.only(top: size.height*.02),
               child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(Routes.PAYMENT_CARD_DETAILS);
                    },
                    icon: SvgPicture.asset("assets/svg/add.svg",color:AppColors.whiteColor ,),
                    label: Text('أضف بطاقة',
                      style: TextStyle(
                        fontSize: 17,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500
                    ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueDarkColor, // Dark blue color
                       padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: AppColors.grayTransparenrColor),
                      ),
                    ),
                  ),
             ),

            ],
          ),
        ),
      ),
    );
  }
  Widget buildPaymentOption(String value, String title, String logoPath) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          trailing : Radio<String>(
            value: value,
            groupValue:controller.selectedPaymentMethod.value,
            onChanged: (String? newValue) {
                 controller.selectedPaymentMethod.value = newValue!;
                 controller.update();
            },
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.blueDarkColor;
              }
              return AppColors.greyColor;
            })
          ),
          title: Text(title),
          leading  : Padding(
            padding:EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              logoPath,
               width: 26,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}
