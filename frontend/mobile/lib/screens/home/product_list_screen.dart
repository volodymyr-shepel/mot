import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mot/components/product_card.dart';
import 'package:mot/constants.dart';
import 'dart:convert';

import 'package:mot/models/Product.dart';
import 'package:mot/models/category.dart';

class ProductListScreen extends StatefulWidget {
  final Category category;

  ProductListScreen(this.category);

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

    final url = Uri.parse('$baseUrl/api/product/products/v1/c/${widget.category.id}?page=$currentPage');
    
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
        title: Text('Product List'),
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
          itemCount: products.length + 1, // +1 for loading indicator
          itemBuilder: (context, index) {
            if (index == products.length) {
              return isLoading ? CircularProgressIndicator() : Container();
            } else {
              return ProductCard(
                product: products[index],
                press: () {
                  //TODO: Handle product card tap
                },
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