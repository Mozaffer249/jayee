
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/module/add_payment_card/controller/add_payment_card_controller.dart';


class AddPaymentCardView extends GetView<AddPaymentCardController> {
  const AddPaymentCardView({super.key});
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("المحفظة",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
          centerTitle: true,
          leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.blueDarkColor,
          ),),
        ),
         resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: size.height*.02,right: size.width*.04,left: size.width*.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الرصيد المتاح',
                    style: TextStyle(
                      color: AppColors.blueDarkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '\$5000',
                    style: TextStyle(
                      color: AppColors.blueDarkColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: size.height*.02,right: size.width*.04,left: size.width*.04),
            //     child: CardWidget()),
          ],
        ),
    );
  }
  void onCreditCardModelChange(CreditCardModel? creditCardModel) {

    controller.  cardNumber.value = creditCardModel!.cardNumber;
     controller. expiryDate .value= creditCardModel.expiryDate;
     controller. cardHolderName.value = creditCardModel.cardHolderName;
     controller. cvvCode.value = creditCardModel.cvvCode;
     controller. isCvvFocused.value = creditCardModel.isCvvFocused;
    controller.update();

  }

}
