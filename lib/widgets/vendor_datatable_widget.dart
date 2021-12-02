// ignore_for_file: unused_local_variable

import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:indian_zaika_admin/components/restaurant_details_box.dart';
import 'package:indian_zaika_admin/services/firebase_services.dart';

class RestaurantDataTable extends StatefulWidget {
  const RestaurantDataTable({Key? key}) : super(key: key);

  @override
  _RestaurantDataTableState createState() => _RestaurantDataTableState();
}

class _RestaurantDataTableState extends State<RestaurantDataTable> {
  FirebaseServices _services = FirebaseServices();

  bool? active = true;
  bool? isTopPicked = true;

  filter(val) {
    if (val == 1) {
      active = true;
    }
    if (val == 2) {
      active = false;
    }
    if (val == 1) {
      isTopPicked = true;
    }
    if (val == 0) {
      active = null;
      isTopPicked = null;
    }
  }

  int tag = 1;
  List<String> options = [
    'All Restaurants',
    'Active Restaurants',
    'Unactive Restaurants',
    'Top Picked',
    'Top Rated',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });
            filter(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
            activeStyle: (i, v) {
              return const C2ChoiceStyle(
                  brightness: Brightness.dark, color: Color(0xFF272d2f));
            },
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
          choiceStyle: const C2ChoiceStyle(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
        const Divider(thickness: 5),
        StreamBuilder(
          stream: _services.restaurants
              .where('isTopPicked', isEqualTo: isTopPicked)
              .where('restVerified', isEqualTo: active)
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
        ),
      ],
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
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return RestaurantDetailBox(
                        uid: (document.data() as dynamic)['email']);
                  });
            },
            icon: const Icon(Icons.info_outline))),
      ]);
    }).toList();
    return newList;
  }
}
