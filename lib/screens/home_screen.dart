import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:indian_zaika_admin/components/sidebar.dart';
import 'package:indian_zaika_admin/constants/constants.dart';
import 'package:indian_zaika_admin/screens/admin_user.dart';
import 'package:indian_zaika_admin/screens/banners_screen.dart';
import 'package:indian_zaika_admin/screens/categories_screen.dart';
import 'package:indian_zaika_admin/screens/login_screen.dart';
import 'package:indian_zaika_admin/screens/notification_screen.dart';
import 'package:indian_zaika_admin/screens/order_screen.dart';
import 'package:indian_zaika_admin/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      sideBar: _sideBar.sideBarMenues(context, HomeScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: const Text(
            'Dashboard',
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
