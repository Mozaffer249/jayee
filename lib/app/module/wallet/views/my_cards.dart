import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';
import 'package:taxi_app/app/routes/app_pages.dart';

class MyCardsView extends GetView<WalletController> {
  const MyCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => LoadingOverlay(
        isLoading: controller.isRemovingCard,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "بطاقاتي",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
            ),
            centerTitle: true,
            actions: [
           if(controller.paymentCards.isNotEmpty)
             Padding(
               padding:  EdgeInsets.all(8.0),
               child: ElevatedButton.icon(
                  onPressed: ()async {
                    final result=await Get.toNamed(Routes.SAVE_PAYMENT_CARD);
                    controller.getPaymentCards();
                  },
                  icon: SvgPicture.asset("assets/svg/add.svg",color: AppColors.whiteColor,),
                  label: Text('Add Card',style:
                  TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: AppColors.whiteColor),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueDarkColor,
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Adjust the radius here
                    ),
                  ),
                ),
             ),
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: controller.isLoadingyMyCard
              ? shimmerList(context )
              :controller.paymentCards.isEmpty? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You don't have cards"),
                  SizedBox(height: 10,),
                  ElevatedButton.icon(
                    onPressed: ()async {
                      final result=await Get.toNamed(Routes.SAVE_PAYMENT_CARD);
                        controller.getPaymentCards();
                    },
                    icon: SvgPicture.asset("assets/svg/add.svg",color: AppColors.whiteColor,),
                    label: Text('Add Card',style:
                    TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: AppColors.whiteColor),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueDarkColor,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Adjust the radius here
                      ),
                    ),
                  ),
                ],
              )):
          ListView.builder(
              itemCount: controller.paymentCards.length,
              itemBuilder: (context, index) {
                var card = controller.paymentCards.elementAt(index);
                return
                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: _getBrandIcon(card.brand), // Display the brand icon based on the brand
                        title: Text('**************${card.cardLast4Digits}'), // Show the last 4 digits
                        subtitle: Text(card.brand ?? 'Unknown'), // Show the brand name or unknown
                        trailing: IconButton(onPressed: (){
                          _showDeleteConfirmationDialog(context,card.id!);
                        },
                          icon: Icon(Icons.delete_forever,color: AppColors.blueDarkColor,),
                        ), // Optional trailing icon
                      ),
                    ),
                  );
              }
          ),
        ),
      ),
    );
  }

  Widget _getBrandIcon(String? brand) {
    switch (brand?.toLowerCase()) {
      case 'visa':
        return SvgPicture.asset('assets/svg/visa.svg', width: 40,color: AppColors.blueDarkColor,); // Visa icon
      case 'mastercard':
        return SvgPicture.asset('assets/svg/mastercard.svg', width: 40); // MasterCard icon
      case 'amex':
        return SvgPicture.asset('assets/icons/amex.svg', width: 40); // Amex icon
      case 'discover':
        return SvgPicture.asset('assets/icons/discover.svg', width: 40); // Discover icon
      default:
        return Icon(Icons.credit_card, color: Colors.grey); // Default icon for unknown brands
    }
  }
  void _showDeleteConfirmationDialog(BuildContext context, int cardId ){
    showDialog(
       context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor:AppColors.whiteColor,
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
               controller.deleteCards(cardId: cardId);

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color for delete action
              ),
              child: Text('Delete',style: TextStyle(color: AppColors.whiteColor),),
            ),
          ],
        );
      },
    );
  }
  Widget shimmerList(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount:15, // Number of shimmer items
      itemBuilder: (context, index) {
        return  Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child:ListTile(
              leading: Container(
                width: 40,
                height: 40,
                color: Colors.white, // Placeholder for the leading icon
              ),
              title: Container(
                height: 10,
                width: double.infinity,
                color: Colors.white, // Placeholder for the title
              ),
              subtitle: Container(
                height: 10,
                width: 150,
                color: Colors.white, // Placeholder for the subtitle
              ),
            )
        );
      },
    );
  }

}

