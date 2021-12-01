// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika_admin/services/firebase_services.dart';

class RestaurantDataTable extends StatefulWidget {
  const RestaurantDataTable({Key? key}) : super(key: key);

  @override
  _RestaurantDataTableState createState() => _RestaurantDataTableState();
}

class _RestaurantDataTableState extends State<RestaurantDataTable> {
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _services.restaurants
          .orderBy('restaurantName', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something Went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          child: DataTable(
            showBottomBorder: true,
            dataRowHeight: 60,
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
            columns: const <DataColumn>[
              DataColumn(label: Text('Active / Inactive')),
              DataColumn(label: Text('Top Picked')),
              DataColumn(label: Text('Restaurant Name')),
              DataColumn(label: Text('Rating')),
              DataColumn(label: Text('Total Rating')),
              DataColumn(label: Text('Mobile')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('View Details')),
            ],
            rows: _restaurantDetailsRow(
                snapshot.data as QuerySnapshot, _services),
          ),
        );
      },
    );
  }

  List<DataRow> _restaurantDetailsRow(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(IconButton(
          onPressed: () {
            services.updateRestaurantData(
              id: (document.data() as dynamic)['email'],
              status: (document.data() as dynamic)['restVerified'],
            );
          },
          icon: (document.data() as dynamic)['restVerified']
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
        )),
        DataCell(IconButton(
          onPressed: () {
            services.updateRestaurantTopPicked(
              id: (document.data() as dynamic)['email'],
              status: (document.data() as dynamic)['isTopPicked'],
            );
          },
          icon: (document.data() as dynamic)['isTopPicked']
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
        )),
        DataCell(Text((document.data() as dynamic)['restaurantName'])),
        DataCell(Row(
          children: const [
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
            Text('3.5'),
          ],
        )),
        const DataCell(Text('20,000')),
        DataCell(Text((document.data() as dynamic)['mobile'])),
        DataCell(Text((document.data() as dynamic)['email'])),
        DataCell(IconButton(
            onPressed: () {}, icon: const Icon(Icons.remove_red_eye_outlined))),
      ]);
    }).toList();
    return newList;
  }
}
