import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/module/setting/controller/setting_controller.dart';

class InviteFriendView extends GetView<SettingController> {
  const InviteFriendView({super.key});

  @override
  Widget build(BuildContext context) { 
    final size=MediaQuery.of(context).size;
  return Scaffold(
        appBar: AppBar(
          title: Text(
            "دعوة صديق",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.blueDarkColor,
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height*.3,
                    width: size.width,
                    margin: EdgeInsets.only(right: size.width*.1,left:   size.width*.1,top:size.height *.05, ),
                 child: SvgPicture.asset("assets/svg/invite friend illustration.svg"),
                  ),
                     Container(
                    width: size.width,
                    margin: EdgeInsets.only(right: size.width*.02,left:   size.width*.02,top:size.height *.01, ),
                 child: Text("دعوة",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: size.width*.02,left:   size.width*.02,top:size.height *.01, ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            child: Container(
                          height: size.height*.08,
                          width: size.width*.16,
                          decoration: BoxDecoration(
                            color:AppColors.darkWhiteColor,
                            shape: BoxShape.circle
                           ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset("assets/svg/whatsapp.svg"),
                            )

                           )),
                       GestureDetector(
                            child: Container(
                          height: size.height*.08,
                          width: size.width*.16,
                          decoration: BoxDecoration(
                            color:AppColors.darkWhiteColor,
                            shape: BoxShape.circle
                           ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset("assets/svg/messanger.svg"),
                            )

                           )),
                       GestureDetector(
                            child: Container(
                          height: size.height*.08,
                          width: size.width*.16,
                          decoration: BoxDecoration(
                            color:AppColors.darkWhiteColor,
                            shape: BoxShape.circle
                           ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset("assets/svg/instragram.svg"),
                            )

                           )),
                       GestureDetector(
                            child: Container(
                          height: size.height*.08,
                          width: size.width*.16,
                          decoration: BoxDecoration(
                            color:AppColors.darkWhiteColor,
                            shape: BoxShape.circle
                           ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset("assets/svg/copy link.svg"),
                            )
                           )),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(),
                  ListTile(
                    leading: CircleAvatar(
                      child: Image.asset("assets/images/person.png"),
                      // backgroundImage:AssetImage("assets/person.png"),
                    ),
                    title: Text(
                      "اسم المستخدم",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Container(
                      width: 60,
                      height: size.height*.05,
                      decoration: BoxDecoration(
                        color: AppColors.darkWhiteColor,
                        borderRadius: BorderRadius.circular(26)
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/svg/Check.svg"),
                      )
                    ),
                  )






               ]
            )));
  }
}
