import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:url_launcher/url_launcher.dart';

class DriverCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String phoneNumber;

  DriverCard({
    required this.imageUrl,
    required this.name,
    required this.phoneNumber,
  });

  void _callDriver() async {
    // final url = 'tel:$phoneNumber';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Driver Image
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(width: 16.0),
          // Driver Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          // Call Button
          IconButton(
            icon: Icon(Icons.phone, color: Colors.green),
            onPressed: _callDriver,
          ),
        ],
      ),
    );
  }
}


class DriverCardWithShimmer extends StatelessWidget {
  final bool isLoading;
  final String imageUrl;
  final String name;
  final String phoneNumber;

  DriverCardWithShimmer({
    required this.isLoading,
    this.imageUrl = '',
    this.name = '',
    this.phoneNumber = '',
  });

  void _callDriver() async {
    final url = 'tel:$phoneNumber';
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
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
                // Shimmering Circle Avatar
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 16.0),
                // Shimmering Driver Details
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
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                // Shimmering Call Button Placeholder
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
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
            // Driver Image
            CircleAvatar(
              radius: 30.0,
              backgroundImage:AssetImage("assets/person.png"),

            ),
            SizedBox(width: 16.0),
            // Driver Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Call Button
            IconButton(
              icon: Icon(Icons.phone, color: Colors.green),
              onPressed: _callDriver,
            ),
          ],
        ),
      );
    }
  }

}
