import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mot/models/cart.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig(context: context).getProportionateScreenWidth(20)),
      child: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          List<Cart> cart = cartProvider.cartItems;

          return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Dismissible(
              key: Key(cart[index].product.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                setState(() {
                  CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                  cartProvider.removeAtIndex(index);
                });
              },
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset("assets/icons/Trash.svg"),
                  ],
                ),
              ),
              child: CartCard(cart: cart[index]),
            ),
          ),
        );
        }
        ),
    );
  }
}