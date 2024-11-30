import 'package:flutter/material.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                  value: false,
                  onChanged: (v) {},
                  fillColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return AppColors.blueDarkColor;
                    }
                    return AppColors.whiteColor;
                  })),
              Expanded(
                  child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.greyTransparentColor),
                    borderRadius: BorderRadius.circular(8)),
                height: size.height * .1,
                width: size.width * .8,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                  ),
                ),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(left: size.width*.04,right: size.width*.04),
                child: Text("11:12 ص",style: TextStyle(fontSize: 11,fontWeight: FontWeight.w400),),),
            ],
          )
        ],
      ),
    );
  }
}
