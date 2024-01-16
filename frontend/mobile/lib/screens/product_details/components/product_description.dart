import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mot/models/product.dart';

import '../../../constants.dart';

class ProductDescription extends StatefulWidget {
  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Column for Title and Price
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      '\$${widget.product.price}', // Display the price of the product
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: kPrimaryColor),
                    ),
                  ),
                ],
              ),
            ),
            // isFavorite Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.product.isFavourite
                    ? const Color(0xFFFFE6E6)
                    : const Color(0xFFF5F6F9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: SvgPicture.asset(
                "assets/icons/Heart Icon_2.svg",
                colorFilter: ColorFilter.mode(
                    widget.product.isFavourite
                        ? const Color(0xFFFF4848)
                        : const Color(0xFFDBDEE4),
                    BlendMode.srcIn),
                height: 16,
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(left: 20, right: 64, top: 15),
          child: Text(
            widget.product.description??"",
            maxLines: isExpanded ? null : 4,
            overflow: TextOverflow.fade,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                  if (widget.pressOnSeeMore != null) {
                    widget.pressOnSeeMore!();
                  }
                },
                child: Text(
                  isExpanded ? "See Less" : "See More Details",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              // ... other widget code ...
            ],
          ),
        ),
      ],
    );
  }
}
