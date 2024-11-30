import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_textfield.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../controller/setting_controller.dart';

class ComplaintDetailsView    extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    final locale=CommonVariables.langCode.read(LANG_CODE);
    return Scaffold(
      appBar:AppBar(

        title: Text("",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 17),),
        centerTitle: true,
        leading: IconButton(onPressed:() =>Get.back(),icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.blueDarkColor,
        ),),
      ),
      body:  SmartRefresher(
          controller:controller.refreshController,
          onRefresh: (){},
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.greyColor,
                ),
                title: Text(
                  "${controller.suggestionAndReplies.value.createdFullName}",
                  style: TextStyle(fontSize: 14,),
                ),
                subtitle:  Text(
                  timeago.format(DateTime.parse( controller.suggestionAndReplies.value.createAt!),locale: locale),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
               Container(
                 margin: EdgeInsets.only(right: size.width*.04,left:  size.width*.04),
                 child: Text(
                  controller.suggestionAndReplies.value.title!,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                               ),
               ),
              // Post Body (Markdown Supported)
              Container(
                  margin: EdgeInsets.only(right: size.width*.04,left:  size.width*.04),
                  child: MarkdownBody(data: controller.suggestionAndReplies.value.body!)
              ),
              // Replies Section
             if( controller.suggestionAndReplies.value.replies!.isNotEmpty)
               Container(
                margin: EdgeInsets.only(right: size.width*.04,left:  size.width*.04,top: size.height*.02),
                child: Text(
                  'Replies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )  else Center(child: Text("No Replies".tr),),
              SizedBox(height: size.height*.02),
              if( controller.suggestionAndReplies.value.replies!.isNotEmpty)
                Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.suggestionAndReplies.value.replies!.length,
                    itemBuilder: (context, index) {
                      final reply=controller.suggestionAndReplies.value.replies!.elementAt(index);
                      return Align(
                        alignment: reply.isFromAdmin == false ? Alignment.centerLeft : Alignment.centerRight,
                        child: Container(
                          width: size.width,
                          margin: EdgeInsets.symmetric(vertical: 1,),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:   Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Column(
                            crossAxisAlignment: !reply.isFromAdmin!
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Text(
                                reply.replyUserName!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:  Colors.black  ,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(reply.message!),
                              SizedBox(height: 5),
                              Text(
                                timeago.format(DateTime.parse(reply.createAt!),locale: locale),
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
            ],
          ),
        ) ,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Obx(
        ()=> Container(
          height: size.height * 0.1,
          padding: EdgeInsets.symmetric(horizontal: 10),
          color: Colors.white,
          child: BasicTextField(
            controller: controller.suggestionConrtoller,
            hintText: "الرجاء إدخال الرد هنا",
            hintTextStyle: TextStyle(
              fontSize: 12,
              color: AppColors.grayTransparenrColor,
            ),
            suffix:controller.isSendingReply?Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ):    IconButton(
              icon: Icon(Icons.send,color: AppColors.blueDarkColor,),
              onPressed: () {
               if( controller.suggestionConrtoller.text != "")
                 controller.addReply();
               },
            ),
          )
        ),
      ),
    );
  }
}


