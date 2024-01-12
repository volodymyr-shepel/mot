import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mot/components/product_card.dart';
import 'package:mot/constants.dart';
import 'package:mot/helper/keyboard.dart';
import 'dart:convert';

import 'package:mot/models/Product.dart';
import 'package:mot/models/category.dart';
import 'package:mot/size_config.dart';

class ProductListScreen extends StatefulWidget {
  final Category category;
  final bool isParentCategory;

  ProductListScreen(this.category, this.isParentCategory);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  int currentPage = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final cat = widget.isParentCategory ? "pc" : "c";

    final url = Uri.parse('$baseUrl/api/product/products/v1/$cat/${widget.category.id}?page=$currentPage');
    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));

        List<Product> newProducts = data.map((item) => Product.fromJson(item)).toList();

        setState(() {
          products.addAll(newProducts);
          currentPage++;
        });
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List",
        style: TextStyle(fontSize: 20.0, color: Colors.white),),
        leading: IconButton(
          onPressed: () {
            KeyboardUtil.hideKeyboard(context);
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            fetchData();
            return true;
          }
          return false;
        },
        child: ListView.builder(
          cacheExtent: 100,
          itemExtent: 250,

          itemCount: (products.length / 2).ceil() + 1, // +1 for loading indicator
          itemBuilder: (context, index) {
            if (index == (products.length / 2).ceil())  {
              return isLoading ? CircularProgressIndicator() : Container();
            } else {
              int firstProductIndex = index * 2;
              int secondProductIndex = (index * 2) + 1;
              
              return Row(
                children: [
                  Expanded(
                    child: ProductCard(
                      product: products[firstProductIndex],
                      press: () {
                        // TODO: Handle product card tap for the first product
                      },
                    ),
                  ),
                  SizedBox(width: 10), // Add some spacing between products
                  Expanded(
                    child: secondProductIndex < products.length
                        ? ProductCard(
                            product: products[secondProductIndex],
                            press: () {
                              // TODO: Handle product card tap for the second product
                            },
                          )
                        : Container(),
                  ),
                  SizedBox(width: SizeConfig(context: context).getProportionateScreenWidth(20))
                ],
              );

            }
          },
          // Trigger fetchData when reaching the end of the list
          //onEndReached: () => fetchData(),
        ),
      )
    );
  }
}