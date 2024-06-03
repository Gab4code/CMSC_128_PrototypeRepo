import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HousingPage extends StatefulWidget {
  const HousingPage({super.key});

  @override
  State<HousingPage> createState() => _housingPageState();
}

class _housingPageState extends State<HousingPage> {
  final CollectionReference _tinir =
      FirebaseFirestore.instance.collection("tinir");
  String search_name_input = "";
  List<String> array_tag_housing = [];

  bool is_private_cr = false;
  bool is_allows_cooking = false;
  bool is_no_curfew = false;
  bool is_aircondition = false;
  bool is_has_refrigirator = false;

  bool fliterIsSwitched = false;

  double _slider_minimum_budget = 15000;
  final TextEditingController _budgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _budgetController.text = '$_slider_minimum_budget';
    _budgetController.addListener(_onBudgetChanged);
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  void _onBudgetChanged() {
    double newBudget =
        double.tryParse(_budgetController.text) ?? _slider_minimum_budget;
    if (newBudget > 15000) {
      _budgetController.text = '15000';
      newBudget = 15000;
    }
    setState(() {
      _slider_minimum_budget = newBudget.clamp(0, 15000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 25),
                  Row(
                    children: [
                      SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _slider_minimum_budget =
                                (_slider_minimum_budget - 100).clamp(0, 15000);
                            _budgetController.text = '$_slider_minimum_budget';
                          });
                        },
                        child: Text('-100'),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              'Enter Budget: ',
                              style: TextStyle(
                                fontFamily: 'Arial',
                                fontSize: 14.0,
                              ),
                            ),
                            Container(
                              width: 60, // Adjust width as needed
                              child: TextField(
                                controller: _budgetController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '$_slider_minimum_budget',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _slider_minimum_budget =
                                (_slider_minimum_budget + 100).clamp(0, 15000);
                            _budgetController.text = '$_slider_minimum_budget';
                          });
                        },
                        child: Text('+100'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  FlutterSlider(
                    values: [_slider_minimum_budget],
                    max: 15000,
                    min: 0,
                    onDragging: (handlerIndex, lowerValue, upperValue) {
                      setState(() {
                        _slider_minimum_budget = lowerValue;
                        _budgetController.text = '$_slider_minimum_budget';
                      });
                    },
                  ),
                ],
              ),
              //Slider
              // Column(
              //   children: [
              //     SizedBox(height: 10),
              //     Text(
              //         'Select Minimum Budget Value for a bed space: Php $_slider_minimum_budget'),
              //     SizedBox(height: 10),
              //     Slider(
              //       value: _slider_minimum_budget,
              //       max: 15000,
              //       divisions: 30,
              //       label: _slider_minimum_budget.round().toString(),
              //       onChanged: (double value) {
              //         setState(() {
              //           _slider_minimum_budget = value;
              //         });
              //       },
              //     ),
              //   ],
              // ),
              // Tag filters
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: <Widget>[
                        // if (fliterIsSwitched)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            children: [
                              Row(
                                children: [
                                  ChoiceChip(
                                    label: Text(
                                      'Private CR',
                                    ),
                                    selected: is_private_cr,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        is_private_cr = selected;
                                        if (selected) {
                                          array_tag_housing.add('private_cr');
                                        } else {
                                          array_tag_housing
                                              .remove('private_cr');
                                        }
                                      });
                                    },
                                    // selectedColor: Colors.blue[800],
                                    // backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  ChoiceChip(
                                    label: Text(
                                      'Allows Cooking',
                                      // style: TextStyle(
                                      //   color: is_allows_cooking
                                      //       ? Colors.white
                                      //       : Colors.black,
                                      // ),
                                    ),
                                    selected: is_allows_cooking,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        is_allows_cooking = selected;
                                        if (selected) {
                                          array_tag_housing
                                              .add('allows_cooking');
                                        } else {
                                          array_tag_housing
                                              .remove('allows_cooking');
                                        }
                                      });
                                    },
                                    // selectedColor: Colors.blue[800],
                                    // backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  ChoiceChip(
                                    label: Text(
                                      'No Curfew',
                                      // style: TextStyle(
                                      //   color: is_no_curfew
                                      //       ? Colors.white
                                      //       : Colors.black,
                                      // ),
                                    ),
                                    selected: is_no_curfew,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        is_no_curfew = selected;
                                        if (selected) {
                                          array_tag_housing.add('no_curfew');
                                        } else {
                                          array_tag_housing.remove('no_curfew');
                                        }
                                      });
                                    },
                                    // selectedColor: Colors.blue[800],
                                    // backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  ChoiceChip(
                                    label: Text(
                                      'Air Condition',
                                      // style: TextStyle(
                                      //   color: is_aircondition
                                      //       ? Colors.white
                                      //       : Colors.black,
                                      // ),
                                    ),
                                    selected: is_aircondition,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        is_aircondition = selected;
                                        if (selected) {
                                          array_tag_housing.add('aircondition');
                                        } else {
                                          array_tag_housing
                                              .remove('aircondition');
                                        }
                                      });
                                    },
                                    // selectedColor: Colors.blue[800],
                                    // backgroundColor: Colors.grey,
                                  ),
                                  SizedBox(width: 5),
                                  ChoiceChip(
                                    label: Text(
                                      'Has Refrigerator',
                                      // style: TextStyle(
                                      //   color: is_has_refrigirator
                                      //       ? Colors.white
                                      //       : Colors.black,
                                      // ),
                                    ),
                                    selected: is_has_refrigirator,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        is_has_refrigirator = selected;
                                        if (selected) {
                                          array_tag_housing
                                              .add('has_refrigerator');
                                        } else {
                                          array_tag_housing
                                              .remove('has_refrigerator');
                                        }
                                      });
                                    },
                                    // selectedColor: Colors.blue[800],
                                    // backgroundColor: Colors.grey,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                        // else
                        //   Text("")
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 512,
                child: StreamBuilder<QuerySnapshot>(
                  stream: createQuery(_tinir).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    }
                    if (snapshots.hasData) {
                      return ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot records =
                              snapshots.data!.docs[index];
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
                                            "₱" +
                                                records["min_spend"]
                                                    .toString() +
                                                "\n\n\n" +
                                                records["name"],
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          trailing: Text(
                                            'Average Rating: ${averageRating.toStringAsFixed(1)}',
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 12.0,
                                            ),
                                          ),
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
                    return Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Query createQuery(Query queryReference) {
    Query query = queryReference;
    if (array_tag_housing.isEmpty) {
      query =
          query.where('min_spend', isLessThanOrEqualTo: _slider_minimum_budget);
    } else {
      print(array_tag_housing);
      query = query.where('housing_tags', arrayContainsAny: array_tag_housing);
      query =
          query.where('min_spend', isLessThanOrEqualTo: _slider_minimum_budget);
    }
    return query;
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
