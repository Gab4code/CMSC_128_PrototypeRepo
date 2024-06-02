import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class coffee48InfoPage extends StatefulWidget {
  const coffee48InfoPage({super.key});

  @override
  State<coffee48InfoPage> createState() => _kuboRestoInfoPageState();
}

class _kuboRestoInfoPageState extends State<coffee48InfoPage> {
  Future<double?> _fetchRating() async {
    final snapshot = await FirebaseFirestore.instance.collection('kaon').doc('4').get();
    if (snapshot.exists) {
      return snapshot.data()?['averageRating'] as double?;
    }
    return null;
  }
  
  static const LatLng location =
      LatLng(10.644219962559625, 122.23453346858548);

  late GoogleMapController _controller;

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/48coffee_logo.jpg'),
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
                'Street coffee that serves you right <3',
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
                          '0947 922 9562',
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
                        'Quezon St., Brgy. Tacas, Miagao, Philippines',
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
                        'From Monday to Sunday',
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
                        'From 9:30AM to 7PM',
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
      ),
    );
  }
}
