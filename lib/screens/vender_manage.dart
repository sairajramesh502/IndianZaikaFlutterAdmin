import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:indian_zaika_admin/components/sidebar.dart';
import 'package:indian_zaika_admin/constants/constants.dart';
import 'package:indian_zaika_admin/screens/banners_screen.dart';
import 'package:indian_zaika_admin/widgets/vendor_datatable_widget.dart';
import 'package:indian_zaika_admin/widgets/vendor_filter_widget.dart';

class ManageVendors extends StatefulWidget {
  static const String id = 'vendor-screen';
  const ManageVendors({Key? key}) : super(key: key);

  @override
  _ManageVendorsState createState() => _ManageVendorsState();
}

class _ManageVendorsState extends State<ManageVendors> {
  SidebarWidget _sideBar = SidebarWidget();
  @override
  Widget build(BuildContext context) {
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
      sideBar: _sideBar.sideBarMenues(context, ManageVendors.id),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Manage Restaurants',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text(
                'Manage All restaurants Activities',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Divider(thickness: 5),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: RestaurantDataTable()),
              Divider(thickness: 5),
            ],
          ),
        ),
      ),
    );
  }
}
