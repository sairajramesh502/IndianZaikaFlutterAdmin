// ignore_for_file: unused_element, dead_code, avoid_web_libr
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:indian_zaika_admin/components/sidebar.dart';
import 'package:indian_zaika_admin/constants/constants.dart';
import 'package:indian_zaika_admin/widgets/banner/banner_upload.dart';
import 'package:indian_zaika_admin/widgets/banner/banners.dart';

class BannerScreen extends StatefulWidget {
  static const String id = 'banner-screen';
  const BannerScreen({Key? key}) : super(key: key);

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final SidebarWidget _sideBar = SidebarWidget();

  @override
  Widget build(BuildContext context) {
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
            children: const [
              Text(
                'Banner Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text(
                'Add/Delete Home Screen Offers Banner Images',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Divider(thickness: 5),
              BannerWidget(),
              Divider(thickness: 5),
              BannerUploadWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
