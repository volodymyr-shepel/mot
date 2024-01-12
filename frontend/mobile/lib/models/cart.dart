import 'package:flutter/material.dart';

import 'product.dart';

class Cart {
  final Product product;
  int numOfItem;

  Cart({required this.product, required this.numOfItem});
}
class CartProvider extends ChangeNotifier {
  List<Cart> _cartItems = [];

  List<Cart> get cartItems => _cartItems;

  void addToCart(Cart cartItem) {
    int existingIndex = _cartItems.indexWhere((item) => item.product.id == cartItem.product.id);

    if (existingIndex != -1) {
      _cartItems[existingIndex].numOfItem += cartItem.numOfItem;
    } else {
      _cartItems.add(cartItem);
    }
    notifyListeners();
  }

  void removeAtIndex(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

   void removeFromCart(Cart cartItem) {
    _cartItems.removeWhere((item) => item.product.id == cartItem.product.id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int cartLength () {
    return _cartItems.length;
  }

  double get totalAmount {
    return _cartItems.fold(0, (sum, item) => sum + (item.product.price * item.numOfItem));
  }
}

// Demo data for our cart
