import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF4E4F51),width : 0.5),
          bottom: BorderSide(color: Color(0xFF4E4F51),width : 0.5),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: 22,
                    ),
                    const SizedBox(width: 20),
                    Text(text),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white, // Set the color to white
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





