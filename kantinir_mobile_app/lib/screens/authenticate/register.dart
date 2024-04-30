import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kantinir_mobile_app/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({Key? key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();

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
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dateInputController.dispose();
    super.dispose();
  }

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
                  "Create your",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "account",
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
                    controller: emailController,
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
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      prefixIcon:
                          const Icon(Icons.person, color: Color(0xFFB6B6B6)),
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
                    validator: (val) =>
                        val!.isEmpty ? 'Enter your username' : null,
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFFB6B6B6)),
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
                    obscureText: true,
                    validator: (val) => val!.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextFormField(
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFFB6B6B6)),
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
                    obscureText: true,
                    validator: (val) => val != passwordController.text
                        ? 'Passwords do not match'
                        : null,
                  ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextField(
                    controller: dateInputController,
                    style: TextStyle(color: Colors.black),
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
                        dateInputController.text = formattedDate;
                      }
                    },
                  ),
                ),
                SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: DropdownButton(
                      value: educationValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 83, 98, 93), fontSize: 17),
                      items: educationLevels.map((String educationItem) {
                        return DropdownMenuItem(
                          value: educationItem,
                          child: Text(educationItem),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          educationValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 110),
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
                      onChanged: (String? newValue) {
                        setState(() {
                          colorValue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 0, 113, 62)),
                  child: const Text('Register',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          emailController.text,
                          usernameController.text,
                          confirmPasswordController.text,
                          colorValue,
                          dateInputController.text,
                          educationValue,
                          _handleRegisterError);
                      Navigator.pop(context);

                      if (result == null) {
                        setState(() => _errorMessage = _errorMessage!);
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  _errorMessage ?? '',
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

  void _handleRegisterError(String errorMessage) {
    setState(() {
      _errorMessage =
          errorMessage.replaceAllMapped(RegExp(r'\[[^\]]*\]'), (match) {
        return ''; // Replace the matched content with an empty string
      });
    });
  }
}
