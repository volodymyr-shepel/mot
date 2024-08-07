import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig(context: context).screenWidth * 0.75,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig(context: context).getProportionateScreenWidth(20),
                vertical: SizeConfig(context: context).getProportionateScreenWidth(14)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            hintStyle: TextStyle(color: kTextColor.withOpacity(0.3)),
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}