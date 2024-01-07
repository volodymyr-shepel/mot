import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mot/models/Product.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  });

  final double width, aspectRetio;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig(context: context).getProportionateScreenWidth(20)),
      child: SizedBox(
        width: SizeConfig(context: context).getProportionateScreenWidth(width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: EdgeInsets.all(SizeConfig(context: context).getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(product.images[0]),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              style: TextStyle(color: kTextColor),
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(
                    fontSize: SizeConfig(context: context).getProportionateScreenWidth(18),
                    fontWeight: FontWeight.w600,
                    color: kPrimaryColor,
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig(context: context).getProportionateScreenWidth(8)),
                    height: SizeConfig(context: context).getProportionateScreenWidth(28),
                    width: SizeConfig(context: context).getProportionateScreenWidth(28),
                    decoration: BoxDecoration(
                      color: product.isFavourite
                          ? kPrimaryColor.withOpacity(0.15)
                          : kSecondaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: product.isFavourite
                          ? Color(0xFFFF4848)
                          : Color(0xFFDBDEE4),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}