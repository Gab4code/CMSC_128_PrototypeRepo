import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:kantinir_mobile_app/services/my_list_tile.dart';

class profilePage extends StatefulWidget {
  profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Center(
                child: Icon(
                  Icons.person,
                  size: 200,
                ),
              ),
             MyListTile(
              icon: Icons.manage_accounts,
              text: 'Username',
              onTap: () {
                //username tap function
              },
             ),
             MyListTile(
              icon: Icons.manage_accounts,
              text: currentUser.email!,
              onTap: () {
                //email tap function
              },
             ),
             MyListTile(
              icon: Icons.admin_panel_settings,
              text: 'Change Password',
              onTap: () {
                //username tap functionality (edit user)
              },
             ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
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
            ),)
        ],
      ),
    );
  }
}