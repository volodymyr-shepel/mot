import 'package:flutter/material.dart';
import 'package:mot/constants.dart';

import 'components/profile_menu.dart';
import 'components/profile_pic.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);
// TODO: code refactor and change ProfileMenu fields and icons, and profile pic
class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text(
          "Profile",
          style: TextStyle(fontSize: 20.0,color: Colors.white),
        )
      ),
      // TODO : remove app bar here since the nvigation will be done from init screen and only body of the screen will change 
      // so app bar and bottom menu will be from the init screen, that is why it is not needed here
      // but for now i will leave it here since there is no init screen still
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: kPrimaryDarkColor,
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 40),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
