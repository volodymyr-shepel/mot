import 'package:flutter/material.dart';
import 'package:mot/screens/home/components/home_screen_body.dart';

class HomeScreen extends StatelessWidget{
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenBody(),
    );
  }
}