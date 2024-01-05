import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mot/constants.dart';
import 'package:mot/screens/cart_screen/cart_screen.dart';
import 'package:mot/screens/favorite_screen/favorite_screen.dart';
import 'package:mot/screens/home_screen/home_screen.dart';
import 'package:mot/screens/profile_screen/profile_screen.dart';
import 'package:mot/screens/search_screen/search_screen.dart';


class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  // TODO: change the route name from / to smth else
  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }
  // TODO : Change to the pages
  final List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];

  final List<AppBar> appBars = [
    AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Home',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Search',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Favorite',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Cart',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        'Profile',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
  ];


  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars[currentSelectedIndex],
      body: pages[currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        backgroundColor: kPrimaryDarkColor,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Shop Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Search Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Search Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Heart Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/Cart Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/Cart Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              "assets/icons/User Icon.svg",
              colorFilter: const ColorFilter.mode(
                kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
