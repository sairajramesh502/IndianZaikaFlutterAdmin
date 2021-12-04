// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('Slider');
  CollectionReference category =
      FirebaseFirestore.instance.collection('Categories');
  CollectionReference restaurants =
      FirebaseFirestore.instance.collection('Restaurants');
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<QuerySnapshot> getAdminCredentials() async {
    var result = FirebaseFirestore.instance.collection('Admin').get();
    return result;
  }

  // Banner
  Future<String> uploadBannerImageToDb(path) async {
    Reference ref = FirebaseStorage.instance.ref().child(path);
    String url = (await ref.getDownloadURL()).toString();
    firestore.collection('Slider').add({
      'image': url,
    });
    return url;
  }

  deleteBannerImageFormDb(id) async {
    firestore.collection('Slider').doc(id).delete();
  }

  //Vendor
  updateRestaurantData({id, status}) async {
    restaurants.doc(id).update({
      'restVerified': status ? false : true,
    });
  }

  updateRestaurantTopPicked({id, status}) async {
    restaurants.doc(id).update({
      'isTopPicked': status ? false : true,
    });
  }

  //Category
  Future<String> uploadCategoryToDb(path, catName) async {
    Reference ref = FirebaseStorage.instance.ref().child(path);
    String url = (await ref.getDownloadURL()).toString();
    firestore.collection('Categories').doc(catName).set({
      'image': url,
      'name': catName,
    });
    return url;
  }

  Future<void> confirmDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteBannerImageFormDb(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialog({title, message, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
