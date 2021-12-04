// ignore_for_file: avoid_web_libraries_in_flutter, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers, avoid_print

import 'dart:async';
import 'dart:html';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:indian_zaika_admin/constants/constants.dart';
import 'package:indian_zaika_admin/services/firebase_services.dart';

class BannerUploadWidget extends StatefulWidget {
  const BannerUploadWidget({Key? key}) : super(key: key);

  @override
  _BannerUploadWidgetState createState() => _BannerUploadWidgetState();
}

class _BannerUploadWidgetState extends State<BannerUploadWidget> {
  final FirebaseServices _services = FirebaseServices();
  final _fileNameTextController = TextEditingController();
  bool visible = false;
  bool _imageSelected = true;
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
      setState(() {
        _fileNameTextController.text = file.name;
        Timer(const Duration(seconds: 30), () {
          setState(() {
            _imageSelected = false;
          });
        });
        _path = path;
      });
      fb
          .storage()
          .refFromURL('gs://indianzaikaflutter-95dfa.appspot.com')
          .child(path)
          .put(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        backgroundColor: Colors.amber.withOpacity(.3),
        animationDuration: const Duration(milliseconds: 500));

    return Container(
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
                            width: MediaQuery.of(context).size.width / 3,
                            height: 30,
                            child: TextField(
                              controller: _fileNameTextController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amber),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Upload Image',
                                contentPadding: EdgeInsets.only(left: 20),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.black54,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      AbsorbPointer(
                        absorbing: _imageSelected,
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor: _imageSelected
                                ? MaterialStateProperty.all<Color>(
                                    Colors.black38)
                                : MaterialStateProperty.all<Color>(
                                    Colors.black54),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          onPressed: () {
                            progressDialog.show();
                            _services
                                .uploadBannerImageToDb(_path)
                                .then((downloadUrl) {
                              progressDialog.dismiss();
                              _services.showMyDialog(
                                title: 'New Banner Image',
                                message: 'Saved Banner Image Sucessfully',
                                context: context,
                              );
                            });
                            _fileNameTextController.clear();
                          },
                          child: const Text(
                            'Save Image',
                            style: kHintText,
                          ),
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
                    const Color(0xFF272d2f),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
        ));
  }
}
