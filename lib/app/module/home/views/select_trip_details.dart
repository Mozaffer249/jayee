import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taxi_app/app/data/common/basic_button.dart';
import 'package:taxi_app/app/data/common/cancle_trip_dialog.dart';
import 'package:taxi_app/app/data/common/constants.dart';
import 'package:taxi_app/app/data/common/driver%20_card.dart';
import 'package:taxi_app/app/module/home/controllers/home_controller.dart';

class SelectTripDetailsView extends GetView<HomeController> {
  const SelectTripDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() => LoadingOverlay(
      isLoading: controller.isReLoading.value,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(controller.placeOrigin.value!.latitude!, controller.placeOrigin.value!.longitude!),
                    zoom: 14.0,
                  ),
                  zoomControlsEnabled: false,
                  myLocationEnabled: false,
                  onMapCreated: (GoogleMapController controllerMap) async {

                    },
                  markers:{
                    Marker(markerId:MarkerId("o",),
                      position: LatLng(controller.placeOrigin.value!.latitude!, controller.placeOrigin.value!.longitude!),
                      icon: controller.originIcon.value!,

                    ),
                    Marker(markerId:MarkerId("d",),
                        position: LatLng(controller.placeDestination.value!.latitude!, controller.placeDestination.value!.longitude!),
                        icon:  controller.destinationIcon.value!
                    ),
                    ...controller.carMarkers
                  }  ,
                  polylines:controller.polylines,
                )),

           ],
        ),
        bottomSheet:controller.status.value== "" ?
        InteractiveBottomSheet(
          options: InteractiveBottomSheetOptions(
            initialSize: 0.5,
            maxSize: 0.5,
            minimumSize: 0.25,
            // backgroundColor: Colors.green,
            snapList: [0.25,0.5],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRideConfirmationSheet(),
              Padding(
                padding:   EdgeInsets.all(size.height*.01),
                child: BasicButton(
                  label: "Confirm",
                  raduis: 4,
                  onPresed: (){
                    controller.status.value=  "confirmed" ;
                    controller.update();
                  },
                ),
              )
            ],
          ),
        ) :
        controller.status.value=="confirmed" ?
        InteractiveBottomSheet(
          options: InteractiveBottomSheetOptions(
            initialSize: 0.3,
            maxSize: 0.4,
            minimumSize: 0.3,
            // backgroundColor: Colors.green,
            snapList: [0.3,0.4],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*.01,),

              Padding(
                padding: EdgeInsets.all(size.height*.01),
                child: Row(
                  children: [
                    Icon( Icons.location_on_outlined,color: kMainColor,) ,
                    Text("${controller.placeOrigin.value!.address != null &&
                          controller.placeOrigin.value!.address!.length >= 25 ?
                          controller.placeOrigin.value!.address!.substring(0,25):controller.placeOrigin.value!.address
                    }"),
                  ],
                )
              ),
              SizedBox(height: size.height*.01,),
              Padding(
                  padding: EdgeInsets.all(size.height*.01),
                  child: Row(
                    children: [
                      Icon( Icons.location_on_outlined,color: kMainColor,) ,
                      Text("${controller.placeDestination.value!.address != null &&
                          controller.placeDestination.value!.address!.length >= 25 ?
                      controller.placeDestination.value!.address!.substring(0,25):controller.placeDestination.value!.address
                      }"),
                    ],
                  )
              ),
              Padding(
                padding:   EdgeInsets.all(size.height*.01),
                child: BasicButton(
                  label: "Confirm trip",
                  raduis: 4,
                  onPresed: ()async{

                  await    Future.delayed(Duration(seconds: 4),(){
                        controller.status.value="accepted";
                      });
                    controller.update();
                    await      Future.delayed(Duration(seconds: 4),(){
                      controller.status.value="arrived";
                    });
                    controller.update();
                  },
                ),
              )
            ],
          ),
        ):
        controller.status.value== "searchingDriver" ?
        InteractiveBottomSheet(
          options: InteractiveBottomSheetOptions(
            initialSize: 0.5,
            maxSize: 0.5,
            minimumSize: 0.25,
            // backgroundColor: Colors.green,
            snapList: [0.25,0.5],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           if(controller.status.value== "searchingDriver")
              LinearProgressIndicator(
                // value: 0.7, // Example progress value
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              SizedBox(height: size.height*.04,),
              DriverCardWithShimmer(
                imageUrl: 'https://example.com/driver.jpg',
                name: 'John Doe',
                phoneNumber: '+1234567890',
                isLoading: controller.status.value== "searchingDriver",
              ),
              SizedBox(height: size.height*.14,),
              Center(
                child: GestureDetector(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      onPressed: (){
                        controller.status.value="confirmed";
                        // controller.carMarkers
                        controller.update();
                      },
                      icon: Icon(Icons.cancel), color: Colors.white,
                    ),
                  ),
                ),
              ),
             if( controller.status.value== "searchingDriver")  Center(
                child: Text("Cancle trip"),
              )

            ],
          ),
        ):
            controller.status.value=="accepted"?
            InteractiveBottomSheet(
          options: InteractiveBottomSheetOptions(
            initialSize: 0.5,
            maxSize: 0.5,
            minimumSize: 0.25,
            // backgroundColor: Colors.green,
            snapList: [0.25,0.5],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*.04,),
              DriverCard(
                imageUrl: 'https://example.com/driver.jpg',
                name: 'John Doe',
                phoneNumber: '+1234567890',
              ),
              SizedBox(height: size.height*.14,),
              Center(
                child: ElevatedButton.icon(
                  onPressed: ()async{
                     final result=await Get.to(CancelTripDialog());
                     if(result != null){
                       controller.status.value="confirmed";
                       controller.update();
                     }
                  },
                  icon: Icon(Icons.cancel,color: white,),
                  label: Text('Cancel Trip',style: TextStyle(color: white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ):
            InteractiveBottomSheet(
          options: InteractiveBottomSheetOptions(
            initialSize: 0.5,
            maxSize: 0.5,
            minimumSize: 0.25,
            // backgroundColor: Colors.green,
            snapList: [0.25,0.5],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your driver has arrived!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              DriverCard(
                imageUrl: 'https://example.com/driver.jpg',
                name: 'John Doe',
                phoneNumber: '+1234567890',
              ),

              Card(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(size.height*.01),
                        child: Row(
                          children: [
                            Icon( Icons.location_on_outlined,color: kMainColor,) ,
                            Text("${controller.placeOrigin.value!.address != null &&
                                controller.placeOrigin.value!.address!.length >= 25 ?
                            controller.placeOrigin.value!.address!.substring(0,25):controller.placeOrigin.value!.address
                            }"),
                          ],
                        )
                    ),
                    SizedBox(height: size.height*.01,),
                    Padding(
                        padding: EdgeInsets.all(size.height*.01),
                        child: Row(
                          children: [
                            Icon( Icons.location_on_outlined,color: kMainColor,) ,
                            Text("${controller.placeDestination.value!.address != null &&
                                controller.placeDestination.value!.address!.length >= 25 ?
                            controller.placeDestination.value!.address!.substring(0,25):controller.placeDestination.value!.address
                            }"),
                          ],
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        )


      ),
    ));
  }
  buildPaymentCardWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/visa.png',
            width: 40,
          ),
          SizedBox(
            width: 10,
          ),

        ],
      ),
    );
  }
  Widget _buildDriverCardWithShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Shimmer Effect for Driver Image
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16.0),
            // Shimmer Effect for Driver Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16.0,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 16.0,
                    width: 100.0,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
 Widget buildRideConfirmationSheet() {
  return  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(
        height: 10,
      ),

      const SizedBox(
        height: 20,
      ),

      const SizedBox(
        height: 20,
      ),
      buildDriversList(),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Divider(),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: buildPaymentCardWidget()),
          ],
        ),
      )
    ],
  );
  }
  buildDriversList() {
    return Container(
      height: 90,
      width: Get.width,
      child: StatefulBuilder(builder: (context, set) {
        return ListView.builder(
          itemBuilder: (ctx, i) {
            return InkWell(
              onTap: () {
                set(() {
                controller.  selectedRide = i;
                });
              },
              child: buildDriverCard(controller.selectedRide == i),
            );
          },
          itemCount: 3,
          scrollDirection: Axis.horizontal,
        );
      }),
    );
  }
  buildDriverCard(bool selected) {
    return Container(
      margin: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
      height: 85,
      width: 165,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: selected
                    ? Color(0xff2DBB54).withOpacity(0.2)
                    : Colors.grey.withOpacity(0.2),
                offset: Offset(0, 5),
                blurRadius: 5,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(12),
          color: selected ? Color(0xff2DBB54) : Colors.grey),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              ],
            ),
          ),
          Positioned(
              right: -20,
              top: 0,
              bottom: 0,
              child: Image.asset('assets/Mask Group 2.png'))
        ],
      ),
    );
  }
  Future<void> _handleConfirmButtonPress() async {
    // Show the progress dialog
    // controller.isLoading = true;
    //
    // // Add markers to represent drivers
    // controller.addDriverMarkers();
    //
    // // Simulate driver search
    // await Future.delayed(Duration(seconds: 3)); // Simulate a delay
    //
    // // Simulate driver accepting the order
    // controller.isLoading.value = false;
    // controller.driverAcceptedOrder();
    //
    // // Update the bottom sheet with driver details
    // controller.updateDriverDetails();
  }
}
