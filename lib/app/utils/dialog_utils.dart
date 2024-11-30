 import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';

Future<void> showSnackbar({
  required String? title,
  required String message,
  bool isError = false,
}) async {
  Get.showSnackbar(GetSnackBar(
    message: message,
    title: title,
    isDismissible: true,
    overlayBlur: 2,
    backgroundColor: isError ? Colors.red : Color(0xFF303030),
    snackStyle: SnackStyle.FLOATING,
    duration: Duration(seconds: 3),
  ));
}
 void  showSuccessPaymeentBottomSheet(
     {required BuildContext context,
       required String message,
   required String buttonLabel,
   required  Function()? onPresed}
     ){
   final size = MediaQuery.of(context).size;
   showModalBottomSheet(
     context: context,
     backgroundColor: Colors.transparent,
     isDismissible: false,
     enableDrag: false,
     builder: (context) => WillPopScope(
       onWillPop: () async {
         // Prevent the bottom sheet from closing on back button press
         return Future.value(false);
       },
       child: Container(
           height: size.height * .5,
           width: size.width,
           decoration: BoxDecoration(
               color: AppColors.whiteColor,
               borderRadius: BorderRadius.only(
                   topRight: Radius.circular(16),
                   topLeft: Radius.circular(16))),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 margin: EdgeInsets.only(
                     right: size.width * .04,
                     left: size.width * .04,
                     top: size.height * .01),
                 child: Text(
                   "النجاح",
                   style: TextStyle(
                       color: AppColors.blueDarkColor,
                       fontSize: 16,
                       fontWeight: FontWeight.w500),
                 ),
               ),
               Container(
                   margin: EdgeInsets.only(
                       right: size.width * .04,
                       left: size.width * .04,
                       top: size.height * .01),
                   child: Divider()),
               Center(
                 child: SvgPicture.asset("assets/svg/success.svg"),
               ),
               Center(
                 child: Text(message,
                   style: TextStyle(
                       color: AppColors.blueDarkColor,
                       fontSize: 16,
                       fontWeight: FontWeight.w500),
                 ),
               ),
               Container(
                 margin: EdgeInsets.only(
                     right: size.width * .04,
                     left: size.width * .04,
                     top: size.height * .1),
                 child: BasicButton(
                   raduis: 8,
                   label:buttonLabel,
                   onPresed: onPresed
                 ),
               )
             ],
           )),
     ),
   );
 }

Future<T?> showConfirmationDialog<T>({
  String? msg,
  Widget? icon,
  List<Widget>? actions,
  bool dismissible = true,
}) async {
  final result = await Get.defaultDialog<T>(
    radius: 8,
    title: '',
    backgroundColor:Colors.white,
    titleStyle: const TextStyle(
      fontSize: 0,
    ),
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    actions: actions,
    // backgroundColor: Colors.white,
    barrierDismissible: dismissible,
    content: Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: icon ?? Icon(Icons.warning, color: Colors.white,)),
            SizedBox(height: 20),
            Text(msg ?? 'Warning'.tr,
              style: Get.theme.textTheme.titleMedium,
            ),
            SizedBox(height: 24),
          ],
        ),
      ],
    ),
  );
  return result;


}

// UpdateDialog(){
//   showDialog(
//     context: Get.context!,
//     barrierDismissible: false, // <-- Set this to false.
//     builder: (_) => WillPopScope(
//       onWillPop: () async => false, // <-- Prevents dialog dismiss on press of back button.
//       child: AlertDialog(
//         title: Text("Update Message".tr),
//         actions: [
//           BasicButton(
//             onPresed:( )async{
//               await  launch("https://play.google.com/store/apps/details?id=com.moggal.tab3");
//             },
//             label: "Update".tr,
//
//
//           )
//         ],
//       ),
//     ),
//   );
// }


enternetConnectioDialog(){
  Get.defaultDialog(
    title: "No internet connection".tr,
    content: Center(child: Icon(Icons.network_check_outlined,size: 28,)),
    textCancel: 'cancel',
    onCancel: () {Get.back();},
  );
}