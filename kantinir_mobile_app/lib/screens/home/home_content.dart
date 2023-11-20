import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:kantinir_mobile_app/services/my_list_tile.dart';
import '../food_page/foodPage.dart';
import '../housing_page/housingPage.dart';

class Home_contentPage extends StatefulWidget {
  const Home_contentPage({super.key});

  @override
  State<Home_contentPage> createState() => _Home_contentPageState();
}

class _Home_contentPageState extends State<Home_contentPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser.email)
          .snapshots(),

          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              String colorName = userData["fcolor"].toString().toLowerCase();
              
              Color selectedColor = ColorMapper.getColor(colorName);
              
              return Container(
                color: selectedColor,
                child: Center(
                  child: Column(
                    children: [
                      Text(userData["username"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
                        
                      
                      ElevatedButton(onPressed: () {}, child: Text("Greet Happy birthday"))
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
                return Center(child: Text('Error${snapshot.error}')
                );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
        // appBar: AppBar(
        //   body: Co
        //   title: Text('Add Sensor',
        //       style: TextStyle(color: Colors.black), textAlign: TextAlign.center),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        );
  }
}

class ColorMapper{
  static final Map<String, Color> colorMap = {
    'red' : Colors.red,
    'orange' : Colors.orange,
    'yellow' : Colors.yellow,
    'green' :Colors.green,
    'blue' : Colors.blue,
  };



static Color getColor(String colorName) {
  return colorMap[colorName.toLowerCase()] ?? Colors.black;
}
}
