import 'package:flutter/material.dart';
import 'package:mot/helper/keyboard.dart';
import 'package:mot/models/category.dart';
import 'package:mot/screens/search_screen/components/category_widget.dart';
import 'package:mot/screens/search_screen/components/search_field.dart';

class ChildCategoriesScreen extends StatelessWidget {
  final Category parentCategory;

  ChildCategoriesScreen({required this.parentCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
        onPressed: () {
          KeyboardUtil.hideKeyboard(context);
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      automaticallyImplyLeading: false,
      title: Text(
        parentCategory.name,
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SearchField(
            hintText: "Czego szukasz?",
            keyboardType: TextInputType.text, // Set the keyboard type,
            svgIconPath: 'assets/icons/Search Icon.svg',
          ),
          const SizedBox(height: 15),
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
