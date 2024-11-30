
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/card_widget.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';
import 'package:taxi_app/app/routes/app_pages.dart';
import 'package:timeago/timeago.dart' as timeago;


class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المحفظة",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
        ),
        centerTitle: true,

      ),
      resizeToAvoidBottomInset: false,
      body: Obx(
            ()=> Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  top: size.height * .02,
                  right: size.width * .04,
                  left: size.width * .04),
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
                controller.isLoading?
                Shimmer.fromColors(
                    child: Container(
                      width: 50,
                      height: 20,
                      color: Colors.white,
                    ),        baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,):
                Text(
                    '${controller.walletSum.value}',
                    style: TextStyle(
                      color: AppColors.blueDarkColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(
                    top: size.height * .02,
                    right: size.width * .04,
                    left: size.width * .04),
                child:controller.isLoading?CardShimer(context):
                CardWidget(
                  userName:"اسم المستخدم",
                  walletAmout:controller.walletSum.value  ,
                  walletNumber:3629486445645,
                  onTap: ()async{
                    final result=await Get.toNamed(Routes.ADD_TO_WALLET);
                    if(result != null)
                      controller.getCustomerWallet();
                  },
                )),
            controller.isLoading
                ? Expanded(child: shimmerList())
                : Expanded(
                    child: ListView.builder(
                      itemCount: controller.customerTransaction.value
                          .customerWalletTransaction!.length,
                      itemBuilder: (context, index) {
                        var transactions = controller
                            .customerTransaction.value.customerWalletTransaction!
                            .elementAt(index);
                        return TransactionListItem(
                          amount: transactions.amount!,
                          destination: transactions.note!,
                          date: transactions.createAt!,
                          carIcon:
                              Icons.directions_car, // Adjust the icon as needed
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget TransactionListItem({
    required double amount,
    required String destination,
    required String date,
    required IconData carIcon,
  }) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8.0),
      child:
      ListTile(

        leading: SvgPicture.asset("assets/svg/car.svg" ),
        title: Text(
          destination,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color:  AppColors.blueDarkColor,
          ),
        ),

        subtitle: Text(
          "${timeago.format(DateTime.parse(date), locale: CommonVariables.langCode.read(LANG_CODE)??"ar" )}",
          style: TextStyle(
              fontSize: 14.0,
              color: AppColors.greyTransparentColor,
              fontWeight: FontWeight.w400
          ),
        ) ,
        trailing: Text(
          "${amount}",
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            color:  AppColors.blueDarkColor,
          ),
        ),
      )


    );
  }

  Widget shimmerList() {
    return ListView.builder(
      itemCount: 5, // Number of shimmer items
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget CardShimer(BuildContext context)
  {
    var size =MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: size.width,
        height: size.height*.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
