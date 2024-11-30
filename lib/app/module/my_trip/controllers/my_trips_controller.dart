import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/models/user_order.dart';
import 'package:taxi_app/app/provider/order/order_provider.dart';
import 'package:taxi_app/app/utils/dialog_utils.dart';


class MyTripsController extends GetxController  with GetSingleTickerProviderStateMixin{
  late TabController tabController;
  RxBool _isLoadingClose=true.obs;
  bool get isLoadingClose => _isLoadingClose.value;

  RxBool _isLoadingOpen=true.obs;
  bool get isLoadingOpen => _isLoadingOpen.value;
  RxBool _isLoading=false.obs;
  RxBool get isLoading => _isLoading;

  RxBool isReLoading=false.obs;

  RxList<UserOrder>_closeOrders=<UserOrder>[].obs;
  List<UserOrder> get closeOrders => _closeOrders.value;

  RxList<UserOrder>_openOrders=<UserOrder>[].obs;
  List<UserOrder> get openOrders => _openOrders.value;

  @override
  void onInit()async {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
    update();
    });
    await getMyOrder(status: "open",isLoadingVal: _isLoadingOpen);
    await getMyOrder(status: "close",isLoadingVal: _isLoadingClose);
  }

Future<void> getMyOrder({String? status, RxBool? isLoadingVal })async{
  isLoadingVal!.value =true;
  final result=await OrderProvider.getMyOrders(status: status);
    isLoadingVal.value=false;

  result.fold((l){
    if(status =="open"){
    _openOrders(l);
    }
    else{
    _closeOrders(l);
    }
    update();
  }, (r){
    showSnackbar(title: "", message: r);
  });
}
Future<void>cncelOrderCustomer({UserOrder? order })async{
  _isLoading(true);
  final result=await OrderProvider.cancelOrderCustomer(orderId: order!.id!);
  _isLoading(false);
       result.fold((l) {
         if(l ==true)   {
             openOrders.remove(order);
            update();
         }
          },
          (r) {
        if(r=="The Order Has Been Canceled".tr||r=="Connection error"  )
          showSnackbar(title: "", message: r,isError: true);
      }
  );

}
}