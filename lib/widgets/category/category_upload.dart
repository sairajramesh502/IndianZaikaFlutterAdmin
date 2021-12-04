// ignore_for_file: avoid_web_libraries_in_flutter, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers, avoid_print

import 'dart:async';
import 'dart:html';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/material.dart';
import 'package:indian_zaika_admin/constants/constants.dart';
import 'package:indian_zaika_admin/services/firebase_services.dart';

class CategoryUploadWidget extends StatefulWidget {
  const CategoryUploadWidget({Key? key}) : super(key: key);

  @override
  _CategoryUploadWidgetState createState() => _CategoryUploadWidgetState();
}

class _CategoryUploadWidgetState extends State<CategoryUploadWidget> {
  final FirebaseServices _services = FirebaseServices();
  final _fileNameTextController = TextEditingController();
  final _categoryTextController = TextEditingController();
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
    final path = 'categoryImage / $dateTime';
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          height: 30,
                          child: TextField(
                            controller: _categoryTextController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Category Name',
                              contentPadding: EdgeInsets.only(left: 20),
                            ),
                          )),
                      AbsorbPointer(
                        absorbing: true,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
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
                          onPressed: () async {
                            if (_categoryTextController.text.isEmpty) {
                              _services.showMyDialog(
                                  context: context,
                                  title: 'New Category',
                                  message: 'Kindly Enter the Category Name');
                            }
                            progressDialog.show();
                            _services
                                .uploadCategoryToDb(
                                    _path, _categoryTextController.text)
                                .then((downloadUrl) {
                              progressDialog.dismiss();
                              _services.showMyDialog(
                                title: 'NewCategory',
                                message: 'Saved New Category Sucessfully',
                                context: context,
                              );
                              setState(() {
                                _imageSelected = true;
                              });
                            });
                            _fileNameTextController.clear();
                            _categoryTextController.clear();
                          },
                          child: const Text(
                            'Save Category',
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
                        'Add New Category',
                        style: kHintText,
                      ),
              ),
            ],
          ),
        ));
  }
}
