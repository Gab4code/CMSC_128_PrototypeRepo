import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:kantinir_mobile_app/services/my_list_tile.dart';

class profilePage extends StatefulWidget {
  profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  String imageUrl = '';
  final AuthService _auth = AuthService();
  String educationValue = 'Choose education level';
  var educationLevels = [
    'Choose education level',
    'Elementary',
    'High School',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Ph.D.',
  ];

  // TextEditingController for updating the username
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  Future<void> _changePassword(
      String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email!, password: currentPassword);

    try {
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
      print('Password updated successfully!');
    } catch (error) {
      print('Error updating password: $error');
      // Handle error here
    }
  }

  @override
  void dispose() {
    // Dispose the controller when the state is disposed
    usernameController.dispose();
    super.dispose();
  }

  // Future<void> _selectDate(
  //     BuildContext context, Map<String, dynamic> userData) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1950),
  //     lastDate: DateTime(2100),
  //   );

  //   if (pickedDate != null && pickedDate != DateTime.now()) {
  //     String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

  //     await FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(currentUser.email)
  //         .update({'birthdate': formattedDate});
  //   }
  // }

  // Future<void> _showEducationDropdown(BuildContext context) async {
  //   String? newValue = await showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Select Education Level'),
  //         content: DropdownButton<String>(
  //           value: educationValue,
  //           icon: const Icon(Icons.keyboard_arrow_down),
  //           style: const TextStyle(
  //             color: Color.fromARGB(255, 83, 98, 93),
  //             fontSize: 17,
  //           ),
  //           items: educationLevels.map((String educationItem) {
  //             return DropdownMenuItem<String>(
  //               value: educationItem,
  //               child: Text(educationItem),
  //             );
  //           }).toList(),
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               educationValue = newValue!;
  //             });
  //             Navigator.of(context).pop(newValue);
  //           },
  //         ),
  //       );
  //     },
  //   );

  //   if (newValue != null) {
  //     await FirebaseFirestore.instance
  //         .collection("Users")
  //         .doc(currentUser.email)
  //         .update({'education': newValue});
  //   }
  // }

  File? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);

    //String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    //Step 2: upload to Firebase storage

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload =
        referenceDirImages.child('${currentUser.uid}.jpg');

    try {
      await referenceImageToUpload.putFile(File(file!.path));

      imageUrl = await referenceImageToUpload.getDownloadURL();

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.email)
          .update({'profileImageURL': imageUrl});
    } catch (error) {
      //Some error occured
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF11CDA7),
          title: Text("User Profile", style: TextStyle(color: Colors.white)),
          iconTheme: IconThemeData(
              color: Colors.white), // Set the color of the back arrow to white
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 50),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Center(
                            child: userData['profileImageURL'] != null
                                ? ClipOval(
                                    child: Image.network(
                                    userData['profileImageURL'],
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ))
                                : Icon(
                                    Icons.person,
                                    size: 150,
                                  ),
                          ),
                        ),
                        MyListTile(
                          icon: Icons.manage_accounts,
                          text: "Username: " + userData["username"],
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Edit Username'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        TextField(
                                          controller: usernameController,
                                          decoration: InputDecoration(
                                            hintText: 'Enter new Username',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Update'),
                                      onPressed: () async {
                                        String newUsername =
                                            usernameController.text.trim();

                                        // Update the Firestore document with the new username
                                        await FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(currentUser.email)
                                            .update({"username": newUsername});

                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        MyListTile(
                          icon: Icons.email,
                          text: "Email: " + currentUser.email!,
                        ),
                        MyListTile(
                          icon: Icons.admin_panel_settings,
                          text: 'Change Password',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Change Password'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            labelText: 'Current Password'),
                                      ),
                                      TextField(
                                        controller: emailController,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            labelText: 'New Password'),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Update'),
                                      onPressed: () async {
                                        String currentPassword =
                                            passwordController.text.trim();
                                        String newPassword =
                                            emailController.text.trim();

                                        await _changePassword(
                                            currentPassword, newPassword);

                                        // Clear the text fields after updating password
                                        passwordController.clear();
                                        emailController.clear();

                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Success'),
                                              content: Text(
                                                  'Password changed successfully!'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 26.0),
                      child: Container(
                        color: Colors.grey,
                        child: MyListTile(
                          icon: Icons.logout,
                          text: 'Log Out',
                          onTap: () async {
                            await _auth.signOut();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error${snapshot.error}'));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }
}
