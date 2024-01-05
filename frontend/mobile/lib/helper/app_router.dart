
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/widgets.dart';
import 'package:mot/models/user_data.dart';
import 'package:mot/screens/cart_screen/cart_screen.dart';
import 'package:mot/screens/complete_profile/complete_profile_screen.dart';
import 'package:mot/screens/favorite_screen/favorite_screen.dart';
import 'package:mot/screens/forgot_password/forgot_password_screen.dart';
import 'package:mot/screens/forgot_password/forgot_password_success_screen.dart';
import 'package:mot/screens/home_screen/home_screen.dart';
import 'package:mot/screens/init_screen/init_screen.dart';
import 'package:mot/screens/search_screen/child_categories_screen.dart';
import 'package:mot/screens/search_screen/search_screen.dart';
import 'package:mot/screens/profile_screen/profile_screen.dart';
import 'package:mot/screens/sign_in/sign_in_screen.dart';
import 'package:mot/screens/sign_in/sign_in_success_screen.dart';
import 'package:mot/screens/sign_up/sign_up_screen.dart';
import 'package:mot/screens/sign_up/sign_up_success_screen.dart';
import 'package:mot/screens/welcome_screen/welcome_screen.dart';


final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  
  routes: <RouteBase>[
    GoRoute(
      path: WelcomeScreen.routeName,
      builder : (context, state) => const WelcomeScreen()),
    

    GoRoute(
      path: SignInScreen.routeName,
      builder : (context, state) => const SignInScreen()),
    
    GoRoute(
      path: SignInSuccessScreen.routeName,
      builder : (context, state) => const SignInSuccessScreen()),
    
    GoRoute(
      path: ForgotPasswordSuccessScreen.routeName,
      builder : (context, state) => const ForgotPasswordSuccessScreen()),
    
    GoRoute(
      path: SignUpSuccessScreen.routeName,
      builder : (context, state) => const SignUpSuccessScreen()),
    
    GoRoute(
      path: SignUpScreen.routeName,
      builder : (context, state) => const SignUpScreen()),

    GoRoute(
      path: '/completeProfile',
      builder: (context, state) {
        final userData = state.pathParameters['userData'] as UserData;
        return CompleteProfileScreen(userData: userData);
      },
    ),
    
    GoRoute(
      path: ForgotPasswordScreen.routeName,
      builder : (context, state) => const ForgotPasswordScreen()),

    GoRoute(
      path: ForgotPasswordScreen.routeName,
      builder : (context, state) => const ForgotPasswordScreen()),

    
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
            return InitScreen(child: child);
          },
      routes: [
              GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: HomeScreen.routeName,
              builder: (context, state) => const HomeScreen()),
              GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: HomeScreen.routeName,
              builder: (context, state) => const HomeScreen()),
              GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: SearchScreen.routeName,
              builder: (context, state) => const SearchScreen()),
              GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: FavoriteScreen.routeName,
              builder: (context, state) => const FavoriteScreen()),
              GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: CartScreen.routeName,
              builder: (context, state) => const CartScreen()),
              GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: ProfileScreen.routeName,
              builder: (context, state) => const ProfileScreen()),
    ])
  ],
);
