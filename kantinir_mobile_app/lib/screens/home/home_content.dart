import 'package:async/async.dart';
import 'package:confetti/confetti.dart';
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
import 'package:rxdart/rxdart.dart';
import '../food_page/foodPage.dart';
import '../housing_page/housingPage.dart';

class Home_contentPage extends StatefulWidget {
  const Home_contentPage({Key? key}) : super(key: key);

  @override
  State<Home_contentPage> createState() => _Home_contentPageState();
}

class _Home_contentPageState extends State<Home_contentPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool _showImage = false;
  Widget currentPage = Container();
  int currentIndex = 0;

  
  


  @override
  void initState() {
    super.initState();
    _showWelcomeDialog();
  }

  void _showWelcomeDialog() {
    Future.delayed(Duration.zero, () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Welcome!"),
            content: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Users")
                  .doc(currentUser.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                    "Welcome, ${userData["username"]}!",
                    style: TextStyle(fontSize: 18),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "What are you looking for?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.restaurant, size: 70,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FoodPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.house, size: 70),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HousingPage()),
                  );
                },
              ),
            ],
          ),
          Flexible(
            child: FoodPageList(),     
          ),
        ],
      ),
    );
  }
}

class FoodPageList extends StatelessWidget {
  final CollectionReference _kaon = FirebaseFirestore.instance.collection("kaon");
  final CollectionReference _tinir = FirebaseFirestore.instance.collection("tinir");
  

  @override Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: 400,
              child: StreamBuilder<List<QueryDocumentSnapshot>>(
                stream: _mergeAndSortCollectionStreams(),
                builder: (context, AsyncSnapshot<List<QueryDocumentSnapshot>> snapshots) {
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  }
                  if (snapshots.hasData) {

                    List<QueryDocumentSnapshot> combinedData = snapshots.data!;

                    
                    return ListView.builder(
                      itemCount: combinedData.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot records = combinedData[index];
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

    Stream<List<QueryDocumentSnapshot>> _mergeAndSortCollectionStreams() {
    return CombineLatestStream.combine2(
    _kaon.orderBy('averageRating', descending: true).snapshots(),
    _tinir.orderBy('averageRating', descending: true).snapshots(),
    (QuerySnapshot kaonSnap, QuerySnapshot tinirSnap) {
      final List<QueryDocumentSnapshot> kaonDocs = kaonSnap.docs;
      final List<QueryDocumentSnapshot> tinirDocs = tinirSnap.docs;

      // Combine and sort the snapshots from both collections
      List<QueryDocumentSnapshot> combinedSorted = [...kaonDocs, ...tinirDocs];
      combinedSorted.sort((a, b) => b['averageRating'].compareTo(a['averageRating']));

      return combinedSorted;
    },
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