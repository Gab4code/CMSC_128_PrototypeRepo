import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class gumamelaInfoPage extends StatefulWidget {
  const gumamelaInfoPage({super.key});

  @override
  State<gumamelaInfoPage> createState() => _gumamelaInfoPageState();
}

class _gumamelaInfoPageState extends State<gumamelaInfoPage> {
  Future<double?> _fetchRating() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('tinir').doc('5').get();
    if (snapshot.exists) {
      return snapshot.data()?['averageRating'] as double?;
    }
    return null;
  }

  static const LatLng location = LatLng(10.649349782428317, 122.22687774953113);

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
                  image: AssetImage('images/gumamela_logo.jpg'),
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
                'hi·bis·cus  ---  minsan plant of the mallow family known for its large, brightly colored flowers; madalas scientific name ng five-star dormitory ng buong upv',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      '0333 158 153 / 0333 159 631',
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
                  Icon(Icons.person),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Celina G. Sumalapao',
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
                      'UP Visayas, Miagao, 5023 Iloilo',
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
                  Icon(Icons.calendar_month),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Average Monthly Rent: ₱300',
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
                  Icon(Icons.inventory),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      'Payment Inclusion: Free Water, Free Wifi',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
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
