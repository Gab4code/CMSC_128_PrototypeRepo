import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Food {
  final String name;
  final String vendor;
  final String price;
  final String category;
  final String image_path;

  Food({required this.name, required this.vendor, required this.price, required this.category, required this.image_path});
}

class elGarajeMenuPage extends StatefulWidget {
  const elGarajeMenuPage({Key? key}) : super(key: key);

  @override
  State<elGarajeMenuPage> createState() => _elGarajeMenuPageState();
}

class _elGarajeMenuPageState extends State<elGarajeMenuPage> {
  late List<Food> data = [];

   @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Food> foods = [];

  // Fetch data from kaon/2 collection
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('kaon')
        .doc('1')
        .collection('fooditem')
        .get();
  // Extract food items from snapshot
   snapshot.docs.forEach((doc) {
     foods.add(Food(name: doc['name'], vendor: doc['vendor'], price: doc['price'], category: doc['category'], image_path: doc['image_path']));
  });

  setState(() {
      data = foods;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Group food items by category
    Map<String, List<Food>> foodItemsByCategory = {};
    data.forEach((food) {
      String category = food.category;
      if (!foodItemsByCategory.containsKey(category)) {
        foodItemsByCategory[category] = [];
      }
      foodItemsByCategory[category]!.add(food);
    });

    return Scaffold(
      body: ListView.builder(
        itemCount: foodItemsByCategory.length,
        itemBuilder: (context, index) {
          String category = foodItemsByCategory.keys.elementAt(index);
          List<Food> items = foodItemsByCategory[category]!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  category,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1,
                physics: NeverScrollableScrollPhysics(),
                children: items.map((item) {
                  return Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(
      color: Colors.grey,
      width: 1,
    ),
  ),
  child: Container(
    padding: EdgeInsets.only(top: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(
        image: AssetImage('images/el_garaje_items/${item.image_path}.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity, height: 120), // Placeholder to maintain the height
          SizedBox(width: 5,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 1,),
                  Text(
                    'Price: ₱${item.price}',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  //Room for more
                ],
              ),
            ),
          )
        ],
      ),
    ),
  ),
);
                }).toList(),
              )
              ]
          );
        },
      ),
    );
  }
}
