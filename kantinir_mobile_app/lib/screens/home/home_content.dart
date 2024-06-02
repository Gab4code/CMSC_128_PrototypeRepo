import 'package:async/async.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/48coffee/48coffee.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/aj_foodhub/aj_foodhub.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/elgaraje/el_garaje.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/kubo_resto/kubo_resto.dart';
import 'package:kantinir_mobile_app/screens/food_page/food_establishments/mrj_chickenhouse/mrj.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/arkids/arkids_dorm.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/gumamela/gumamela.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/kp_vision/kp_vision.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/lampirong/lampirong.dart';
import 'package:kantinir_mobile_app/screens/housing_page/housing_establishments/royal_angels/royal_angels_dorm.dart';
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
  final CollectionReference _kaon =
      FirebaseFirestore.instance.collection("kaon");
  final CollectionReference _tinir =
      FirebaseFirestore.instance.collection("tinir");

  CollectionReference currentCollection =
      FirebaseFirestore.instance.collection("kaon");

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool _showImage = false;
  bool _isKaon = true;
  bool _isTinir = false;
  Widget currentPage = Container();
  int currentIndex = 0;

  void updateCollection(bool isKaon) {
    setState(() {
      currentCollection = isKaon ? _kaon : _tinir;
    });
  }

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
            title: Text("SUCCESS!!"),
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

  //Food locations:
  static const LatLng coffe48 = LatLng(10.644219962559625, 122.23453346858548);
  static const LatLng ajfoodhub =
      LatLng(10.641543474891401, 122.23463168207635);
  static const LatLng elgaraje = LatLng(10.642538230966712, 122.23808618022197);
  static const LatLng kubo = LatLng(10.653040111908794, 122.22824011091275);
  static const LatLng mrj = LatLng(10.646931169482333, 122.23547955324015);
  //Housing locations:
  static const LatLng arkids = LatLng(10.63980614399443, 122.20935600720381);
  static const LatLng gumamela = LatLng(10.649349782428317, 122.22687774953113);
  static const LatLng kp_vision =
      LatLng(10.654375291531712, 122.23145595324026);
  static const LatLng lampirong =
      LatLng(10.64891466416987, 122.22734214160364);
  static const LatLng royal_angels =
      LatLng(10.65382778694199, 122.22926060905857);

  static const LatLng _initialPosition = LatLng(10.642314141212928, 122.23080753789462);

  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  Set<Marker> _getMarkers() {
    if (currentCollection == _kaon) {
      return {
        Marker(
          markerId: MarkerId("coffee48"),
          icon: BitmapDescriptor.defaultMarker,
          position: coffe48,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => coffee48Page(),
                    ),
                  );
                },
        ),
        Marker(
          markerId: MarkerId("ajfoodhub"),
          icon: BitmapDescriptor.defaultMarker,
          position: ajfoodhub,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ajFoodHubPage(),
                    ),
                  );
                },
        ),
        Marker(
          markerId: MarkerId("elgaraje"),
          icon: BitmapDescriptor.defaultMarker,
          position: elgaraje,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => elGarajePage(),
                    ),
                  );
                },
        ),
        Marker(
          markerId: MarkerId("kubo"),
          icon: BitmapDescriptor.defaultMarker,
          position: kubo,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => kuboRestoPage(),
                    ),
                  );
                },
        ),
        Marker(
          markerId: MarkerId("mrj"),
          icon: BitmapDescriptor.defaultMarker,
          position: mrj,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => mrJChickenHouseCoffee(),
                    ),
                  );
                },
        ),
        
      };
    } else {
      return {
        Marker(
          markerId: MarkerId("arkids"),
          icon: BitmapDescriptor.defaultMarker,
          position: arkids,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => arkidsDormPage(),
                    ),
                  );
                },
        ),
        Marker(
          markerId: MarkerId("gumamela"),
          icon: BitmapDescriptor.defaultMarker,
          position: gumamela,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => gumamelaPage(),
                    ),
                  );
                },
        ),
        Marker(
          markerId: MarkerId("kp_vision"),
          icon: BitmapDescriptor.defaultMarker,
          position: kp_vision,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => kpVisionPage(),
                    ),
                  );
                },
        ),
        Marker(
          markerId: MarkerId("lampirong"),
          icon: BitmapDescriptor.defaultMarker,
          position: lampirong,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => lampirongPage(),
                    ),
                  );
                },
        ),
        Marker(
          markerId: MarkerId("royal_angels"),
          icon: BitmapDescriptor.defaultMarker,
          position: royal_angels,
          onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => royalAngelsPage(),
                    ),
                  );
                },
        ),
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Center(
            child: Text(
              'Popular',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Text(
              'Establishments',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
          ),
          // Center(
          //   child: Container(
          //     padding: EdgeInsets.all(16.0),
          //     child: Text(
          //       "What are you looking for?",
          //       style: TextStyle(
          //         fontFamily: 'Poppins',
          //         fontWeight: FontWeight.bold,
          //         fontSize: 20,
          //       ),
          //     ),
          //   ),
          // ),
          Center(
            child: Expanded(
              child: Center(
                child: Row(
                  //child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            updateCollection(true);
                            _isKaon = !_isKaon;
                            _isTinir = !_isTinir;
                          },
                          child: _isKaon == true
                              ? Image.asset(
                                  'images/food_lua3.png',
                                  //width: 50,
                                  height: 100,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  'images/food_lua4.png',
                                  //width: 50,
                                  height: 100,
                                  fit: BoxFit.contain,
                                )),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          updateCollection(false);
                          _isKaon = !_isKaon;
                          _isTinir = !_isTinir;
                        },
                        child: _isTinir == true
                            ? Image.asset(
                                'images/Housing_lua3.png',
                                //width: 50,
                                height: 100,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                'images/Housing_lua4.png',
                                //width: 50,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                  //),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Container(
              width: 380,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white, // Background color of the container
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 2, // Border width
                ),
              ),
              child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 13,
                  ),
                  markers: _getMarkers()),
            ),
          ),
          SizedBox(height: 5),
          Expanded(
            flex: 3,
            child: FoodPageList(
                kaonCollection: _kaon,
                tinirCollection: _tinir,
                collectionReference: currentCollection),
          ),
        ],
      ),
    );
  }
}

