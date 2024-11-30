// bottomNavigationBar: BottomAppBar(
// shape: CircularNotchedRectangle(),
// color: Colors.white,
// elevation: 18,
// shadowColor: AppColors.blackTransparenrColor,
// notchMargin: 0.0,
// child: Container(
// height: 60.0,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: <Widget>[
// GestureDetector(
// onTap: () => controller.onTabSelected(0),
// child: Container(
// height: size.height*.1,
// width: size.width*.18,
// child: Padding(
// padding:  EdgeInsets.all(15.0),
// child:controller.selectedIndex.value==0 ? SvgPicture.asset( "assets/svg/home.svg",):Icon(Icons.home,color: Colors.black45,size:30,),
// ),
// ),
// ),
// GestureDetector(
// onTap: () => controller.onTabSelected(1),
// child: Container(
// height: size.height*.1,
// width: size.width*.18,
// child: Padding(
// padding:  EdgeInsets.all(15.0),
// child: controller.selectedIndex.value==1 ? SvgPicture.asset( "assets/svg/oeder fill.svg",):SvgPicture.asset( "assets/svg/orders.svg"),),
// ),
// ),
// // Space for the FAB
// Container(width: size.width*.1),
// GestureDetector(
// onTap: () => controller.onTabSelected(3),
// child: Container(
// height: size.height*.1,
// width: size.width*.18,
// child: Padding(
// padding:EdgeInsets.all(15.0),
// child:SvgPicture.asset(controller.selectedIndex.value==3 ?"assets/svg/notification.svg": "assets/svg/notification strock.svg",),
// ),
// ),
// ),
// GestureDetector(
// onTap:()=>  controller.onTabSelected(4),
// child: Container(
// height: size.height*.1,
// width: size.width*.18,
// child: Padding(
// padding: EdgeInsets.all(15.0),
// child: SvgPicture.asset(controller.selectedIndex.value==4 ?"assets/svg/Profile fill.svg": "assets/svg/Profile strok.svg",),
// ),
// ),
// )
// ],
// ),
// ),
// ),
//
