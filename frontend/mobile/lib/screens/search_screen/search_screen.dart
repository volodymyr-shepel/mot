import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mot/screens/search_screen/components/category_widget.dart';
import 'package:mot/screens/search_screen/components/search_field.dart';
import 'dart:convert';
import '../../models/category.dart';
import 'package:mot/constants.dart';
import 'package:mot/screens/search_screen/child_categories_screen.dart';

class SearchScreen extends StatefulWidget {
  final Category? selectedParentCategory;
  static String routeName = "/search";

  const SearchScreen({Key? key, this.selectedParentCategory}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title : const Text(
          "Search",
          style: TextStyle(fontSize: 20.0,color: Colors.white),
        )
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SearchField(
              hintText: "Czego szukasz?",
              keyboardType: TextInputType.text,
              svgIconPath: 'assets/icons/Search Icon.svg',
            ),
            const SizedBox(height: 15),

            for (var category in parentCategories)
              CategoryWidget(category: category, onCategoryTap: _handleCategoryTap),
          ],
        ),
      ),
    );
  }

  void _handleCategoryTap(Category category) {
    // Handle category tap, e.g., navigate to child categories screen
    // TODO : change it in context.go
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChildCategoriesScreen(
          parentCategory: category,
        ),
      ),
    );
  }

  

}