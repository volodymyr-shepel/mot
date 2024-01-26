import 'package:flutter_test/flutter_test.dart';
import 'package:mot/models/product.dart';


//flutter test lib/test/unit/models/test_product.dart
void main() {
  group('Product Class Test', () {
    test('Product.fromJson should create a valid Product instance', () {
      Map<String, dynamic> json = {
        'id': '1',
        'name': 'Test Product',
        'price': 19.99,
        'imageUrl': 'https://example.com/product.jpg',
        'sku': 'SKU123',
        'description': 'This is a test product',
        'categoryId': 123,
        'quantity': 50,
        'createdOn': '2022-01-01T12:00:00Z',
        'updatedOn': '2022-01-02T14:30:00Z',
        'specification': {'color': 'red', 'size': 'medium'},
      };

      Product product = Product.fromJson(json);

      expect(product.id, '1');
      expect(product.name, 'Test Product');
      expect(product.price, 19.99);
      expect(product.imageUrl, 'https://example.com/product.jpg');
      expect(product.sku, 'SKU123');
      expect(product.description, 'This is a test product');
      expect(product.categoryId, 123);
      expect(product.quantity, 50);
      expect(product.createdOn, DateTime.parse('2022-01-01T12:00:00Z'));
      expect(product.updatedOn, DateTime.parse('2022-01-02T14:30:00Z'));
      expect(product.specification, {'color': 'red', 'size': 'medium'});
    });

    test('Product.fromJson should handle missing or invalid data', () {
      // Test with minimal data, missing optional fields
      Map<String, dynamic> jsonMinimal = {'id': '2', 'name': 'Minimal Product', 'price': 9.99, 'imageUrl': 'https://example.com/minimal.jpg'};
      Product productMinimal = Product.fromJson(jsonMinimal);

      expect(productMinimal.id, '2');
      expect(productMinimal.name, 'Minimal Product');
      expect(productMinimal.price, 9.99);
      expect(productMinimal.imageUrl, 'https://example.com/minimal.jpg');
      expect(productMinimal.sku, '');
      expect(productMinimal.description, '');
      expect(productMinimal.categoryId, 0);
      expect(productMinimal.quantity, 0);
      expect(productMinimal.createdOn, isNull);
      expect(productMinimal.updatedOn, isNull);
      expect(productMinimal.specification, isNull);

      // Test with invalid data
      Map<String, dynamic> jsonInvalid = {'id': '3', 'name': 'Invalid Product', 'price': 'invalid_price', 'imageUrl': 'https://example.com/invalid.jpg'};
      Product productInvalid = Product.fromJson(jsonInvalid);

      expect(productInvalid.id, '3');
      expect(productInvalid.name, 'Invalid Product');
      expect(productInvalid.price, 0.0); // Default value for invalid price
      expect(productInvalid.imageUrl, 'https://example.com/invalid.jpg');
    });
  });
}
