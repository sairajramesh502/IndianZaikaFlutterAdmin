import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:indian_zaika_admin/components/sidebar.dart';
import 'package:indian_zaika_admin/constants/constants.dart';
import 'package:indian_zaika_admin/widgets/category/category_list_widget.dart';
import 'package:indian_zaika_admin/widgets/category/category_upload.dart';

class CategoriesScreen extends StatefulWidget {
  static const String id = 'category-screen';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    SidebarWidget _sideBar = SidebarWidget();
    return AdminScaffold(
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
      sideBar: _sideBar.sideBarMenues(context, CategoriesScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Category Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text(
                'Add new Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Divider(thickness: 5),
              CategoryList(),
              Divider(thickness: 5),
              CategoryUploadWidget(),
              Divider(thickness: 5),
            ],
          ),
        ),
      ),
    );
  }
}
