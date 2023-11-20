import 'package:flutter/material.dart';
import 'food.dart';

void main() {
  runApp(HousingPage());
}

class HousingPage extends StatefulWidget {
  @override
  _HousingPageState createState() => _HousingPageState();
}

class _HousingPageState extends State<HousingPage> {
  int _selectedIndex = 0; // Define _selectedIndex to keep track of the selected navigation item

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FoodPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KanTinir',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text('Homepage'),
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Smart Search',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(child: HouseList(title: 'Home Page')),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu),
              label: 'Food',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Housing',
            ),
          ],
          // does not work yet haha; will fix later
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}



class HouseList extends StatelessWidget {
  HouseList({Key? key, this.title}) : super(key: key);
  final String? title;

  // Lists were used to display the information on the boxes
  final List<int> lowestPrice = [1500, 300, 300, 2000, 398, 0];
  final List<int?> highestPrice = [3500, 300, 300, 12000, 7794, 100];
  final List<String> names = ['Arkids Dorm', 'Balay Gumamela - UPV Dorm', 'Balay Lampirong - UPV Dorm', 'KP Vision Boarding House', 
                              'Royal Angels\' Deluxe Dormtelle', 'Dummy Dummy'];
  final List<int> ratings = [4, 3, 3, 4, 4, 2];
  final List<String> images = ['Arkids.jpg', 'Gumamela.jpg', 'Lampirong.jfif', 'KPVision.jpg', 'RoyalAngels.jpg', ''];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lowestPrice.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Displays a message on the terminal when the box is clicked; can be disregarded
            print('${names[index]} clicked');
          },
          child: Container(
            height: 150,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 124, 152, 92),
                  Colors.transparent,
                ],
              ),
            ),
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.40,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text('₱${lowestPrice[index]} - ${highestPrice[index]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text('${names[index]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Row(
                    children: <Widget>[
                      Text('${ratings[index]}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Icon(Icons.star,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
