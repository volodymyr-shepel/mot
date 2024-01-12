import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF8138BF);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kTextColor = Colors.white;
const kAnimationDuration = Duration(milliseconds: 200);
const kPrimaryDarkColor = Color(0xFF222325);


const kSecondaryColor = Color(0xFF979797);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

final RegExp passwordValidatorRegExp = 
    RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{12,}$');
    
const String kEmailNullError = "Please Enter your email";

const String kInvalidEmailError = "Please Enter Valid Email";

const String kPassNullError = "Please Enter your password";

const String kShortPassError = "Password is too short";

const String kMatchPassError = "Passwords don't match";

const String kNamelNullError = "Please Enter your name";

const String kPhoneNumberNullError = "Please Enter your phone number";

const String kAddressNullError = "Please Enter your address";



const String baseUrl = 'http://192.168.137.1:80';
//192.168.137.1
//192.168.1.46
//192.168.0.102
//192.168.0.101


const headingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);