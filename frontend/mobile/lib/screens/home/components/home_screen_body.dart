import 'package:flutter/material.dart';
import 'package:mot/screens/home/components/categories.dart';
import 'package:mot/screens/home/components/discount_banner.dart';
import 'package:mot/screens/home/components/header/home_header.dart';
import 'package:mot/screens/home/components/popular_product.dart';
import 'package:mot/screens/home/components/special_offers.dart';
import 'package:mot/size_config.dart';

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: SizeConfig(context: context).getProportionateScreenHeight(20)),
            HomeHeader(),
            
            SizedBox(height: SizeConfig(context: context).getProportionateScreenHeight(20)),
            DiscountBanner(),
            Categories(),
            SpecialOffers(),

            
            SizedBox(height: SizeConfig(context: context).getProportionateScreenHeight(20)),
            PopularProducts(),
            PopularProducts(),
            PopularProducts(),
            PopularProducts(),
            PopularProducts(),
            
            SizedBox(height: SizeConfig(context: context).getProportionateScreenWidth(30)),

          ],
        ),
      ),
    );
  }
}