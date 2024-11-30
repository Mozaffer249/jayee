import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taxi_app/app/data/common/app_colors.dart';

class ProviderCardShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.grey[400],
            ),
            title: Container(
              height: 16,
              color: Colors.grey[400],
              margin: EdgeInsets.only(right: 8.0),
            ),
            trailing: Container(
              width: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 24,
                      width: 24,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      height: 24,
                      width: 24,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
