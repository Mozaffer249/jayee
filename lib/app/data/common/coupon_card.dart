import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:taxi_app/app/data/common/app_colors.dart'; // For formatting the date



class CouponCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'اسم الكوبون',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.blueDarkColor,
            ),
           ),
          SizedBox(height:size.height*.01),
          Text(
            'هذا النص هو مثال نص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: AppColors.blueDarkColor,
            ),
           ),
          SizedBox(height: size.height*.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/svg/coupon.svg"),
                  SizedBox(width: 4.0),
                  Text(
                    'خصم 15%',
                    style: TextStyle(
                      color:AppColors.yellowColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/svg/calender.svg"),
                  SizedBox(width: 4.0),
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime(2024, 9, 29)),
                    style: TextStyle(
                      color:AppColors.yellowColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/svg/calender.svg"),
                  SizedBox(width: 4.0),
                  Text(
                    DateFormat('dd-MM-yyyy').format(DateTime(2023, 9, 1)),
                    style: TextStyle(
                      color:AppColors.yellowColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
