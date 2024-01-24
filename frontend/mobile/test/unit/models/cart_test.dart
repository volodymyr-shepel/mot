import 'package:flutter_test/flutter_test.dart';
import 'package:mot/models/cart.dart';
import 'package:mot/models/product.dart';

//flutter test lib/test/unit/models/test_cart.dart
void main() {
  group('CartProvider Tests', () {
    test('Adding item to cart increases cart length', () {
      CartProvider cartProvider = CartProvider();
      expect(cartProvider.cartLength(), 0);

      Product product = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url');
      Cart cartItem = Cart(product: product, numOfItem: 2);

      cartProvider.addToCart(cartItem);
      expect(cartProvider.cartLength(), 1);
    });

    test('Adding existing item to cart updates quantity', () {
      CartProvider cartProvider = CartProvider();
      expect(cartProvider.cartLength(), 0);

      Product product = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url');
      Cart cartItem = Cart(product: product, numOfItem: 2);

      cartProvider.addToCart(cartItem);
      expect(cartProvider.cartLength(), 1);

      // Adding the same item again
      Cart cartItem2 = Cart(product: product, numOfItem: 3);
      cartProvider.addToCart(cartItem2);

      expect(cartProvider.cartLength(), 1);
      expect(cartProvider.cartItems[0].numOfItem, 5);
    });

    test('Removing item from cart decreases cart length', () {
      CartProvider cartProvider = CartProvider();
      expect(cartProvider.cartLength(), 0);

      Product product = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url');
      Cart cartItem = Cart(product: product, numOfItem: 2);

      cartProvider.addToCart(cartItem);
      expect(cartProvider.cartLength(), 1);

      cartProvider.removeFromCart(cartItem);
      expect(cartProvider.cartLength(), 0);
    });

    test('Clearing cart sets cart length and total amount to zero', () {
      CartProvider cartProvider = CartProvider();

      Product product = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url');
      Cart cartItem = Cart(product: product, numOfItem: 2);

      cartProvider.addToCart(cartItem);
      expect(cartProvider.cartLength(), 1);
      expect(cartProvider.totalAmount, 20.0);

      cartProvider.clearCart();
      expect(cartProvider.cartLength(), 0);
      expect(cartProvider.totalAmount, 0.0);
    });

    test('Removing item at specific index decreases cart length', () {
      CartProvider cartProvider = CartProvider();

      Product product1 = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url1');
      Cart cartItem1 = Cart(product: product1, numOfItem: 2);

      Product product2 = Product(id: '2', name: 'Product 2', price: 15.0, imageUrl: 'url2');
      Cart cartItem2 = Cart(product: product2, numOfItem: 3);

      cartProvider.addToCart(cartItem1);
      cartProvider.addToCart(cartItem2);

      expect(cartProvider.cartLength(), 2);

      cartProvider.removeAtIndex(0);
      expect(cartProvider.cartLength(), 1);
      expect(cartProvider.cartItems[0].product.id, '2');
    });

  });

   group('CartProvider adding to cart Tests', () {
      test('Adding item to empty cart increases cart length', () {
      CartProvider cartProvider = CartProvider();
      expect(cartProvider.cartLength(), 0);

      Product product = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url');
      Cart cartItem = Cart(product: product, numOfItem: 2);

      cartProvider.addToCart(cartItem);
      expect(cartProvider.cartLength(), 1);
    });

    test('Adding item to non-empty cart increases cart length', () {
      CartProvider cartProvider = CartProvider();

      Product product1 = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url1');
      Cart cartItem1 = Cart(product: product1, numOfItem: 2);

      cartProvider.addToCart(cartItem1);
      expect(cartProvider.cartLength(), 1);

      Product product2 = Product(id: '2', name: 'Product 2', price: 15.0, imageUrl: 'url2');
      Cart cartItem2 = Cart(product: product2, numOfItem: 3);

      cartProvider.addToCart(cartItem2);
      expect(cartProvider.cartLength(), 2);
    });

    test('Adding item to non-empty cart updates quantity', () {
      CartProvider cartProvider = CartProvider();

      Product product1 = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url1');
      Cart cartItem1 = Cart(product: product1, numOfItem: 2);

      Product product2 = Product(id: '2', name: 'Product 2', price: 15.0, imageUrl: 'url2');
      Cart cartItem2 = Cart(product: product2, numOfItem: 3);

      cartProvider.addToCart(cartItem1);
      expect(cartProvider.cartLength(), 1);

      cartProvider.addToCart(cartItem2);
      expect(cartProvider.cartLength(), 2);

      Cart cartItem2Duplicate = Cart(product: product2, numOfItem: 3);
      cartProvider.addToCart(cartItem2Duplicate);

      expect(cartProvider.cartLength(), 2);
      expect(cartProvider.cartItems[1].numOfItem, 6);
    });
  });

  group('CartProvider removing from cart Tests', () {
     test('Deleting item from empty cart does nothing', () {
      CartProvider cartProvider = CartProvider();
      expect(cartProvider.cartLength(), 0);

      cartProvider.removeFromCart(Cart(product: Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url'), numOfItem: 2));

      expect(cartProvider.cartLength(), 0);
    });

    test('Deleting non-existent item from non-empty cart does nothing', () {
      CartProvider cartProvider = CartProvider();

      Product product1 = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url1');
      Cart cartItem1 = Cart(product: product1, numOfItem: 2);

      cartProvider.addToCart(cartItem1);
      expect(cartProvider.cartLength(), 1);

      cartProvider.removeFromCart(Cart(product: Product(id: '2', name: 'Product 2', price: 15.0, imageUrl: 'url2'), numOfItem: 3));

      expect(cartProvider.cartLength(), 1);
    });

    test('Deleting existent item from non-empty cart decreases cart length', () {
      CartProvider cartProvider = CartProvider();

      Product product1 = Product(id: '1', name: 'Product 1', price: 10.0, imageUrl: 'url1');
      Cart cartItem1 = Cart(product: product1, numOfItem: 2);

      Product product2 = Product(id: '2', name: 'Product 2', price: 15.0, imageUrl: 'url2');
      Cart cartItem2 = Cart(product: product2, numOfItem: 3);

      cartProvider.addToCart(cartItem1);
      expect(cartProvider.cartLength(), 1);

      cartProvider.addToCart(cartItem2);
      expect(cartProvider.cartLength(), 2);

      cartProvider.removeFromCart(Cart(product: product1, numOfItem: 2));
      expect(cartProvider.cartLength(), 1);
    });
  });
}
