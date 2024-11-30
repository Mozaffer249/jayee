import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/data/common/trip_item.dart';
import 'package:taxi_app/app/data/models/user_order.dart';
import 'package:taxi_app/app/module/my_trip/controllers/my_trips_controller.dart';

class MyTripView extends GetView<MyTripsController> {
  const MyTripView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => LoadingOverlay(
        isLoading:controller. isLoading.value,
        child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            title: Text(
              'الطلبات',
              style: TextStyle(
                  color: AppColors.blueDarkColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            backgroundColor: white,
            bottom: TabBar(
              controller: controller.tabController,
              labelColor:controller.tabController.index ==1 ?  AppColors.blueDarkColor:kMainColor,
              indicatorColor: controller.tabController.index == 1 ?  AppColors.blueDarkColor:kMainColor,
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: (x){
                controller.update();
            },
              tabs: [
                Tab(
                  text: 'قيد التنفيذ'.tr,
                ),
                
                Tab(text: 'مغلقة'.tr),
              ],
            ),
          ),
          body: Obx(() => TabBarView(
            controller: controller.tabController,
            children: [
          RefreshIndicator(
               onRefresh:()=> controller.getMyOrder(status: "open"),
               child:
               _buildCurrentTrip(context)
          ),
              controller.closeOrders.isEmpty?Container(
                child: Center(child: Text("Order not found"),),):
              RefreshIndicator(
                  onRefresh:()=> controller.getMyOrder(status: "close",isLoadingVal: RxBool(controller.isLoadingClose)),
                  child: _buildRecentTrip(context),
                color: AppColors.blueDarkColor,
              ),

            ],
          )
               )),
        ),
    );

  }
  Widget _buildCurrentTrip(BuildContext context) {
    return  controller.isLoadingClose ? ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => shimmerCard(context),
    ):   controller.openOrders.isEmpty?Container(
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty,color: AppColors.blueDarkColor,size: 80,),
            SizedBox(height: 30,),
            Text("No order found"),
          ],
        ))):
    ListView.builder(
        padding: EdgeInsets.only(bottom: 50),
        itemCount:controller.openOrders.length,
        itemBuilder: (context,index) {
          final order=controller.openOrders.elementAt(index);
          return TripListItem(order: order,onTap:()=> _showDeleteConfirmationDialog(context, order ),);
        }
    );
  }

  Widget _buildRecentTrip(BuildContext context) {
    return controller.isLoadingClose ? ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => shimmerCard(context),
    ):   controller.closeOrders.isEmpty?Container(
        child: Center(child: Text("Order not found"))) : ListView.builder(
        padding: EdgeInsets.only(bottom: 50,left: 8,right: 8),
        itemCount:controller.closeOrders.length,
        itemBuilder: (context,index) {
          final order=controller.closeOrders.elementAt(index);
          return TripListItem(order: order);
        }
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context, UserOrder?   order){
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor:AppColors.whiteColor,
           title: Text('Confirm Deletion',style: TextStyle(fontSize: 14),),
          content: Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: ()=> Get.back(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                controller.cncelOrderCustomer(order: order);
                // print(controller.openOrders.length);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
              ),
              child: Text('Delete',style: TextStyle(color: AppColors.whiteColor),),
            ),
          ],
        );
      },
    );
  }

  Widget shimmerCard(BuildContext context){
    final size = MediaQuery.of(context).size;

    return  Card(
       elevation: 4,
       child: Shimmer.fromColors(
         baseColor: Colors.grey.shade300,
         highlightColor: Colors.grey.shade100,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             // Top section shimmer
             Container(
               height: size.height * .05,
               margin: EdgeInsets.symmetric(
                 horizontal: size.width * .04,
                 vertical: size.height * .01,
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     height: size.height * 0.02,
                     width: size.width * .3,
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(8),
                     ),
                   ),
                   Container(
                     height: 14,
                     width: 60,
                     color: Colors.white,
                   ),
                 ],
               ),
             ),
             // Middle section shimmer
             Container(
               height: size.height * .21,
               margin: EdgeInsets.symmetric(
                 horizontal: size.width * .04,
                 vertical: size.height * .01,
               ),
               child: Row(
                 children: [
                   Column(
                     children: [
                       SizedBox(height: size.width * .1),
                       Container(
                         height: size.height * .03,
                         width: size.height * .03,
                         color: Colors.white,
                       ),
                       Container(
                         height: 60,
                         width: 1,
                         color: Colors.white,
                         margin: EdgeInsets.symmetric(vertical: 5),
                       ),
                       Container(
                         height: size.height * .03,
                         width: size.height * .03,
                         color: Colors.white,
                       ),
                     ],
                   ),
                   SizedBox(width: size.width * .04),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           height: 12,
                           width: double.infinity,
                           color: Colors.white,
                           margin: EdgeInsets.symmetric(vertical: 8),
                         ),
                         Container(
                           height: 12,
                           width: size.width * .5,
                           color: Colors.white,
                           margin: EdgeInsets.symmetric(vertical: 8),
                         ),
                         Divider(),
                         Container(
                           height: 12,
                           width: double.infinity,
                           color: Colors.white,
                           margin: EdgeInsets.symmetric(vertical: 8),
                         ),
                         Container(
                           height: 12,
                           width: size.width * .5,
                           color: Colors.white,
                           margin: EdgeInsets.symmetric(vertical: 8),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
             // Divider
             Container(
               margin: EdgeInsets.symmetric(
                 horizontal: size.width * .04,
                 vertical: size.height * .008,
               ),
               child: Divider(),
             ),
             // Bottom section shimmer
             Container(
               height: size.height * .05,
               margin: EdgeInsets.symmetric(
                 horizontal: size.width * .04,
                 vertical: size.height * .01,
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     height: size.height * 0.02,
                     width: size.width * .3,
                     color: Colors.white,
                   ),
                   Container(
                     height: 14,
                     width: 60,
                     color: Colors.white,
                   ),
                 ],
               ),
             ),
             SizedBox(height: size.height * .01),
           ],
         ),
       ),
     );
  }
}