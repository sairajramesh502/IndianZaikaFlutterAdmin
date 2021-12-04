// ignore_for_file: avoid_web_libraries_in_flutter, unused_field, avoid_unnecessary_containers

// ignore_for_file: unused_import

import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika_admin/services/firebase_services.dart';

class RestaurantDetailBox extends StatefulWidget {
  const RestaurantDetailBox({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<RestaurantDetailBox> createState() => _RestaurantDetailBoxState();
}

class _RestaurantDetailBoxState extends State<RestaurantDetailBox> {
  final FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Restaurants');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Dialog(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .3,
              child: const SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Document Does Not Exist',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold)),
                  ))),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * .3,
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Image.network(data['imageUrl'],
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['restaurantName'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(data['dialog']),
                              ],
                            )
                          ],
                        ),
                        const Divider(thickness: 4),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'Contact Number',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          child: Text(data['mobile']))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'Email',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          child: Text(data['email']))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'Address',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                          child: Text(data['adderss']))),
                                ],
                              ),
                            ),
                            const Divider(thickness: 4),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text(
                                        'Top Picked Status',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Text(':'),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: data['isTopPicked']
                                          ? Chip(
                                              backgroundColor: Colors.green,
                                              label: Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    child: Icon(Icons.check,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    'Top Picked',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Chip(
                                              backgroundColor: Colors.red,
                                              label: Row(
                                                children: const [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Not Top Picked',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Wrap(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: const [
                                          Icon(
                                            CupertinoIcons.money_dollar_circle,
                                            size: 30,
                                            color: Colors.black54,
                                          ),
                                          Text('Total Revenue'),
                                          Text('12,000'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: const [
                                          Icon(
                                            CupertinoIcons.cart_fill,
                                            size: 30,
                                            color: Colors.black54,
                                          ),
                                          Text('Active Orders'),
                                          Text('6'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: const [
                                          Icon(
                                            Icons.shopping_bag,
                                            size: 30,
                                            color: Colors.black54,
                                          ),
                                          Text('Orders'),
                                          Text('130'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: const [
                                          Icon(
                                            Icons.grain_outlined,
                                            size: 30,
                                            color: Colors.black54,
                                          ),
                                          Text('Items in Menu'),
                                          Text('160'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .1,
                      child: data['restVerified']
                          ? Chip(
                              backgroundColor: Colors.green,
                              label: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Active',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            )
                          : Chip(
                              backgroundColor: Colors.red,
                              label: Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Inactive',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
