import 'package:flutter/material.dart';
import 'package:mot/screens/home/home_screen.dart';

import '../../components/custom_success_screen.dart';

class OrderSuccessScreen extends StatelessWidget {
  static String routeName = "/order_success";

  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSuccessScreen(
      imagePath: "assets/images/success.png",
      title: "Order Completed",
      buttonText: "Back to Home",
      nextRoute: HomeScreen.routeName 
    );
  }
}