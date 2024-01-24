import 'package:mot/models/category.dart';
import 'package:test/test.dart';

//flutter test lib/test/unit/models/test_category.dart
void main() {
  group('Category', () {
    test('fromJson should create a Category instance from a valid JSON', () {
      // Arrange
      Map<String, dynamic> json = {
        'id': 1,
        'name': 'ParentCategory',
        'childCategories': [
          {'id': 2, 'name': 'ChildCategory1'},
          {'id': 3, 'name': 'ChildCategory2'},
        ],
      };

      // Act
      Category category = Category.fromJson(json);

      // Assert
      expect(category.id, equals(1));
      expect(category.name, equals('ParentCategory'));
      expect(category.childCategories, isNotNull);
      expect(category.childCategories!.length, equals(2));

      // Check child categories
      expect(category.childCategories![0].id, equals(2));
      expect(category.childCategories![0].name, equals('ChildCategory1'));
      expect(category.childCategories![1].id, equals(3));
      expect(category.childCategories![1].name, equals('ChildCategory2'));
    });

    test('fromJson should handle null values and create a Category instance', () {
      // Arrange
      Map<String, dynamic> json = {
        'id': null,
        'name': null,
        'childCategories': null,
      };

      // Act
      Category category = Category.fromJson(json);

      // Assert
      expect(category.id, equals(0));
      expect(category.name, equals(''));
      expect(category.childCategories, isNull);
    });

  });
}
