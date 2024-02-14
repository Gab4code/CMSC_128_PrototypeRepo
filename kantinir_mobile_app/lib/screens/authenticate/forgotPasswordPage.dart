import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantinir_mobile_app/screens/authenticate/register.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:kantinir_mobile_app/screens/authenticate/authenticate.dart';
import 'package:kantinir_mobile_app/shared/constants.dart';
import 'package:kantinir_mobile_app/screens/authenticate/changePassword.dart';

class forgotPasswordPage extends StatefulWidget {
  final Function toggleView;
  forgotPasswordPage({super.key, required this.toggleView});

  @override
  State<forgotPasswordPage> createState() => _RegisterState();
}

class _RegisterState extends State<forgotPasswordPage> {
  final AuthService _auth = AuthService();

  // key to associate data
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;
  void _handleRegisterError(String errorMessage) {
    setState(() {
      _errorMessage =
          errorMessage.replaceAllMapped(RegExp(r'\[[^\]]*\]'), (match) {
        return ''; // Replace the matched content with an empty string
      });
    });
  }

  // text field state
  String email = '';
  String password = '';
  String fcolor = '';
  String password1 = '';
  String confirmPassword = '';
  String error = '';
  String bday = '';
  String username = '';

  TextEditingController dateInput =
      TextEditingController(); // Initialize the controller

  String selectedEducationLevel = '';
  String educationValue = 'Choose education level';
  var educationLevels = [
    'Choose education level',
    'Elementary',
    'High School',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Ph.D.',
  ];
  String selectedColorLevel = '';
  String colorValue = 'Choose a color';
  var colorLevels = [
    'Choose a color',
    'red',
    'orange',
    'yellow',
    'green',
    'blue',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 40,
                        color: Color(0xFF22A1BB),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 0),
                const Text(
                  "You can reset your password if you answer all of these correctly",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon:
                          const Icon(Icons.email, color: Color(0xFFB6B6B6)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      print(email);
                      setState(() => email = val);
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _auth.resetPassword(email: email);
                      // You can add logic here for showing a confirmation message
                    }
                  },
                  child: Text('Send Reset Email'),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                const SizedBox(height: 180),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
