import 'package:flutter/material.dart';

import '../../../size_config.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(SizeConfig(context: context).getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig(context: context).getProportionateScreenWidth(20),
        vertical: SizeConfig(context: context).getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "A Summer Surpise\n"),
            TextSpan(
              text: "Cashback 20%",
              style: TextStyle(
                fontSize: SizeConfig(context: context).getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}