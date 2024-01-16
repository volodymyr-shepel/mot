import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mot/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mot/models/category.dart';
import 'package:mot/screens/home/components/categories.dart';
import 'package:mot/screens/home/components/discount_banner.dart';
import 'package:mot/screens/home/components/header/home_header.dart';
import 'package:mot/screens/home/components/popular_product.dart';
import 'package:mot/screens/home/components/special_offers.dart';
import 'package:mot/size_config.dart';

class HomeScreenBody extends StatefulWidget {
  HomeScreenBody();

  @override
  _HomeScreenBody createState() => _HomeScreenBody();
}

class _HomeScreenBody extends State<HomeScreenBody> {
    List<Category> parentCategories = [];

  @override
    void initState() {
      super.initState();
      _fetchCategories();
    }
  // Maybe change it somehow so it does not take too much time
  void _fetchCategories() async {
    const String apiUrl = '$baseUrl/api/product/categories/v1/categoryHierarchy';
     try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
         final List<Category> fetchedCategories = List<Category>.from(
        (json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>).map(
        (category) => Category.fromJson(category),
    ),
  );
        setState(() {
          parentCategories = fetchedCategories;
        });
      } else {
        // Handle error scenarios based on response status code
        print('Failed to fetch categories. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network-related errors
      print('Error fetching categories: $error');
    }
  }

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
            for (Category category in parentCategories)
              PopularProducts(category),
            
            SizedBox(height: SizeConfig(context: context).getProportionateScreenWidth(30)),

          ],
        ),
      ),
    );
  }
}