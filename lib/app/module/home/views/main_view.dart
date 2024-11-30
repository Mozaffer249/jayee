import 'dart:ffi';

import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/module/add_payment_card/controller/add_payment_card_controller.dart';
import 'package:taxi_app/app/module/add_payment_card/view/add_payment_card_view.dart';
import 'package:taxi_app/app/module/home/controllers/home_controller.dart';
import 'package:taxi_app/app/module/home/views/home_view.dart';
import 'package:taxi_app/app/module/login/controllers/login_controller.dart';
import 'package:taxi_app/app/module/login/views/login_view.dart';
import 'package:taxi_app/app/module/my_trip/controllers/my_trips_controller.dart';
import 'package:taxi_app/app/module/my_trip/views/my_trip_view.dart';
import 'package:taxi_app/app/module/notifications/controller/notification_controller.dart';
import 'package:taxi_app/app/module/notifications/view/notification_view.dart';
import 'package:taxi_app/app/module/setting/controller/setting_controller.dart';
import 'package:taxi_app/app/module/setting/view/setting_view.dart';
import 'package:taxi_app/app/module/splash/controllers/splash_controller.dart';
import 'package:taxi_app/app/module/splash/views/splash_view.dart';
import 'package:taxi_app/app/module/wallet/controller/wallet_controller.dart';
import 'package:taxi_app/app/module/wallet/views/wallet_view.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => LoadingOverlay(
      isLoading: controller.isReLoading.value,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _getSelectedPage(controller.selectedIndex.value),
        floatingActionButton: _floatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    ));
  }

  Widget _getSelectedPage(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        Get.lazyPut(() => MyTripsController());
        return MyTripView();
      case 2:
        Get.lazyPut(() => NotificationController());
        return NotificationView();
      case 3:
        Get.lazyPut(() => SettingController());
        return SettingView();
      case 4:
        Get.lazyPut(() => WalletController());
        return WalletView();
      default:
        return HomeView();
    }
  }

  Widget _floatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.yellowColor, width: 2),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: FloatingActionButton(
          onPressed: () {
            // Change the selected index to the wallet index
            controller.onTabSelected(4); // 4 is the Wallet tab index
          },
          shape: CircleBorder(),
          backgroundColor: AppColors.blueDarkColor,
          child: SvgPicture.asset(
            controller.selectedIndex.value == 4
                ? "assets/svg/wallet.svg"
                : "assets/svg/wallet fill.svg",
          ),
          elevation: 4.0,
        ),
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return AnimatedBottomNavigationBar.builder(
      itemCount: 4,
      tabBuilder: (int index, bool isActive) {
        final iconPaths = [
          'assets/svg/home.svg',
          'assets/svg/orders.svg',
          'assets/svg/notification strock.svg',
          'assets/svg/Profile strok.svg',
        ];

        final selectedIconPaths = [
          'assets/svg/home.svg',
          'assets/svg/oeder fill.svg',
          'assets/svg/notification.svg',
          'assets/svg/Profile fill.svg',
        ];

        final icon = isActive ? selectedIconPaths[index] : iconPaths[index];

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: isActive ? AppColors.blueDarkColor : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              _getLabelForIndex(index),
              style: TextStyle(
                color: isActive ? AppColors.blueDarkColor : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        );
      },
      backgroundColor: AppColors.whiteColor,
      activeIndex: controller.selectedIndex.value,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,
      onTap: (index) => controller.onTabSelected(index),
    );
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Orders';
      case 2:
        return 'Notifications';
      case 3:
        return 'Profile';
      default:
        return '';
    }
  }
}


