import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:indian_zaika_admin/components/sidebar.dart';
import 'package:indian_zaika_admin/constants/constants.dart';

class AdminUserScreen extends StatefulWidget {
  static const String id = 'adminuser-screen';
  const AdminUserScreen({Key? key}) : super(key: key);

  @override
  _AdminUserScreenState createState() => _AdminUserScreenState();
}

class _AdminUserScreenState extends State<AdminUserScreen> {
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
      sideBar: _sideBar.sideBarMenues(context, AdminUserScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Admin Users',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