class FoodPageList extends StatelessWidget {
  // final CollectionReference _kaon = FirebaseFirestore.instance.collection("kaon");
  // final CollectionReference _tinir = FirebaseFirestore.instance.collection("tinir");
  final CollectionReference collectionReference;
  final CollectionReference kaonCollection;
  final CollectionReference tinirCollection;

  const FoodPageList(
      {Key? key,
      required this.collectionReference,
      required this.kaonCollection,
      required this.tinirCollection})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 400,
                child: StreamBuilder<List<QueryDocumentSnapshot>>(
                  stream: _mergeAndSortCollectionStreams(),
                  builder: (context,
                      AsyncSnapshot<List<QueryDocumentSnapshot>> snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    }
                    if (snapshots.hasData) {
                      List<QueryDocumentSnapshot> combinedData =
                          snapshots.data!;

                      List<QueryDocumentSnapshot> filteredData =
                          combinedData.where((doc) {
                        return doc.reference.parent == collectionReference;
                      }).toList();

                      return ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot records = filteredData[index];
                          final reviewsCollection =
                              records.reference.collection('reviews');

                          return StreamBuilder<double>(
                            stream: getAverageRatingStream(
                                reviewsCollection, records.reference),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasData) {
                                final averageRating = snapshot.data!;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, records["name"]);
                                    },
                                    child: Slidable(
                                      startActionPane: ActionPane(
                                          motion: StretchMotion(),
                                          children: []),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/${records["name"]}.jpg'),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                              Colors.white.withOpacity(0.8),
                                              BlendMode.srcOver,
                                            ),
                                          ),
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            records["name"],
                                          ),
                                          //subtitle: Text(records["owner"] + '\n' + (records["fb link"]) + '\n' + (records["location"])),
                                          trailing: Text(
                                              'Average Rating: ${averageRating.toStringAsFixed(1)}'),
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
                    return CircularProgressIndicator(color: Colors.red);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Stream<List<QueryDocumentSnapshot>> _mergeAndSortCollectionStreams() {
    return CombineLatestStream.combine2(
      kaonCollection.orderBy('averageRating', descending: true).snapshots(),
      tinirCollection.orderBy('averageRating', descending: true).snapshots(),
      (QuerySnapshot kaonSnap, QuerySnapshot tinirSnap) {
        final List<QueryDocumentSnapshot> kaonDocs = kaonSnap.docs;
        final List<QueryDocumentSnapshot> tinirDocs = tinirSnap.docs;

        // Combine and sort the snapshots from both collections
        List<QueryDocumentSnapshot> combinedSorted = [
          ...kaonDocs,
          ...tinirDocs
        ];
        combinedSorted
            .sort((a, b) => b['averageRating'].compareTo(a['averageRating']));

        return combinedSorted;
      },
    );
  }

  Stream<double> getAverageRatingStream(CollectionReference reviewsCollection,
      DocumentReference documentReference) {
    return reviewsCollection.snapshots().map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return 0.0;
      }

      double totalRating = 0;
      for (var doc in snapshot.docs) {
        final data = doc.data();
        if (data != null &&
            data is Map<String, dynamic> &&
            data.containsKey('rating')) {
          final rating = data['rating'];
          if (rating is num) {
            totalRating +=
                rating.toDouble(); // Assuming rating is a numeric value
          }
        }
      }

      final averageRating = totalRating / snapshot.docs.length;
      documentReference.update({
        'averageRating': averageRating
      }); // Update Firestore with the average rating
      return averageRating;
    });
  }
}
