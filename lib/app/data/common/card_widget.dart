import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';

class CardWidget extends StatelessWidget {

  final String userName;
  final double walletAmout;
  final double walletNumber;
  final Function()? onTap;

  CardWidget({required this.userName, required this.walletAmout, required this.walletNumber,required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      width: size.width*.95,
      height: size.height*.28,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF00103A), // Dark blue background color
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${userName}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: [
                SvgPicture.asset(
                  'assets/svg/master.svg', // Your VISA/MC logo
                ),
                SvgPicture.asset(
                  'assets/svg/visa.svg', // Your VISA/MC logo
                ),
              ],)
            ],
          ),
          SizedBox(height: 16),
          Text(
            '${walletNumber % 10000}**********',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              letterSpacing: 1.0,
            ),
          ),
          SizedBox(height: size.height*.04),
          Text(
            'الرصيد الحالي',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              '$walletAmout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
              ElevatedButton.icon(
                onPressed: onTap,
                icon: SvgPicture.asset("assets/svg/add.svg"),
                label: Text('أضف الى المحفظة',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: AppColors.blueDarkColor),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Adjust the radius here
                  ),
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
