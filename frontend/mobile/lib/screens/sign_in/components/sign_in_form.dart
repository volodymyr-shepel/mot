import 'package:flutter/material.dart';
import 'package:mot/components/custom_text_form_field.dart';
import 'package:mot/screens/sign_in/sign_in_success_screen.dart';
import '../../../constants.dart';
import '../../../helper/keyboard.dart';
import '../../forgot_password/forgot_password_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for encoding/decoding JSON
import '../../../components/secure_storage_manager.dart';


class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;


  bool isCorrect = true;
  // Commenting out the error handling related variables

  // Your backend API URL
  final String apiUrl = '$baseUrl/api/auth/user/v1/signIn';

  Future<void> signIn() async {
    // Check if the form is valid before making the request
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

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
          print('Sign-in successful! Response data: ${response.body}');
          // Navigate to the success screen or perform other actions
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          final String? accessToken = responseData['access_token'];
          final String? refreshToken = responseData['refresh_token'];

          // Save tokens to secure storage
          if (accessToken != null && refreshToken != null) {
            await SecureStorageManager().saveData('access_token', accessToken);
            await SecureStorageManager().saveData('refresh_token', refreshToken);
          }
          isCorrect = true;

          Navigator.pushNamed(context, SignInSuccessScreen.routeName);
        } else {
          // Request failed with an error status code
          print('Failed to sign in, status code: ${response.statusCode}');

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
              if (value!.isEmpty || !emailValidatorRegExp.hasMatch(value)) {
                return "Invalid Email";
              }
              else if(!isCorrect){
                return "Verify your email";
              }
              return null;
            },
        ),
          const SizedBox(height: 20),
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
            else if(!isCorrect){
              return "Verify your password"; // used in situation when the backend returns 
            }
            return null; 
          },
        ),
          const SizedBox(height: 15),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      context, ForgotPasswordScreen.routeName),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      
      KeyboardUtil.hideKeyboard(context);
      
      await signIn();

      isCorrect = true; 
    }
  },
  child: const Text("Continue"),
),
        ],
      ),
    );
  }
}
