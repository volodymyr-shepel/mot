import 'package:flutter/material.dart';
import 'package:mot/models/cart.dart';
import 'package:mot/screens/cart_screen/components/body_cart.dart';
import 'package:mot/screens/cart_screen/components/cart_card.dart';
import 'package:mot/screens/cart_screen/components/checkout_cart.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: CartBody(),
      bottomNavigationBar: CheckoutCard(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: kDefaultIconLightColor),
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
                List<Cart> cart = cartProvider.cartItems;

                return Text(
                  "${cart.length} items",
                  style: Theme.of(context).textTheme.caption,
                );
            }
          ),
        ],
      ),
    );
  }
}