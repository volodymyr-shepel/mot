import 'package:flutter/material.dart';
import 'package:mot/screens/forgot_password/forgot_password_success_screen.dart';
import '../../../components/no_account_text.dart';
import '../../../constants.dart';
import '../../../components/custom_text_form_field.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../helper/keyboard.dart';

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;

  final String apiUrl = '$baseUrl/api/auth/account/v1/forgetPassword';

  bool isCorrect = true;


  

  

  Future<void> sendForgotPasswordRequest() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json', // Set the correct content type here
        },
        body: jsonEncode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Request was successful, you can handle the response data here
        print('Forgot password request successful! Response data: ${response.body}');
        // Navigate to the success screen or perform other actions
        Navigator.pushNamed(context, ForgotPasswordSuccessScreen.routeName);

        isCorrect = true;
      } else {
        // Request failed with an error status code
        print('Failed to send forgot password request, status code: ${response.statusCode}');
        // Handle error, show a message, or perform other actions
        isCorrect = false; 
        _formKey.currentState!.validate(); // revalidate since the response to the backend was not successful

      }
    } catch (error) {
      // Handle other errors, such as network issues
      print('Error during forgot password request: $error');
      // Show an error message or perform other actions
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
          const SizedBox(height: 8),
          //FormError(errors: errors),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async{
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                
                KeyboardUtil.hideKeyboard(context);

                await sendForgotPasswordRequest(); // Call the function to send the request

                isCorrect = true; 
              }
            },
            child: const Text("Continue"),
          ),
          const SizedBox(height: 16),
          const NoAccountText(),
        ],
      ),
    );
  }
}
