import 'package:flutter/material.dart';
import 'package:mot/helper/app_router.dart';
import 'package:mot/models/cart.dart';
import 'package:mot/routes.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

void main() {
  
  runApp(
    ChangeNotifierProvider(
        create: (context) => CartProvider(),
        child: MyApp(),
      ),
    );
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
