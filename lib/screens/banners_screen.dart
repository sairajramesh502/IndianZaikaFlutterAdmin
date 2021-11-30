// ignore_for_file: unused_element, dead_code

import 'dart:html';

import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:indian_zaika_admin/components/sidebar.dart';
import 'package:indian_zaika_admin/constants/constants.dart';
import 'package:indian_zaika_admin/widgets/banners.dart';

class BannerScreen extends StatefulWidget {
  static const String id = 'banner-screen';
  const BannerScreen({Key? key}) : super(key: key);

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _fileNameTextController = TextEditingController();
  bool visible = false;
  bool _imageSelected = false;
  String? _path;

  void uploadImage({required Function(File file) onselected}) {
    FileUploadInputElement uploadInput = FileUploadInputElement()
      ..accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      final file = uploadInput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onselected(file);
      });
    });
  }

  void uploadStrorage() {
    final dateTime = DateTime.now();
    final path = 'bannerImage / $dateTime';
    uploadImage(onselected: (file) {
      if (file != null) {
        setState(() {
          _fileNameTextController.text = file.name;
          _imageSelected = false;
          _path = path;
        });
        fb
            .storage()
            .refFromURL('gs://indianzaikaflutter-95dfa.appspot.com')
            .child(path)
            .put(file);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SidebarWidget _sideBar = SidebarWidget();
    return AdminScaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF272d2f),
        title: const Text(
          'Indian Zaika Admin Dashboard',
          style: kTextStyleHead1,
        ),
      ),
      sideBar: _sideBar.sideBarMenues(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Banner Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              const Text(
                'Add/Delete Home Screen Offers Banner Images',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const Divider(
                thickness: 5,
              ),
              const BannerWidget(),
              const Divider(
                thickness: 5,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      children: [
                        Visibility(
                          visible: visible,
                          child: Container(
                            child: Row(
                              children: [
                                AbsorbPointer(
                                  absorbing: true,
                                  child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height: 30,
                                      child: TextField(
                                        controller: _fileNameTextController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.amber),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: 'Upload Image',
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                        ),
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.black54,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    uploadStrorage();
                                  },
                                  child: const Text(
                                    'Upload Image',
                                    style: kHintText,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.black54,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Save Image',
                                    style: kHintText,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF272d2f),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              visible = !visible;
                            });
                            print(visible);
                          },
                          child: visible
                              ? const Text(
                                  'Close',
                                  style: kHintText,
                                )
                              : const Text(
                                  'Add New Banner',
                                  style: kHintText,
                                ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
