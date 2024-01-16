import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final String imageUrl;
  const ImageCarousel({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    // Calculate the viewport width after padding is subtracted
    double screenWidth = MediaQuery.of(context).size.width;
    double spaceBetweenImages = 16.0; // The space you want between the images
    double imagePadding = spaceBetweenImages / 2;
    double viewportFraction = (screenWidth - spaceBetweenImages) / screenWidth;

    // Create a PageController with the calculated viewportFraction
    PageController controller = PageController(
      viewportFraction: viewportFraction,
      initialPage: 0,
    );

    return Container(
      height: 300.0, // Set a fixed height for the carousel
      child: PageView(
        controller: controller,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: imagePadding), // Add horizontal padding
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: imagePadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: imagePadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: imagePadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // ... Add more images if needed
        ],
      ),
    );
  }
}
