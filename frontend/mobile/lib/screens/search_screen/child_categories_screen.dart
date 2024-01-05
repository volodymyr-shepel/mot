import 'package:flutter/material.dart';
import 'package:mot/models/category.dart';
import 'package:mot/screens/search_screen/components/category_widget.dart';

class ChildCategoriesScreen extends StatelessWidget {
  final Category parentCategory;

  ChildCategoriesScreen({required this.parentCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parentCategory.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            if (parentCategory.childCategories != null)
              for (var childCategory in parentCategory.childCategories!)
                Builder(
                  builder: (context) => CategoryWidget(
                    category: childCategory,
                    onCategoryTap: (category) => _handleCategoryTap(context, category),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  void _handleCategoryTap(BuildContext context, Category category) {
    print("Category tapped: ${category.name}");
    // Do whatever you need with the tapped category, e.g., navigate to another screen
  }
}
