import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';

class CircularCachedImage extends StatelessWidget {
  final String imageUrl;

  const CircularCachedImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(color: AppColors.blueDarkColor,), // Optional: placeholder while loading
        errorWidget: (context, url, error) => Icon(Icons.error),  // Optional: error widget
        fit: BoxFit.cover, // Ensures the image covers the entire circle
        width: 100.0, // Adjust width to your needs
        height: 100.0, // Adjust height to your needs
      ),
    );
  }
}