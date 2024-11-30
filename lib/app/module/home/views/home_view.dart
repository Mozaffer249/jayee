import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/basic_textfield.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/data/common/dotted_line.dart';
import 'package:taxi_app/app/data/common/payment_card_option.dart';
import 'package:taxi_app/app/data/common/shimmer/provider_card_shimmer.dart';
import 'package:taxi_app/app/data/common/shimmer/select_place_shimmer.dart';
import 'package:taxi_app/app/data/common/vehicle_card.dart';
import 'package:taxi_app/app/data/models/cobon.dart';
import 'package:taxi_app/app/module/home/controllers/home_controller.dart';
import 'package:taxi_app/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() => LoadingOverlay(
          isLoading: controller.isLoading,
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: size.height * .1,
                      child: controller.isLoadingMap
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: GridView.builder(
                                padding: const EdgeInsets.all(16.0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      6, // Number of squares in a row
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 4.0, // Square aspect ratio
                                ),
                                itemCount: 400, // Number of squares to display
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 20,
                                    width: 20,
                                    color: Colors.white,
                                  );
                                },
                              ),
                            )
                          : (!controller.permissionGranted.value
                              ? Center(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: size.width * .02),
                                    child: BasicButton(
                                      raduis: 4,
                                      onPresed: () async {
                                        controller.mapOperation
                                            .checkLocationPermission(
                                                isFirstLaunch: false);
                                      },
                                      label: "Enable Services",
                                    ),
                                  ),
                                )
                              : GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target:
                                          controller.currentPosition.value ==
                                                  null
                                              ? LatLng(0, 0)
                                              : LatLng(
                                                  controller.currentPosition
                                                      .value!.latitude,
                                                  controller.currentPosition
                                                      .value!.longitude),
                                      zoom: 14),

                                  // myLocationEnabled: true,
                                  myLocationButtonEnabled: false,
                                  circles: controller.circles,
                                  markers: {

                                    controller.currentLocationMarkers.value!,
                                    if (controller.markerProvider.value != null)
                                      controller.markerProvider.value!,
                                    ..._getMarkers(),
                                    ...controller.driverMarkers,
                                  },
                                  onMapCreated: (GoogleMapController
                                      controllerMap) async {
                                    controller.myMapController = controllerMap;
                                  },
                                  zoomControlsEnabled: false,
                                  polylines:
                                      Set<Polyline>.of(controller.polylines),
                                ))),

                  // if (controller.currentPosition.value != null)
                  Positioned(
                    top:size.height * .05,
                    right:size.width * .04,
                    // left: size.width * .04,
                    child: FloatingActionButton(
                      onPressed: () async {
                        await controller.mapOperation
                            .checkLocationPermission(isFirstLaunch: false);
                      },
                      backgroundColor: AppColors.blueDarkColor,
                      child: Icon(
                        Icons.my_location,
                        color: AppColors.whiteColor,
                      ),
                      heroTag: "Testaa",
                    ),
                  )
                ],
              ),
              bottomSheet: controller.isLoadingOpenOrders &&
                      controller.permissionGranted.value
                  ? SelectPlacesSheetShimmer()
                  : buildBoyyomSheet(context)),
        ));
  }

  Widget buildBoyyomSheet(BuildContext context) {
    switch (controller.status.value) {
      case "selecting places":
        return buildSelectPlacesSheet(context);
      case "selecting vehicle":
        return buildSelectVehicleSheet(context);
      case "selecting payment":
        return buildSelectPaymentSheet(context);
      case "order details":
        return buildOrderDetailsAfterPaySheet(context);
      default:
        return buildSelectPlacesSheet(context);
    }
  }

  Widget buildSelectPlacesSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return !controller.permissionGranted.value
        ? Container(height: 0)
        : InteractiveBottomSheet(
            options: InteractiveBottomSheetOptions(
              initialSize: 0.5,
              maxSize: 0.5,
              backgroundColor: white,
              snapList: [0.5],

            ),
            draggableAreaOptions: DraggableAreaOptions(
              topBorderRadius: 30,
              height: 0,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: size.height * .3,
                  // color: AppColors.blackTransparenrColor,
                  margin: EdgeInsets.only(
                      right: size.width * .04,
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
                                    right: size.width * .03,
                                    left: size.width * .03),
                                child: CustomPaint(
                                  size: Size(1, 90),
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
                                          margin: EdgeInsets.only(
                                              right: 0, left: 0),
                                          child: BasicTextField(
                                            controller: TextEditingController(
                                                text: controller.placeOrigin
                                                        .value?.address ??
                                                    ''),
                                            labelText: "موقع الإستلام",
                                            onTap: () {
                                              controller.isSelectingOrigin =
                                                  true;
                                              print(
                                                  "***********${controller.isSelectingOrigin}");
                                              Get.toNamed(Routes.SELECT_ORIGIN);
                                            },
                                            readOnly: true,
                                            labelTextStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors
                                                    .greyTransparentColor),
                                            hintText: "الموقع الحالي",
                                            hintTextStyle: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                // color: AppColors.blueDarkColor
                                            ),
                                            // suffix: IconButton(
                                            //   onPressed: () {},
                                            //   icon: Icon(
                                            //     Icons.cancel,
                                            //   ),
                                            //   color: Colors.black26,
                                            // ),
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * .04),
                                      height: size.height * .04,
                                      width: 2,
                                      color: Colors.black26,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * .04,
                                            right: size.width * .01),
                                        child: SvgPicture.asset(
                                            "assets/svg/map select.svg"))
                                  ],
                                ),
                                SizedBox(height: size.height * .01),
                                Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              right: 0, left: 0),
                                          child: BasicTextField(
                                            controller: TextEditingController(
                                                text: controller
                                                        .placeDestination
                                                        .value
                                                        ?.address ??
                                                    ''),
                                            labelText: "موقع التوصيل",
                                            readOnly: true,
                                            onTap: () {
                                              controller.isSelectingOrigin =
                                                  false;
                                              print(
                                                  "***********${controller.isSelectingOrigin}");
                                              Get.toNamed(Routes.SELECT_ORIGIN);
                                            },
                                            labelTextStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors
                                                    .greyTransparentColor),
                                            hintText: "الموقع المراد الوصول له",
                                            hintTextStyle: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                // color: AppColors.blueDarkColor
                                            ),
                                            // suffix: IconButton(
                                            //   onPressed: () {
                                            //     controller.placeDestination(null);
                                            //   },
                                            //   icon: Icon(
                                            //     Icons.cancel,
                                            //   ),
                                            //   color: Colors.black26,
                                            // ),
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: size.height * .04),
                                      height: size.height * .04,
                                      width: 2,
                                      color: Colors.black26,
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: size.height * .04,
                                            right: size.width * .01),
                                        child: SvgPicture.asset(
                                            "assets/svg/map select.svg"))
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
                if (!controller.isLoadingPreviusPlaces &&
                    controller.previosPlaces.isNotEmpty)
                  Container(
                    margin: EdgeInsets.only(
                        right: size.width * .04,
                        left: size.width * .04,
                        top: size.height * .00),
                    child: Text(
                      "مواقع سبق و زرتها",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          // color: AppColors.blueDarkColor
                      ),
                    ),
                  ),
                controller.isLoadingPreviusPlaces
                    ? Container(
                        margin: EdgeInsets.only(top: size.height * .01),
                        height: size.height * .04,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  width: size.width * .3,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: size.height * .006),
                        height: size.height * .05, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.previosPlaces.length,
                          itemBuilder: (context, index) {
                            var place =
                                controller.previosPlaces.elementAt(index);
                            return GestureDetector(
                              onTap: () async {
                                // if (controller.markerOrigin.value != null){
                                controller.placeDestination.value = place;
                                controller.mapOperation.setDestinationMarker(
                                    LatLng(
                                        controller
                                            .placeDestination.value!.latitude!,
                                        controller.placeDestination.value!
                                            .longitude!));
                                controller.mapOperation.focusCameraOnMarkers();
                                controller.update();
                                // }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: controller.placeDestination.value == place
                                        ? AppColors.blueDarkColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.grey[300]!,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      place.address!.length > 15
                                          ? place.address!.substring(0, 15)
                                          : place.address!,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color:
                                            controller.placeDestination.value !=
                                                    place
                                                ? AppColors.blackColor
                                                : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                Container(
                  margin: EdgeInsets.all(size.width * .04),
                  child: BasicButton(
                    raduis: 8,
                    label: "التالي",
                    buttonColor: controller.mapOperation.checkPlaces()
                        ? AppColors.blueDarkColor
                        : AppColors.greyColor,
                    onPresed: controller.mapOperation.checkPlaces()
                        ? () async {
                            controller.getCarClassesWithPrices();
                          }
                        : null,
                  ),
                ),
                SizedBox(height: size.height * .04),
              ],
            ),
          );
  }

  Widget buildSelectVehicleSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InteractiveBottomSheet(
        options: InteractiveBottomSheetOptions(
          initialSize: 0.5,
          maxSize: 0.5,
          backgroundColor: white,
          snapList: [0.5],
        ),
        draggableAreaOptions: DraggableAreaOptions(
          topBorderRadius: 30,
          height: 0,
        ),
        child: Container(
            height: size.height * .5,
            padding: EdgeInsets.only(
                bottom: size.height * .07, top: size.height * .02),
            child: ListView.builder(
                itemCount: controller.carClasses.length,
                itemBuilder: (context, index) {
                  final carClass = controller.carClasses[index];
                  return VehicleSelectionList(
                      onTap: () {
                        controller.selectedCarClass = carClass;
                        controller.getPaymentCards();
                      },
                      carClass: carClass);
                })));
  }

  Widget buildSelectPaymentSheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InteractiveBottomSheet(
        options: InteractiveBottomSheetOptions(
          initialSize: 0.55,
          maxSize: 0.55,
          backgroundColor: white,
          snapList: [0.55],
        ),
        draggableAreaOptions: DraggableAreaOptions(
          topBorderRadius: 30,
          height: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Container(
              margin: EdgeInsets.only(
                  right: size.width * .04,
                  left: size.width * .04,
                  top: size.height * .03),
              child: Text(
                "إضافة كود الخصم إن وجد",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: size.width * .02,
                  left: size.width * .02,
                  top: size.height * .01),
              child: BasicTextField(
                controller: controller.cobonCode,
                onSubmit: (v) => controller.checkCobon(),
                prefix: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/svg/coupon.svg"),
                ),
                suffix: controller.isVerifyCobon
                    ? Container(
                        height: size.height * .04,
                        width: size.width * .06,
                        child: Center(
                            child: CircularProgressIndicator(
                          // color: AppColors.blueDarkColor,
                        )),
                      )
                    : IconButton(
                        onPressed: () {
                          controller.cobonCode.clear();
                          controller.cobon = Cobon();
                          controller.update();
                        },
                        icon: Icon(
                          Icons.cancel,
                        ),
                        color: Colors.black26,
                      ),
                hintText: "قم بإضافة كود الخصم إن وجد هنا",
                hintTextStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyTransparentColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: size.width * .04,
                  left: size.width * .04,
                  top: size.height * .03),
              child: Text(
                "إختر طريقة الدفع المناسبة لك",
                style: TextStyle(
                    // color: AppColors.blueDarkColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<int>(
                    value: 1,
                    groupValue: controller.paymentType.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.paymentType.value = value;
                        print(controller.paymentType.value);
                      }
                    },
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.blueDarkColor;
                      }
                      return AppColors.blueDarkColor;
                    })),
                Flexible(
                  child: Text(
                    'دفع كاش',
                    overflow: TextOverflow.visible, // Allow text to overflow
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio<int>(
                    value: 2,
                    groupValue: controller.paymentType.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.paymentType.value = value;
                        print(controller.paymentType.value);
                      }
                    },
                    fillColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.blueDarkColor;
                      }
                      return AppColors.blueDarkColor;
                    })),
                Flexible(
                  child: Text(
                    'دفع من البطاقة الائتمانية',
                    overflow: TextOverflow.visible, // Allow text to overflow
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(
                    right: size.width * .04,
                    left: size.width * .04,
                    top: size.height * .01),
                child: Divider()),
            if (controller.paymentType.value == 2 &&
                !controller.isWalletPaymentEnabled.value)
              Container(
                margin: EdgeInsets.only(
                    right: size.width * .04,
                    left: size.width * .04,
                    top: size.height * .03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "إختر بطاقة الدفع",
                      style: TextStyle(
                          // color: AppColors.blueDarkColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final result =
                            await Get.toNamed(Routes.SAVE_PAYMENT_CARD);
                        await controller.getPaymentCards();
                      },
                      icon: SvgPicture.asset(
                        "assets/svg/add.svg",
                        color: AppColors.whiteColor,
                      ),
                      label: Text(
                        'Add Card',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: AppColors.whiteColor),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueDarkColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8), // Adjust the radius here
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (controller.paymentType.value == 2 &&
                !controller.isWalletPaymentEnabled.value)
              Container(
                margin: EdgeInsets.only(top: size.height * .01),
                height: size.height * .06, // Adjust height as needed
                child: controller.paymentCards.isEmpty
                    ? Center(child: Text('لا يوجد بطاقات'))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.paymentCards.length,
                        itemBuilder: (context, index) {
                          return PaymentCardOption(
                            paymentCard: controller.paymentCards[index],
                            selected: controller.selectedPaymentCard ==
                                controller.paymentCards[index],
                            onTap: () => controller.selectedPaymentCard =
                                controller.paymentCards[index],
                          );
                        },
                      ),
              ),
            if (controller.paymentType.value == 2)
              Container(
                margin: EdgeInsets.only(
                    right: size.width * .04,
                    left: size.width * .04,
                    top: size.height * .01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "دفع من المحفظة",
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    Switch(
                      value: controller.isWalletPaymentEnabled.value,
                      onChanged: (val) {
                        controller.isWalletPaymentEnabled.value = val;
                      },
                      activeTrackColor: AppColors.blueDarkColor,
                    ),
                  ],
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              color: AppColors.yelloTransColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildPriceRow(context, "السعر",
                      "${controller.selectedCarClass.offerPrice}"),
                  buildPriceRow(context, "سعر الخصم",
                      "${controller.cobon.amount?.toStringAsFixed(2) ?? 0.0}"),
                  buildPriceRow(context, "السعر الإجمالي",
                      "${(controller.selectedCarClass.offerPrice ?? 0.0) - (controller.cobon.amount ?? 0)}"),
                  Container(
                    margin: EdgeInsets.all(size.width * .04),
                    child: BasicButton(
                      raduis: 8,
                      label: controller.paymentType.value == 1
                          ? "إرسال الطلب"
                          : "ادفع الآن",
                      onPresed: () {
                        controller.addOrder();
                        // showSuccessPaymeentBottomSheet(
                        //     context: context,
                        //     message: "تم تنفيذ العملية بنجاح",
                        //     buttonLabel: "تتبع الطلب",
                        //     onPresed:()
                        //     {
                        //       controller.status.value = "order details";
                        //       controller.update();
                        //       Get.back();
                        //     }
                        // );
                      },
                    ),
                  ),
                  SizedBox(height: size.height * .02),
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildOrderDetailsAfterPaySheet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var customerLocatioDescription =
        controller.orderDetails.customerDescriptionLocation!.length > 40
            ? controller.orderDetails.customerDescriptionLocation!
                .substring(0, 40)
            : controller.orderDetails.customerDescriptionLocation;
    var orderLocatioDescription =
        controller.orderDetails.orderDescriptionLocation!.length > 40
            ? controller.orderDetails.orderDescriptionLocation!.substring(0, 40)
            : controller.orderDetails.orderDescriptionLocation;
    return InteractiveBottomSheet(
        options: InteractiveBottomSheetOptions(
          initialSize: 0.4,
          maxSize: 0.4,
          backgroundColor: white,
          snapList: [0.4],

        ),
        draggableAreaOptions: DraggableAreaOptions(
          topBorderRadius: 30,
          height: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,


          children: [
            if (controller.orderDetails.providerData == null)
              Container(
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      // value: 0.7, // Example progress value
                      backgroundColor: AppColors.blueDarkColor,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.yellowColor),
                    ),
                    ProviderCardShimmer()
                  ],
                ),
              )
            else
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16))),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Container(
                          height: size.height * .05,
                          width: size.width * .1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: AppColors.whiteColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${controller.orderDetails.providerData!.profileImage}',
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Icons.error),
                              ),
                              fit: BoxFit
                                  .cover, // Adjusts the image to fit the container
                            ),
                          )),
                      title: Text(
                        "${controller.orderDetails.providerData!.fullName}",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: GestureDetector(
                        onTap: () async {
                          final phone =
                              controller.orderDetails.providerData!.phoneNumber;
                          if (await canLaunchUrl(Uri.parse('tel:${phone}')))
                            await launchUrl(Uri.parse('tel:${phone}'));
                        },
                        child: Container(
                            width: 40,
                            child: SvgPicture.asset("assets/svg/Call.svg")),
                      ),
                    ),
                  )),
            Container(
              height: size.height * .21,
              // color: AppColors.blackTransparenrColor,
              margin: EdgeInsets.only(
                  right: size.width * .04,
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
                                right: size.width * .03,
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
                                            child: Text(
                                              "موقع الإستلام",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .greyTransparentColor),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${customerLocatioDescription}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  // color:
                                                  //     AppColors.blueDarkColor
                                              ),
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
                                            child: Text(
                                              "${orderLocatioDescription}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  // color:AppColors.blueDarkColor
                                              ),
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
            // Bottom Section - Order Details
            Container(
              margin: EdgeInsets.only(
                  right: size.width * .04,
                  left: size.width * .04,
                  top: size.height * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (controller.selectedCarClass.icon != null)
                    Container(
                        height: size.height * .07,
                        width: size.width * .14,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: AppColors.whiteColor,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: '${controller.selectedCarClass.icon!}',
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Icons.error),
                              ),
                              fit: BoxFit
                                  .cover, // Adjusts the image to fit the container
                            ),
                          ),
                        )),
                  //  SvgPicture.asset("assets/svg/car.svg"),
                  Column(
                    children: [
                      Text(
                        "المسافة",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          // color: AppColors.blueDarkColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${double.parse(controller.orderDetails.distance!.toStringAsFixed(2))}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              // color: AppColors.blueDarkColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "KM",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              // color: AppColors.blueDarkColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "وقت الإقلاع",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          // color: AppColors.blueDarkColor,
                        ),
                      ),
                      Text(
                        "بعد 2 د",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          // color: AppColors.blueDarkColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "السعر",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          // color: AppColors.blueDarkColor,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${controller.orderDetails.orderAmount}",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              // color: AppColors.blueDarkColor,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "SAR".tr,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              // color: AppColors.blueDarkColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: size.width * .04,
                  left: size.width * .04,
                  top: size.height * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "حالة الطلب",
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.circle, color: Colors.orange, size: 12.0),
                      SizedBox(width: 5.0),
                      Text(
                        "${CommonVariables.langCode.read(LANG_CODE) == "ar" ? controller.orderDetails.statusStringAr : controller.orderDetails.statusString}",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  right: size.width * .04,
                  left: size.width * .04,
                  top: size.height * .04),
              child: BasicButton(
                raduis: 8,
                label: "إلغاء الطلب",
                onPresed: () {
                  _showDeleteConfirmationDialog(context);
                },
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: size.height * .05,
            )
          ],
        ));
  }

  Widget buildPriceRow(BuildContext context, String label, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,

          ),
          Row(
            children: [
              Text(
                price,

              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "SAR",

              ),
            ],
          ),
        ],
      ),
    );
  }

// Helper function to gather markers into a Set
  Set<Marker> _getMarkers() {
    final origin = controller.markerOrigin.value;
    final destination = controller.markerDestination.value;

    return {
      if (origin != null) origin,
      if (destination != null) destination,
    };
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // Prevent closing the dialog by tapping outside
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'Confirm Deletion',
            style: TextStyle(fontSize: 14),
          ),
          content: Text('Are you sure you want to delete?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                controller.cancelOrderCustomer();
                // print(controller.openOrders.length);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,

              ),
              child: Text(
                'Confirm',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
