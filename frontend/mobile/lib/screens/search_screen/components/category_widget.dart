import 'package:flutter/material.dart';
import 'package:mot/models/category.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  final void Function(Category) onCategoryTap;

  CategoryWidget({required this.category, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF4E4F51), width: 0.5),
          bottom: BorderSide(color: Color(0xFF4E4F51), width: 0.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onCategoryTap(category),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category.name,
                  style: const TextStyle(fontSize: 18),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white, // Set the color to white
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
