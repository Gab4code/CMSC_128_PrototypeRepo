import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kantinir_mobile_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../food_page/foodPage.dart';
import '../housing_page/housingPage.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({super.key});

  @override
  State<HousingPage> createState() => _housingPageState();
}

class _housingPageState extends State<HousingPage> {
  final CollectionReference _tinir = FirebaseFirestore.instance.collection("tinir");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 500,
              child: StreamBuilder<QuerySnapshot>(
                stream: _tinir.orderBy('averageRating', descending: true).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }
                  if (snapshots.hasData) {
                    return ListView.builder(
                      itemCount: snapshots.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot records = snapshots.data!.docs[index];
                        final reviewsCollection = records.reference.collection('reviews');

                        return StreamBuilder<double>(
                          stream: getAverageRatingStream(reviewsCollection, records.reference),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            if (snapshot.hasData) {
                              final averageRating = snapshot.data!;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, records["name"]);
                                  },
                                  child: Slidable(
                                    startActionPane: ActionPane(motion: StretchMotion(), children: []),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: ListTile(
                                        title: Text(records["name"]),
                                        subtitle: Text(records["owner"] + '\n' + (records["fb link"]) + '\n' + (records["location"])),
                                        trailing: Text('Average Rating: ${averageRating.toStringAsFixed(1)}'),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container(); // Placeholder while waiting for rating
                          },
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<double> getAverageRatingStream(CollectionReference reviewsCollection, DocumentReference documentReference) {
  return reviewsCollection.snapshots().map((snapshot) {
    if (snapshot.docs.isEmpty) {
      return 0.0;
    }

    double totalRating = 0;
    for (var doc in snapshot.docs) {
      final data = doc.data();
      if (data != null && data is Map<String, dynamic> && data.containsKey('rating')) {
        final rating = data['rating'];
        if (rating is num) {
          totalRating += rating.toDouble(); // Assuming rating is a numeric value
        }
      }
    }

    final averageRating = totalRating / snapshot.docs.length;
    documentReference.update({'averageRating': averageRating}); // Update Firestore with the average rating
    return averageRating;
  });
}
}
