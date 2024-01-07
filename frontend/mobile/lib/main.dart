import 'package:flutter/material.dart';
import 'package:mot/helper/app_router.dart';
import 'package:mot/routes.dart';
import 'package:mot/screens/welcome_screen/welcome_screen.dart';
import 'theme.dart';

void main() {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MOT',
      theme: AppTheme.darkTheme(context),
      routerConfig: router,
    );
  }
}
