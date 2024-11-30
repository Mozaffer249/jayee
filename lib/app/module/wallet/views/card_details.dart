import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/basic_textfield.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';
import 'package:taxi_app/app/utils/dialog_utils.dart';

class CardDetailsView extends GetView<WalletController> {
  const CardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;

    return  Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل البطاقة",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: size.height*.02,
                left: size.width*.04,
                right: size.width*.04
              ),
              child: Card(
              child: ListTile(
                trailing : Radio<String>(
                    value: "",
                    groupValue:"",
                    onChanged: (String? newValue){},
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.blueDarkColor;
                      }
                      return AppColors.greyColor;
                    })
                ),
                title: Text(controller.selectedPaymentMethod.value),
                leading  : Padding(
                  padding:EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/svg/master.svg",
                    width: 26,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),),
            Container(
                margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                child:BasicTextField(
                  labelText: "اسم البطاقة",
                  hintText: "الرجاء إدخال اسم البطاقة",
                  labelTextStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                      AppColors.blueDarkColor),
                  hintTextStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor),
                )
            ),
            Container(
                margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                child:BasicTextField(
                  labelText: "رقم البطاقة",
                  hintText: "الرجاء إدخال رقم البطاقة",
                  labelTextStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                      AppColors.blueDarkColor),
                  hintTextStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor),
                )
            ),
            Container(
                margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                child:BasicTextField(
                  labelText: "تاريخ الانتهاء",
                  hintText: "الرجاء ادخال تاريخ الانتهاء (MM / YY)",
                  labelTextStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                      AppColors.blueDarkColor),
                  hintTextStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor),
                )
            ),
            Container(
                margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
                child:BasicTextField(
                  labelText: "رمز التحقق",
                  hintText: "الرجاء ادخال رمز التحقق",
                  labelTextStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                      AppColors.blueDarkColor),
                  hintTextStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor),
                )
            ),
            Container(
              margin: EdgeInsets.only(
                  right: size.width * .04,
                  left: size.width * .04,
                  top: size.height * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "حفظ تفاصيل البطاقة",
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Switch(
                    value: true,
                    onChanged: (val) {},
                    activeTrackColor: AppColors.blueDarkColor,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:  size.width * .1,right: size.width * .04,left: size.width * .04),
              child: BasicButton(
                raduis: 8,
                label: "شحن الآن",
                onPresed: () {
                  showSuccessPaymeentBottomSheet(
                      context: context,
                      message: "تم تنفيذ العملية بنجاح",
                       buttonLabel: "الرئيسية",
                      onPresed: () {
                        Get.back();
                        Get.back();
                        Get.back();
                        Get.back();
                        }
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
