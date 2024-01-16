import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mot/models/cart.dart';
import 'package:mot/models/product.dart';
import 'package:mot/screens/product_details/components/product_specification.dart';
import 'package:mot/screens/product_details/components/quantity_selector.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import 'components/color_options.dart';
import 'components/image_carousel.dart';
import 'components/product_description.dart';
import 'components/product_images.dart';
import 'components/top_rounded_container.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  final Product productPreview;

  const DetailsScreen({Key? key, required this.productPreview}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Product? product;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _fetchProduct(); // Fetch product when the widget is initialized
  }

  void _fetchProduct() async {
    String productId = widget.productPreview.id;
    String apiUrl = '$baseUrl/api/product/products/v1/p/$productId';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          product = Product.fromJson(json.decode(utf8.decode(response.bodyBytes)));
        });
      } else {
        // Handle error scenarios based on response status code
        print('Failed to fetch product. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network-related errors
      print('Error fetching product: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    log(widget.productPreview.description.toString());
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimaryDarkColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Text(
                      "4.7",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          ImageCarousel(imageUrl: widget.productPreview.imageUrl),
          // Assuming this is a pre-existing widget for image display
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                product != null ? ProductDescription(
                  product: product!,
                  pressOnSeeMore: () {},
                ) : CircularProgressIndicator(), // Show a loading spinner or another placeholder
                TopRoundedContainer(
                  color: const Color(0xFFF6F7F9),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ColorOptionsSection(), // Wrap ColorOptionsSection with Expanded
                          ),
                          QuantitySelector(value: quantity, onIncrement: () {
                            setState(() {
                              quantity++;
                            });
                          }, onDecrement:
                              () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          }),
                          // QuantitySelector doesn't need to be expanded if it sizes itself
                        ],
                      ),
                    ],
                  ),
                ),
                product != null ? ProductSpecification(
                  specifications: product!.specification,
                ) : CircularProgressIndicator(),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: TopRoundedContainer(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).addToCart(
                    Cart(product: widget.productPreview, numOfItem: quantity));
              },
              child: const Text("Add To Cart"),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({required this.product});
}