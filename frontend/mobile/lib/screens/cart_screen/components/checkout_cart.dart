import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mot/components/default_button.dart';
import 'package:mot/models/cart.dart';
import 'package:mot/screens/cart_screen/order_success_screen.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig(context: context).getProportionateScreenWidth(15),
        horizontal: SizeConfig(context: context).getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: SizeConfig(context: context).getProportionateScreenWidth(40),
                  width: SizeConfig(context: context).getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                ),
                Spacer(),
                Text("Add voucher code"),
                const SizedBox(width: 10),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kTextColor,
                )
              ],
            ),
            SizedBox(height: SizeConfig(context: context).getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                      return Text.rich(
                        TextSpan(
                          text: "Total:\n",
                          children: [
                            TextSpan(
                              text: "${cartProvider.totalAmount} zł.",
                              style: TextStyle(fontSize: 16, color: kDefaultIconLightColor),
                            ),
                          ],
                        ),
                      );
                  }
                ),
                SizedBox(
                  width: SizeConfig(context: context).getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Check Out",
                    press: () {
                      Provider.of<CartProvider>(context, listen: false).clearCart();
                      context.go(OrderSuccessScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}