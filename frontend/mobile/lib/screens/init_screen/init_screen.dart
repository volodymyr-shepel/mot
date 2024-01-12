import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mot/components/bottom_navigation_bar.dart';
import 'package:mot/screens/cart_screen/cart_screen.dart';
import 'package:mot/screens/favorite_screen/favorite_screen.dart';
import 'package:mot/screens/home/home_screen.dart';
import 'package:mot/screens/profile_screen/profile_screen.dart';
import 'package:mot/screens/search_screen/search_screen.dart';

// transition between different pages works fine( now it may look strange black appearence but it is because there is no elements)
class InitScreen extends StatefulWidget {
  const InitScreen({Key? key, required this.child}) : super(key: key);

  final Widget child;

  // TODO: change the route name from / to smth else
  static String routeName = "/init";

  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  String indexToPath(int index) {
    switch(index){
      case 0: return HomeScreen.routeName;
      case 1: return SearchScreen.routeName;
      case 2: return FavoriteScreen.routeName;
      case 3: return CartScreen.routeName;
      case 4: return ProfileScreen.routeName;
      default : return HomeScreen.routeName;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentSelectedIndex,
        onTap: (int index) {
          setState(() {
            currentSelectedIndex = index;
          });
          context.go(indexToPath(index));
        },
      ),
    );
  }
}
