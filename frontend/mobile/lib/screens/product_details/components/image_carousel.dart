import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
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
                'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium?wid=5120&hei=2880&fmt=p-jpg&qlt=80&.v=1692845702708',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: imagePadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium_AV1_GEO_EMEA?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1692845699470',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: imagePadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium_AV2?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1692845702182',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: imagePadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(
                'https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-7inch-naturaltitanium_AV3?wid=2560&hei=1440&fmt=p-jpg&qlt=80&.v=1693011642028',
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
