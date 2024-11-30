import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/data/common/dotted_line.dart';
import 'package:taxi_app/app/data/models/user_order.dart';



class TripListItem extends StatelessWidget {
  final UserOrder  order;
  final  Function()? onTap;
  TripListItem({required this.order,this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 4,
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:size.height*.05 ,
            margin: EdgeInsets.only(
          right: size.width * .04,
          left: size.width * .04,
          top: size.height * .01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height:size.height*02,
                  width: size.width*.4,
                  decoration: BoxDecoration(
                      color:order.status =="Created"? AppColors.blueDarkColor:order.status=="Canceled From Customer"?AppColors.redColor: AppColors.greenColor,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(
                    child: Text("${CommonVariables.langCode.read(LANG_CODE) == "ar" ?order.statusAr: order.status!}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor),),
                  ),
                ),
                if(order.status =="Created")
                  ElevatedButton.icon(
                    onPressed:onTap,
                    icon: Icon(Icons.cancel,color: AppColors.blueDarkColor,),
                    label: Text('cancel',style:
                    TextStyle(fontWeight: FontWeight.w400,fontSize: 13,color: AppColors.blueDarkColor),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                      shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: AppColors.blueDarkColor)
                       ),
                    ),
                  )
               ],
            ),
          ),
          Container(
            height: size.height * .21,
            // color: AppColors.blackTransparenrColor,
            margin: EdgeInsets.only(
                right: size.width * .03,
                left: size.width * .04,
                top: size.height * .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.width * .1),
                        Container(
                            margin: EdgeInsets.only(right: 0, left: 0),
                            child: SvgPicture.asset(
                              "assets/svg/radio.svg",
                              height: size.height * .03,
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5,
                              right: size.width * .025,
                              left: size.width * .03),
                          child: CustomPaint(
                            size: Size(1, 60),
                            painter: DottedLinePainter(),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(right: 0, left: 0),
                            child: SvgPicture.asset(
                              "assets/svg/map.svg",
                              height: size.height * .03,
                            )),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin:
                                    EdgeInsets.only(right: 0, left: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("موقع الإستلام",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors
                                                    .greyTransparentColor),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${order.customerDescriptionLocation!.length> 40 ?order.customerDescriptionLocation!.substring(0,40):order.customerDescriptionLocation}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                AppColors.blueDarkColor),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * .009),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin:
                                    EdgeInsets.only(right: 0, left: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "موقع التوصيل",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors
                                                    .greyTransparentColor),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text("${order.orderDescriptionLocation!.length> 40 ?order.orderDescriptionLocation!.substring(0,40):order.orderDescriptionLocation}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color:
                                                AppColors.blueDarkColor),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                right: size.width * .02,
                left: size.width * .04,
                top: size.height * .001),
            child: Divider(),
          ),
          Container(
            height:size.height*.06 ,
            margin: EdgeInsets.only(
                right: size.width * .04,
                left: size.width * .04,
                top: size.height * .008),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height:size.height*02,
                  width: size.width*.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("${order.orderAmount}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueDarkColor
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text("SAR",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blueDarkColor
                        ),
                      )
                    ],
                  )
                ),
                Text("${CommonVariables.langCode.read(LANG_CODE) == "ar" ? order.dateAr:order.date}",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blueDarkColor
                  ),
                )
              ],
            ),
          ),
         ],
      ),
    );
  }
}
