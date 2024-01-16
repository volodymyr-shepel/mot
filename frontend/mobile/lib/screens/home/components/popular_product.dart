import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mot/components/product_card.dart';
import 'package:http/http.dart' as http;
import 'package:mot/constants.dart';
import 'package:mot/models/cart.dart';
import 'package:mot/models/product.dart';
import 'package:mot/models/category.dart';
import 'package:mot/screens/home/home_screen.dart';
import 'package:mot/screens/home/product_list_screen.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  final Category selectedParentCategory;

  const PopularProducts(this.selectedParentCategory);

  @override
  _PopularProducts createState() => _PopularProducts();
}


class _PopularProducts extends State<PopularProducts> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // Maybe change it somehow so it does not take too much time
  void _fetchProducts() async {
    final url = Uri.parse('$baseUrl/api/product/products/v1/pc/${widget.selectedParentCategory.id}?page=1');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

        List<Product> newProducts = data.map((item) => Product.fromJson(item)).toList();

        setState(() {
          products.addAll(newProducts);
        });
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig(context: context).getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Popular Products in\n${widget.selectedParentCategory.name}", 
            press: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductListScreen(widget.selectedParentCategory, true)));},
            ),
        ),
        SizedBox(height: SizeConfig(context: context).getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                products.length,
                (index) {
                  return ProductCard(
                      product: products[index],
                      press: () {
                        CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                        cartProvider.addToCart(Cart(product: products[index], numOfItem: 1));
                      },
                      );
                },
              ),
              SizedBox(width: SizeConfig(context: context).getProportionateScreenWidth(20)),
            ],
          ),
        )
      ],
    );
  }
}