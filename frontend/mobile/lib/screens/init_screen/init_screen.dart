import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mot/constants.dart';
import 'package:mot/screens/profile/profile_screen.dart';


class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

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

  final List<Widget> pages = [
    const Center(
      child: Text("Home Screen", style: TextStyle(fontSize: 24.0)),
    ),
    const Center(
      child: Text("Search Screen", style: TextStyle(fontSize: 24.0)),
    ),
    const Center(
      child: Text("Favorite Screen", style: TextStyle(fontSize: 24.0)),
    ),
    const Center(
      child: Text("Cart Screen", style: TextStyle(fontSize: 24.0)),
    ),
    const ProfileScreen()
  ];

  final List<AppBar> appBars = [
    AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryDarkColor,
      title: Text(
        'Home',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryDarkColor,
      title: Text(
        'Search',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryDarkColor,
      title: Text(
        'Favorite',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryDarkColor,
      title: Text(
        'Cart',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    ),
    AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryDarkColor,
      title: Text(
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
