import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/basic_textfield.dart';
import 'package:taxi_app/app/module/setting/controller/setting_controller.dart';

class LangaugeChangeView extends GetView<SettingController> {
  const LangaugeChangeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return   Scaffold(
      appBar: AppBar(
        title: Text("لغة التطبيق",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
              child:BasicTextField(
                hintText: "اللغة التي تبحث عنها",
                labelTextStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyTransparentColor),
                prefix: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.search,color: AppColors.blueDarkColor,),
                ),

              )
          ),

          Container(
              width: size.width,
              margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
              child: ExpandablePanel(
                header: Container(
                  height: size.height*.07,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(8))

                    ),
                    child: Padding(
                      padding:  EdgeInsets.all(12.0),
                      child: Text("العربية",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: AppColors.blueDarkColor),),
                    )
                ),
                collapsed:Container(),
                expanded: Container(
                  height: size.height*.2,
                  width: size.width,
                  child: Card(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("العربية", softWrap: true,style: TextStyle(
                        fontWeight: FontWeight.w500,fontSize: 12,color: AppColors.blueDarkColor
                    ) ),
                          Radio(value: true,
                              groupValue: true,
                              onChanged: (v){},
                              fillColor: WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.selected)) {
                                  return AppColors.blueDarkColor;
                                }
                                return AppColors.blueDarkColor;
                              }))
                        ],
                      ),
                      Container(
                         child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("English", softWrap: true,style: TextStyle(
                            fontWeight: FontWeight.w500,fontSize: 12,color: AppColors.blueDarkColor
                          ), ),
                          Radio(
                              value: false,
                              groupValue: true,
                              onChanged: (v){},
                              fillColor: WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.selected)) {
                                  return AppColors.blueDarkColor;
                                }
                                return AppColors.blueDarkColor;
                              }))
                        ],
                      ),
                    ],),
                  ),
                ),
              )
          ),
          Container(
              margin: EdgeInsets.only(right: size.width*.04,left: size.width*.04,top: size.height*.02),
              child:BasicButton(
                raduis: 8,
                label: "حفظ",
                fontSize: 16,
                onPresed: (){},
              )
          ),

        ],
        ),
      ),
    );
  }
}
