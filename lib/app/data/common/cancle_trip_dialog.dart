import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CancelTripDialog extends StatelessWidget {
  final List<String> cancelReasons = [
    "Driver took too long",
    "Driver is not moving",
    "Driver is rude",
    "Other reasons"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Cancel Icon
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.cancel,color: Colors.black45,  size: 30),
                color: Colors.black45,
                onPressed: () {
                  Get.back(result: true);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Why are you canceling the trip?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // List of Reasons
          Expanded(
            child: ListView.builder(
              itemCount: cancelReasons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(cancelReasons[index]),
                  onTap: () {
                    // Handle reason selection
                    Get.back(result: true); // Close the dialog
                    // Implement further actions here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
