import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class House {
  final String name;
  final String category;
  final String image_path;

  House({required this.name, required this.category, required this.image_path});
}

class gumamelaItemPage extends StatefulWidget {
  const gumamelaItemPage({Key? key}) : super(key: key);

  @override
  State<gumamelaItemPage> createState() => _gumamelaItemPageState();
}

class _gumamelaItemPageState extends State<gumamelaItemPage> {
  late List<House> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<House> facilities = [];

    // Fetch data from tinir/1 collection
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('tinir')
        .doc('5')
        .collection('facilityitems')
        .get();
    // Extract food items from snapshot
    snapshot.docs.forEach((doc) {
      facilities.add(House(
          name: doc['name'],
          category: doc['category'],
          image_path: doc['image_path']));
    });

    setState(() {
      data = facilities;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Group food items by category
    Map<String, List<House>> foodItemsByCategory = {};
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
          List<House> items = foodItemsByCategory[category]!;
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
                            image: AssetImage(
                                'images/gumamela_items/${item.image_path}.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  height:
                                      120), // Placeholder to maintain the height
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(1, 1),
                                                blurRadius: 2,
                                              ),
                                            ]),
                                      ),
                                      SizedBox(
                                        height: 1,
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
              ]);
        },
      ),
    );
  }
}
