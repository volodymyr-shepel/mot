import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mot/components/custom_text_form_field.dart';
import 'package:mot/models/user_data.dart';
import 'package:mot/screens/sign_up/sign_up_success_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants.dart';

class CompleteProfileForm extends StatefulWidget {
  final UserData userData;
  
  CompleteProfileForm({super.key, required this.userData});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String? firstName;
  String? lastName;
  
  Future<void> signUp() async {
    // Your API endpoint
    final String apiUrl = '$baseUrl/api/auth/user/v1/signUp';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': widget.userData.getEmail(),
          'password': widget.userData.getPassword(),
          'firstName':  widget.userData.getFirstName(),
          'lastName': widget.userData.getLastName(),
          "userRole": "CUSTOMER" // TODO: change it also in backend
          
        }),
      );

      if (response.statusCode == 201) {
        // Successful response, handle it accordingly
        print('Request successful: ${response.body}');
        // Navigate to the next screen on success
        context.go(SignUpSuccessScreen.routeName);
      } else {
        // Error response, handle errors
        print('Error: ${response.statusCode}, ${response.body}');
      }
    } catch (error) {
      // Exception occurred during the request
      print('Error: $error');
    }
  }
  
  

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
              CustomTextFormField(
            labelText: "First Name",
            hintText: "Enter your first name",
            onSaved: (newValue) => firstName = newValue,
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return "First name can not be empty";
              }
              return null;
            },
            keyboardType: TextInputType.text,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            obscureText: false,
            labelText: "Last Name",
            hintText: "Enter your last name",
            onSaved: (newValue) => lastName = newValue,
            validator: (value) {
              if (value!.isEmpty) {
                return "Last name can not be empty";
              }
              return null;
            },
            keyboardType: TextInputType.text,
      ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async{
              if (_formKey.currentState!.validate()) {
                // Save the form data to userData after validation
                _formKey.currentState!.save();
                
                // Set the first name and last name in the userData instance
                widget.userData.setFirstName(firstName);
                widget.userData.setLastName(lastName);

                await signUp();
                
    }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
