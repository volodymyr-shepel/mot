import 'package:flutter/material.dart';
import '../constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String?>? validator;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.keyboardType,
    required this.obscureText,
    this.onSaved,
    this.validator,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(), // Adjust the padding as needed
      child: TextFormField(
        obscureText: widget.obscureText && !_showPassword,
        onSaved: widget.onSaved,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(29.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor),
            borderRadius: BorderRadius.circular(29.0),
          ),
          hintStyle: const TextStyle(color: Color(0xFF4E4F51)),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
