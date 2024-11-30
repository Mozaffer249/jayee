import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/models/car_class.dart';


class VehicleSelectionList extends StatelessWidget {
  final VoidCallback onTap;
  final  CarClass   carClass ;
   VehicleSelectionList({required this.onTap, required this.carClass });



  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
  final  locale= Get.locale?.languageCode == 'ar' ? 'ar' : 'en';

    return  Container(
      color:   Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child:  Row(
        children: [
          Expanded(
            child: ListTile(
              onTap: onTap,
              leading:Container(
                  height: size.height*.07,
                  width: size.width*.14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: AppColors.whiteColor,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: CachedNetworkImage(
                      imageUrl: '${carClass.icon!}',
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error),
                      ),
                      fit: BoxFit.cover, // Adjusts the image to fit the container
                    ),
                  )
              ),
              title: Text(
                locale == 'ar' ? carClass.nameAr! :     carClass.name!,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  // color:  AppColors.blackColor,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "${carClass.distance!.toStringAsFixed(3)}",
                    style: TextStyle(
                        fontSize: 10.0,
                        color:  AppColors.greyTransparentColor,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "km".tr,
                    style: TextStyle(
                        fontSize: 14.0,
                        color:  AppColors.greyTransparentColor,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ) ,
              trailing: Container(
                width: size.width*.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("SAR",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color:  AppColors.greyTransparentColor,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      carClass.offerPrice.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color:  AppColors.yellowColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
