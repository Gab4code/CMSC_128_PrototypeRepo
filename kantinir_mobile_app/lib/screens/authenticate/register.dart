import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:kantinir_mobile_app/screens/authenticate/authenticate.dart';
import 'package:kantinir_mobile_app/shared/constants.dart';


class Register extends StatefulWidget {
  final Function toggleView;
  Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  // key to associate data
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;
  void _handleRegisterError(String errorMessage) {
    setState(() {
      _errorMessage = errorMessage.replaceAllMapped(RegExp(r'\[[^\]]*\]'), (match) {
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
      backgroundColor: Color.fromARGB(255, 200, 255, 236),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 63, 77),
        elevation: 0.0,
        title: Text('Register to KanTinir'),
        actions: <Widget>[
          TextButton.icon(
              icon: Icon(Icons.person),
              label: Text('Sign In'),
              onPressed: () {
                widget.toggleView();
              })
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(  
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter a valid email'),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Username'),
                  validator: (val) => val!.isEmpty ? 'Enter your Username' : null,
                  onChanged: (val) {
                    setState(() => username = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Enter a valid password'),
                  obscureText: true,
                  validator: (val) =>
                      val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() => password1 = val);
                  },
                ),
                SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Retype your password',
                        fillColor: Color.fromARGB(255, 235, 235, 235),
                      ),
                      obscureText: true,
                      validator: (val) =>
                          val != password1 ? 'Passwords do not match' : null,
                      onChanged: (val) {
                        setState(() => confirmPassword = val);
                      },
                    ),
                SizedBox(height: 20.0),
          
                    TextField(
                      style: TextStyle(color: Colors.black),
                      controller: dateInput,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Enter Birthdate",
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                        );
          
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateInput.text = formattedDate;
                            bday = formattedDate;
                          });
                        }
                      },
                    ),
          
                    SizedBox(height: 12.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton(
                        // Initial Value
                        value: educationValue,
          
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
          
                        // Set the style to change the text color
                        style: const TextStyle(
                            color: Color.fromARGB(255, 83, 98, 93), fontSize: 17),
          
                        // Array list of items
                        items: educationLevels.map((String educationItem) {
                          return DropdownMenuItem(
                            value: educationItem,
                            child: Text(educationItem),
                          );
                        }).toList(),
          
                        // After selecting the desired option, it will
                        // change the button value to the selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            educationValue = newValue!;
                          });
                        },
                      ),
                    ),
                
                SizedBox(height: 12.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton(
                        
                        value: colorValue,
          
                        
                        icon: const Icon(Icons.keyboard_arrow_down),
          
                        
                        style: const TextStyle(
                            color: Color.fromARGB(255, 83, 98, 93), fontSize: 17),
          
                        
                        items: colorLevels.map((String coloritem) {
                          return DropdownMenuItem(
                            value: coloritem,
                            child: Text(coloritem),
                          );
                        }).toList(),
          
                        // After selecting the desired option, it will
                        // change the button value to the selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            colorValue = newValue!;
                          });
                        },
                      ),
                    ),
          
          
          
          
          
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 113, 62)),
                  child: Text('Register',
                      style: const TextStyle(color: Colors.white)),
                  onPressed: () async { 
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(     //Changed result to usercreds
                          email, username ,confirmPassword, colorValue, bday, educationValue ,_handleRegisterError);
                      
                      if (result == null) {
                        setState(() => error = _errorMessage!);
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


