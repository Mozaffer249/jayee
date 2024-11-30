import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/constants.dart';

class BasicAppBar extends StatelessWidget implements  PreferredSizeWidget {
  const BasicAppBar({
    required this.title,
    Key? key,
    this.actions,
  }) : super(key: key);

  final String title;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.0,
      child: AppBar(
        toolbarHeight: 110.0,
        backgroundColor: kMainColor,
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          child: Image.asset('assets/images/imageAppBar.png'),
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text(title.tr,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        actions: actions,
      ),
    );
  }
}
