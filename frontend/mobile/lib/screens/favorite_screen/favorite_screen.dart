import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static String routeName = "/favorite";
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Favorite Screen", style: TextStyle(fontSize: 24.0)),
    );
  }
}