import 'package:flutter/material.dart';
import 'package:mot/screens/complete_profile/complete_profile_screen.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../constants.dart';
import '../../../models/user_data.dart';
//import '../../complete_profile/complete_profile_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for encoding/decoding JSON

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;

  bool isCorrect = true;

  UserData userData = UserData();

  Future<void> validateCredentials() async {
  const String apiUrl = '$baseUrl/api/auth/user/v1/validateCredentials';

  // Check if the form is valid before making the request
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save(); // Save the form fields

    try {
      // Make a POST request to your backend
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the correct content type here
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      // Check the response status code
      if (response.statusCode == 200) {
        // Request was successful, you can handle the response data here
        print('Credentials validated successfully! Response data: ${response.body}');
        // Navigate to the success screen or perform other actions
        userData.setEmail(email);
        userData.setPassword(password);
        // if all are valid then go to success screen

        isCorrect = true;

        Navigator.push(context, MaterialPageRoute(builder: (context) => CompleteProfileScreen(userData: userData)));

      } else {
        // Request failed with an error status code
        print('Failed to validate credentials, status code: ${response.statusCode}');
        isCorrect = false; 
        _formKey.currentState!.validate(); // revalidate since the response to the backend was not successful
        // Handle error, show a message, or perform other actions
      }
    } catch (error) {
      // Handle other errors, such as network issues
      print('Error during sign-in: $error');
      // Show an error message or perform other actions
    }
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
      
          CustomTextFormField(
            obscureText: false,
          labelText: "Email",
          hintText: "Enter your email",
          keyboardType: TextInputType.emailAddress, // Set the keyboard type
          onSaved: (newValue) => email = newValue,
          validator: (value) {
            if(!isCorrect){
              return "Email already taken";

            }
            else if (value!.isEmpty || !emailValidatorRegExp.hasMatch(value)) {
              return "Invalid Email";
            }
            return null;
          },
        ),
          const SizedBox(height: 16),
          CustomTextFormField(
        labelText: "Password",
        hintText: "Enter your password",
        keyboardType: TextInputType.text,
        obscureText: true,
        onSaved: (newValue) => password = newValue,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password can not be empty";
          } else if (!passwordValidatorRegExp.hasMatch(value)) {
            return "Invalid Password";
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
          CustomTextFormField(
        labelText: "Confirm password",
        hintText: "Re-enter your password",
        keyboardType: TextInputType.text,
        obscureText: true,
        onSaved: (newValue) => confirmPassword = newValue,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password can not be empty";
          } else if (password != null && password != value) {
            return "Passwords do not match";
          }
          return null;
          },

      ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              validateCredentials();   
              isCorrect = true;

            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
