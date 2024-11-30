import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/suggestion_card.dart';
import 'package:taxi_app/app/module/setting/controller/setting_controller.dart';
import 'package:taxi_app/app/routes/app_pages.dart';

class ComplaintListView extends GetView<SettingController> {
  const ComplaintListView({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar:AppBar(
        title: Text("Complaint".tr,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body: Obx(() {
        return LoadingOverlay(
          isLoading: controller.isReLoading.value,
          child:controller.isLoadingSuggestions?
          Center(child: CircularProgressIndicator(),): ListView.builder(
            itemCount: controller.suggestions.length,
            itemBuilder: (context, index) {
              final suggestion = controller.suggestions[index];
              return GestureDetector(
                onTap: ()=>controller.getSuggestionById(id: suggestion.id),
                child: SuggestionCard(
                 suggestion: suggestion,
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.whiteColor,
        onPressed: ()async{
          final result=await Get.toNamed(Routes.ADD_COMPLAINT);
          if(result!=null){
            controller.getSuggestions();
          }
        },
        child:SvgPicture.asset("assets/svg/add.svg"),
      ),
    );
  }
}
