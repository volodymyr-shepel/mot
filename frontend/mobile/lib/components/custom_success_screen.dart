import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../constants.dart';

class CustomSuccessScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String buttonText;
  final String nextRoute;

  const CustomSuccessScreen({
    required this.imagePath,
    required this.title,
    required this.buttonText,
    required this.nextRoute,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: kPrimaryDarkColor, // Change to your app's primary color
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(
            imagePath,
            height: MediaQuery.of(context).size.height * 0.4,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                context.go(nextRoute);
              },
              child: Text(buttonText),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
