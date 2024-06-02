import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class elGarajeInfoPage extends StatefulWidget {
  const elGarajeInfoPage({super.key});

  @override
  State<elGarajeInfoPage> createState() => _elGarajeInfoPageState();
}

class _elGarajeInfoPageState extends State<elGarajeInfoPage> {
  Future<double?> _fetchRating() async {
    final snapshot = await FirebaseFirestore.instance.collection('kaon').doc('1').get();
    if (snapshot.exists) {
      return snapshot.data()?['averageRating'] as double?;
    }
    return null;
  }

  static const LatLng location =
      LatLng(10.642538230966712, 122.23808618022197);

  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/El Garaje.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          FutureBuilder<double?>(
            future: _fetchRating(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data != null) {
                 String formattedRating = snapshot.data!.toStringAsFixed(2);

                return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                 child: Container(
                  padding: EdgeInsets.all(8), 
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), 
                   border: Border.all(color: Colors.black), 
                 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Text(
                      
                        'Average Rating: $formattedRating',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.star, color: Colors.amber), 
                   ],
                  ),
                ),
              );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          
          SizedBox(height: 20), // Add spacing between image and paragraph
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Quality and affordable food and drinks in Miagao.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        '0995 819 1149',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.push_pin),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Ubos Ilawod, Miagao, Iloilo',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.sunny),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'From Monday to Saturday',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.schedule),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'From 10AM to 8PM',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.two_wheeler),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'For Dine-in, Take-out and Delivery',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.payment),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Accepts payments thru Gcash and COD',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
              Center(
              child: Container(
                  width: 340,
                  height: 200,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition:
                        CameraPosition(target: location, zoom: 15),
                    markers: {
                      Marker(
                          markerId: MarkerId("_targetLocation"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: location),
                    },
                  )),
            ),
        ],
      ),
    );
  }
}
