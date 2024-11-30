import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/module/setting/controller/setting_controller.dart';
import 'package:taxi_app/app/routes/app_pages.dart';
import 'package:share_plus/share_plus.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return  Scaffold(
     appBar: AppBar(
   title: Text("البروفايل الشخصي",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
   centerTitle: true,
   actions: [
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: GestureDetector(
         onTap: ()async{
           final result=await Get.toNamed(Routes.PROFILE);
         },
         child: SvgPicture.asset("assets/svg/edit_profile.svg"),
       ),
     )
   ],
 ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top:size.height*.04),
                height: size.height*.1,
                width: size.width*.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: '${controller.authController.currentUser!.imagePath!}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error),
                      ),
                      fit: BoxFit.cover, // Adjusts the image to fit the container
                    ),
                  )
              
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top:size.height*.04),
                child: Text("${controller.authController.currentUser!.fullname!}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600),),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top:size.height*.01),
                child: Text("${controller.authController.currentUser!.email!}",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: AppColors.grayTransparenrColor),),
              ),
            ),
            Container(
              height: size.height*.065,
              margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.01),
              child: InkWell(
                onTap: () async {
                  final result=await Get.toNamed(Routes.Language_CHANGE);

                },
                child: Card(
                  elevation: 1,
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("اللغة",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                      SvgPicture.asset("assets/svg/Language.svg")
                    ],
                  ),
                ),
                ),
              ),
            ),
            Container(
              height: size.height*.065,
              margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.01),
              child: InkWell(
                onTap: ()async {
              final result = await Share.share('check out our app https://example.com');


              // Get.toNamed(Routes.INVITE_FRIEND)
                 },
                child: Card(
                  elevation: 1,
                child: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("دعوة صديق",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                      SvgPicture.asset("assets/svg/invite friend.svg")
                    ],
                  ),
                ),
                ),
              ),
            ),
            Container(
            height: size.height*.065,
            margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.01),
            child: InkWell(
              onTap: ()=>Get.toNamed(Routes.MY_CARDS,arguments: "my cards"),
              child: Card(
                elevation: 1,
              child: Padding(
                padding:  EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("بطاقاتي",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                    SvgPicture.asset("assets/svg/wallet fill.svg",color: AppColors.blueDarkColor,)
                  ],
                ),
              ),
              ),
            ),
          ),
            Container(
            height: size.height*.065,
            margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.01),
            child: InkWell(
              onTap: ()=>Get.toNamed(Routes.DISCOUNT_COUPON),
              child: Card(
                elevation: 1,
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("كوبونات الخصم",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                    SvgPicture.asset("assets/svg/coupon.svg")
                  ],
                ),
              ),
              ),
            ),
          ),
            Container(
            height: size.height*.065,
            margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.01),
            child: GestureDetector(
              onTap: ()=>Get.toNamed(Routes.COMPLAINT_LIST),
              child: Card(
                elevation: 1,
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("تقديم الشكاوي",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                    SvgPicture.asset("assets/svg/report.svg")
                  ],
                ),
              ),
              ),
            ),
          ),
            Container(
            height: size.height*.065,
            margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.01),
            child: Card(
              elevation:1,
            child: Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("الدعم الفني",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                  SvgPicture.asset("assets/svg/support.svg")
                ],
              ),
            ),
            ),
          ),
            Container(
            height: size.height*.065,
            margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.01),
            child: GestureDetector(
              onTap: ()=>controller.authController.logout(),
              child: Card(
                elevation: 1,
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("تسجيل الخروج",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                    SvgPicture.asset("assets/svg/Logout.svg")
                  ],
                ),
              ),
              ),
            ),
          ),
            SizedBox(height: size.height*.05)
          ],
        ),
      ),
    );
  }
}
