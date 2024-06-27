import 'package:flutter/material.dart';
import 'package:mot/constants.dart';

import '../../../size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.press,
  });

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: SizeConfig(context: context).getProportionateScreenWidth(18),
            color: kPrimaryLightColor,
            overflow: TextOverflow.ellipsis
            
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            "See More",
            style: TextStyle(color: kPrimaryLightColor),
          ),
        ),
      ],
    );
  }
}