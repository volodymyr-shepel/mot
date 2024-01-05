import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mot/constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  static const Color inActiveIconColor = Color(0xFFB6B6B6);
  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      backgroundColor: kPrimaryDarkColor,
      currentIndex: currentIndex,
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
    );
  }
}
