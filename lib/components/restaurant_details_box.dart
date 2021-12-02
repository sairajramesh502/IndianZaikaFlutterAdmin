import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika_admin/services/firebase_services.dart';

class RestaurantDetailBox extends StatefulWidget {
  const RestaurantDetailBox({Key? key, required this.uid}) : super(key: key);
  final String uid;

  @override
  State<RestaurantDetailBox> createState() => _RestaurantDetailBoxState();
}

class _RestaurantDetailBoxState extends State<RestaurantDetailBox> {
  FirebaseServices _services = FirebaseServices();
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
            child: Container(
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
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .3,
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child:
                            Image.network(data['imageUrl'], fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['restaurantName'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Text(data['dialog']),
                        ],
                      )
                    ],
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
