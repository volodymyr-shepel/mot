
import 'package:flutter/widgets.dart';
import 'package:mot/screens/complete_profile/complete_profile_screen.dart';
import 'package:mot/screens/forgot_password/forgot_password_screen.dart';
import 'package:mot/screens/forgot_password/forgot_password_success_screen.dart';
import 'package:mot/screens/home/home_screen.dart';
import 'package:mot/screens/init_screen/init_screen.dart';
import 'package:mot/screens/product_details/details_screen.dart';
import 'package:mot/screens/sign_in/sign_in_screen.dart';
import 'package:mot/screens/sign_in/sign_in_success_screen.dart';
import 'package:mot/screens/sign_up/sign_up_screen.dart';
import 'package:mot/screens/sign_up/sign_up_success_screen.dart';
import 'package:mot/screens/profile_screen/profile_screen.dart';
import 'screens/welcome_screen/welcome_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignInSuccessScreen.routeName : (context) => const SignInSuccessScreen(),
  ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
  SignUpSuccessScreen.routeName: (context) => const SignUpSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgotPasswordSuccessScreen.routeName : (context) => const ForgotPasswordSuccessScreen(),
  ProfileScreen.routeName : (context) => const ProfileScreen(),
  HomeScreen.routeName : (context) => const HomeScreen(),
  DetailsScreen.routeName : (context) => const DetailsScreen()
};
