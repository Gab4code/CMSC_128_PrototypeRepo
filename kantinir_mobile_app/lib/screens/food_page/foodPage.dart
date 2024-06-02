import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  final String name;
  final String vendor;
  final String price;
  final String category;

  Food(
      {required this.name,
      required this.vendor,
      required this.price,
      required this.category});
}

class FoodPage extends StatefulWidget {
  const FoodPage({Key? key}) : super(key: key);

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  late List<Food> data;
  List<Food> searchResults = [];
  List<String> categories = [];
  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Food> foods = [];

    // Fetch data from kaon collections
    for (int i = 1; i <= 4; i++) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('kaon')
          .doc(i.toString())
          .collection('fooditem')
          .get();

      // Extract food items from snapshot
      for (var doc in snapshot.docs) {
        foods.add(Food(
            name: doc['name'],
            vendor: doc['vendor'],
            price: doc['price'],
            category: doc['category']));
      }
    }

    // Fetch data from kaon/5 collection
    QuerySnapshot snapshot5 = await FirebaseFirestore.instance
        .collection('kaon')
        .doc('5')
        .collection('fooditem')
        .get();

    // Extract food items from kaon/5 snapshot
    for (var doc in snapshot5.docs) {
      foods.add(
          Food(name: doc['name'], vendor: doc['vendor'], price: doc['price'], category: doc['category']));
    }

    // Sort the foods list by price in ascending order
    foods
        .sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));

    // Extract unique categories
    categories = foods.map((food) => food.category).toSet().toList();

    setState(() {
      data = foods;
      // Assign searchResults to data initially to display all foods sorted by price
      searchResults = List.from(data);
    });
  }

  void onQueryChanged(String query) {
    setState(() {
      searchResults = data
          .where((food) =>
              (selectedCategories.isEmpty ||
                  selectedCategories.contains(food.category)) &&
              (food.name.toLowerCase().contains(query.toLowerCase()) ||
                  food.vendor.toLowerCase().contains(query.toLowerCase())))
          .toList();
      //Sort the searchResults based on price
      searchResults.sort(
          (a, b) => double.parse(a.price).compareTo(double.parse(b.price)));
    });
  }

  void onCategorySelected(bool selected, String category) {
    setState(() {
      if (selected) {
        selectedCategories.add(category);
      } else {
        selectedCategories.remove(category);
      }
      onQueryChanged(''); // Re-filter based on the new category selection
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(onQueryChanged: onQueryChanged),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8.0,
                children: categories
                    .map((category) => FilterChip(
                          label: Text(category),
                          selected: selectedCategories.contains(category),
                          onSelected: (selected) {
                            onCategorySelected(selected, category);
                          },
                        ))
                    .toList(),
              )),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, searchResults[index].vendor);
                  },
                  child: Container(
                    color: index % 2 == 0
                        ? Color.fromARGB(255, 237, 237, 237)
                        : Colors.white, // Alternate colors
                    child: ListTile(
                      title: Text(searchResults[index].name),
                      subtitle: Text(
                          '${searchResults[index].vendor} - ${searchResults[index].category}'),
                      trailing: Text("₱${searchResults[index].price}"),
                    ),
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
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: widget.onQueryChanged,
        decoration: const InputDecoration(
          labelText: 'Search for food here',
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
