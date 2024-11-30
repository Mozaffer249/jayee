
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/module/auth/controllers/auth_controller.dart';


import '../../routes/app_pages.dart';

class BasicDrawer extends StatelessWidget {
  BasicDrawer({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();
  // final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return   Drawer(
      child: Column(
        children: [

          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                buildDrawerItem(title: 'Payment History', onPressed: () {}),
                buildDrawerItem(title: 'Ride History', onPressed: () {Get.toNamed(Routes.MY_TRIP);}, isVisible: true),
                buildDrawerItem(title: 'Payment cards', onPressed: () => Get.toNamed(Routes.ADD_PAYMENT_CARD)),
                buildDrawerItem(title: 'Promo Codes', onPressed: () {}),
                buildDrawerItem(title: 'Settings', onPressed: () {}),
                buildDrawerItem(title: 'Support', onPressed: () {}),
                buildDrawerItem(title: 'Log Out', onPressed: () {}),
              ],
            ),
          ),
          Spacer(),
          Divider(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                buildDrawerItem(
                    title: 'Do more',
                    onPressed: () {},
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.15),
                    height: 20),
                const SizedBox(
                  height: 20,
                ),
                buildDrawerItem(
                    title: 'Get food delivery',
                    onPressed: () {},
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.15),
                    height: 20),
                buildDrawerItem(
                    title: 'Make money driving',
                    onPressed: () {},
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.15),
                    height: 20),
                buildDrawerItem(
                  title: 'Rate us on store',
                  onPressed: () {},
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.15),
                  height: 20,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
  buildDrawerItem(
      {required String title,
        required Function onPressed,
        Color color = Colors.black,
        double fontSize = 14,
        FontWeight fontWeight = FontWeight.normal,
        double height = 45,
        bool isVisible = false}) {
    return SizedBox(
      height: height,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        // minVerticalPadding: 0,
        dense: true,
        onTap: () => onPressed(),
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: fontSize, fontWeight: fontWeight, color: color),
            ),
            const SizedBox(
              width: 5,
            ),
            isVisible
                ? CircleAvatar(
              backgroundColor: AppColors.yellowColor,
              radius: 15,
              child: Text(
                '1',
                style: TextStyle(color: Colors.white),
              ),
            )
                : Container()
          ],
        ),
      ),
    );
  }
  Widget buildListTileDrawer(String name, Function() onpressed, Color color) {
    return SizedBox(
      height: 50,
      child: ListTile(
        onTap: onpressed,
        title: Text(
          name.tr,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: color,
          ),
        ),
      ),
    );
  }
}
