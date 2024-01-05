import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import for working with SVG
import '../../../constants.dart';

class SearchField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final ValueChanged<String?>? onSaved;
  final String? svgIconPath; // Path to your SVG icon

  const SearchField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    this.onSaved,
    this.svgIconPath,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Adjust the padding as needed
      child: TextFormField(
        onSaved: widget.onSaved,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.svgIconPath != null
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    widget.svgIconPath!,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    width: 22,
                  ),
                )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          isDense: true, // Reduce the height of the input field
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(29.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(29.0),
          ),
          hintStyle: const TextStyle(color: Color(0xFF4E4F51)),
        ),
      ),
    );
  }
}
