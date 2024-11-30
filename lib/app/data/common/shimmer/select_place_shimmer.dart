import 'package:flutter/material.dart';
import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';
// For SvgPicture
// Assume necessary imports and other dependencies like controllers and custom widgets

class SelectPlacesSheetShimmer extends StatelessWidget {

  SelectPlacesSheetShimmer();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InteractiveBottomSheet(
      options: InteractiveBottomSheetOptions(
        initialSize: 0.6,
        maxSize: 0.6,
        backgroundColor: Colors.white,
        snapList: [0.6],
      ),
      draggableAreaOptions: DraggableAreaOptions(
        topBorderRadius: 30,
        height: 0,
      ),
      child: _buildShimmerEffect(size) // Show shimmer while loading
          // Show actual content when not loading
    );
  }

  Widget _buildShimmerEffect(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer for the top section with map icons and fields
        Container(
          height: size.height * .29,
          margin: EdgeInsets.symmetric(
            horizontal: size.width * .04,
            vertical: size.height * .01,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.width * .1),
                        _buildIconShimmer(size),
                        _buildVerticalLineShimmer(size),
                        _buildIconShimmer(size),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextFieldShimmer(size),
                          SizedBox(height: size.height * .01),
                          Divider(),
                          _buildTextFieldShimmer(size),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Shimmer for previous places text
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: size.width * .04,
            vertical: size.height * .01,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 20,
              width: 150,
              color: Colors.white,
            ),
          ),
        ),
        // Shimmer for the previous places list
        _buildShimmerPreviousPlaces(size),
        // Shimmer for the next button
        Container(
          margin: EdgeInsets.all(size.width * .04),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(Size size) {
    // Actual content when not loading
    // Replace this with your existing content as shown in the original code.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Your actual content here when data is not loading
      ],
    );
  }

  Widget _buildIconShimmer(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: size.height * .03,
          width: size.height * .03,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildVerticalLineShimmer(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: size.width * .03),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 1,
          height: 90,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTextFieldShimmer(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerPreviousPlaces(Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height * .01),
      height: size.height * .06,
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
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
    );
  }
}
