// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<QuerySnapshot> getAdminCredentials() async {
    var result = FirebaseFirestore.instance.collection('Admin').get();
    return result;
  }
}
