import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:indian_zaika_admin/screens/admin_user.dart';
import 'package:indian_zaika_admin/screens/banners_screen.dart';
import 'package:indian_zaika_admin/screens/categories_screen.dart';
import 'package:indian_zaika_admin/screens/home_screen.dart';
import 'package:indian_zaika_admin/screens/login_screen.dart';
import 'package:indian_zaika_admin/screens/notification_screen.dart';
import 'package:indian_zaika_admin/screens/order_screen.dart';
import 'package:indian_zaika_admin/screens/settings_screen.dart';
import 'package:indian_zaika_admin/screens/vender_manage.dart';

class SidebarWidget {
  sideBarMenues(context, selectedRoute) {
    return SideBar(
      activeBackgroundColor: Colors.black54,
      activeIconColor: Colors.white,
      activeTextStyle: const TextStyle(color: Colors.white),
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: HomeScreen.id,
          icon: Icons.dashboard_outlined,
        ),
        MenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: Icons.photo_size_select_actual_outlined,
        ),
        MenuItem(
          title: 'Manage Restaurants',
          route: ManageVendors.id,
          icon: Icons.photo_size_select_actual_outlined,
        ),
        MenuItem(
          title: 'Categories',
          route: CategoriesScreen.id,
          icon: Icons.category_outlined,
        ),
        MenuItem(
          title: 'Orders',
          route: OrderScreen.id,
          icon: Icons.shopping_cart_outlined,
        ),
        MenuItem(
          title: 'Send Notifications',
          route: NotificationScreen.id,
          icon: Icons.notifications_outlined,
        ),
        MenuItem(
          title: 'Admin Users',
          route: AdminUserScreen.id,
          icon: Icons.face_outlined,
        ),
        MenuItem(
          title: 'Settings',
          route: SettingsScreen.id,
          icon: Icons.admin_panel_settings_outlined,
        ),
        MenuItem(
          title: 'Exit',
          route: MyHomePage.id,
          icon: Icons.logout_outlined,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xff444444),
        child: const Center(
          child: Text(
            'MENU',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      footer: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xff444444),
        child: Center(
          child: Image.asset('images/LogoProfile.png'),
        ),
      ),
    );
  }
}
