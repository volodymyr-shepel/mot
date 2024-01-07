import 'package:flutter/material.dart';
import 'package:mot/screens/home/components/header/icon_button_with_counter.dart';
import '../../../../size_config.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig(context: context).getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconButttonWithCounter(
            svgSrc: "assets/icons/Cart Icon.svg",
            press: () {},
          ),
          IconButttonWithCounter(
            svgSrc: "assets/icons/Bell.svg",
            numOfitem: 4,
            press: () {},
          ),
        ],
      ),
    );
  }
}