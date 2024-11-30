import 'package:flutter/material.dart';

class BasicAvatarImage extends StatelessWidget {
  const BasicAvatarImage(
      {Key? key,
      required this.imageUrl,
      this.placeholder = '',
      this.width = 40,
      this.height = 40})
      : super(key: key);

  final String imageUrl;
  final String placeholder;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 3,
          color: Color(0xFF998AE0E5),
        ),
        image: DecorationImage(
          image: FadeInImage.assetNetwork(
            placeholder: 'assets/images/student.png',
            image: imageUrl,
          ).image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
