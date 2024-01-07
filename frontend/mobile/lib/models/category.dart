class Category {
  int id;
  String name;
  List<Category>? childCategories;

  Category({required this.id, required this.name, this.childCategories});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      childCategories: json['childCategories'] != null
          ? List<Category>.from(json['childCategories'].map((category) => Category.fromJson(category)))
          : null,
    );
  }
}