import 'package:flutter/material.dart';
import 'package:mot/screens/sign_in/sign_in_screen.dart';
import '../../components/custom_success_screen.dart';

class SignUpSuccessScreen extends StatelessWidget {
  static String routeName = "/signup_success";

  const SignUpSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSuccessScreen(
      imagePath: "assets/images/success.png",
      title: "Check your email",
      buttonText: "Back to Sign In",
      nextRoute: SignInScreen.routeName, 
    );
  }
}