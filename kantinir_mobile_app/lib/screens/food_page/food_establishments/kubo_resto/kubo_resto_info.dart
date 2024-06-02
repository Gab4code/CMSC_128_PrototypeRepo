import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class kuboRestoInfoPage extends StatefulWidget {
  const kuboRestoInfoPage({super.key});

  @override
  State<kuboRestoInfoPage> createState() => _kuboRestoInfoPageState();
}

class _kuboRestoInfoPageState extends State<kuboRestoInfoPage> {
  Future<double?> _fetchRating() async {
    final snapshot = await FirebaseFirestore.instance.collection('kaon').doc('2').get();
    if (snapshot.exists) {
      return snapshot.data()?['averageRating'] as double?;
    }
    return null;
  }

   static const LatLng location =
      LatLng(10.653040111908794, 122.22824011091275);

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
                  image: AssetImage('images/Kubo Resto.jpg'),
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
                'A humble Restaurant in the heart of Mat-y, Miagao. Open for Dine-in, Take-out and Deliveries!',
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
                        '0908 600 1710',
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
                        'Balay Cawayan, Hollywood Street, Mat-y, Miagao ',
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
                        'From 7AM til 8PM',
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
