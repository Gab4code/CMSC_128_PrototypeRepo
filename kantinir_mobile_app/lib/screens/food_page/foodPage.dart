import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String name;
  final String vendor;
  final String price;

  Food({required this.name, required this.vendor, required this.price});
}

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late List<Food> data;

  List<Food> searchResults = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Food> foods = [];

    // Fetch data from kaon/1 collection
    QuerySnapshot snapshot1 = await FirebaseFirestore.instance
        .collection('kaon')
        .doc('1')
        .collection('fooditem')
        .get();

    // Extract food items from kaon/1 snapshot
    snapshot1.docs.forEach((doc) {
      foods.add(Food(name: doc['name'], vendor: doc['vendor'], price: doc['price']));
    });

    // Fetch data from kaon/2 collection
    QuerySnapshot snapshot2 = await FirebaseFirestore.instance
        .collection('kaon')
        .doc('2')
        .collection('fooditem')
        .get();

    // Extract food items from kaon/2 snapshot
    snapshot2.docs.forEach((doc) {
      foods.add(Food(name: doc['name'], vendor: doc['vendor'], price: doc['price']));
    });

  // Fetch data from kaon/3 collection
    QuerySnapshot snapshot3 = await FirebaseFirestore.instance
        .collection('kaon')
        .doc('3')
        .collection('fooditem')
        .get();

    // Extract food items from kaon/3 snapshot
    snapshot3.docs.forEach((doc) {
      foods.add(Food(name: doc['name'], vendor: doc['vendor'], price: doc['price']));
    });



   // Fetch data from kaon/4 collection
    QuerySnapshot snapshot4 = await FirebaseFirestore.instance
        .collection('kaon')
        .doc('4')
        .collection('fooditem')
        .get();

    // Extract food items from kaon/4 snapshot
    snapshot4.docs.forEach((doc) {
      foods.add(Food(name: doc['name'], vendor: doc['vendor'], price: doc['price']));
    });

    setState(() {
      data = foods;
    });
  }

  void onQueryChanged(String query) {
    setState(() {
      searchResults = data
          .where((food) =>
              food.name.toLowerCase().contains(query.toLowerCase()) ||
              food.vendor.toLowerCase().contains(query.toLowerCase()))
          .toList();
      //Sort the searchResults based on price
      searchResults.sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(onQueryChanged: onQueryChanged),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, searchResults[index].vendor);
                  },
                  child: ListTile(
                    title: Text(searchResults[index].name),
                    subtitle: Text(searchResults[index].vendor),
                    trailing: Text("₱"+searchResults[index].price),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onQueryChanged;

  const SearchBar({Key? key, required this.onQueryChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: widget.onQueryChanged,
        decoration: InputDecoration(
          labelText: 'Search for food here',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
