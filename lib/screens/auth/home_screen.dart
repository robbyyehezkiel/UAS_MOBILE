import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:laundry_pelanggan/screens/auth/dashboard.dart';
import 'package:laundry_pelanggan/screens/auth/kategori.dart';
import 'package:laundry_pelanggan/screens/auth/notification.dart';
import 'package:laundry_pelanggan/screens/auth/profile.dart';
import 'package:laundry_pelanggan/screens/auth/logout.dart';

class HomePelanggan extends StatefulWidget {
  static const routeName = '/HomePage';
  const HomePelanggan({super.key});

  @override
  State<HomePelanggan> createState() => _HomePelangganState();
}

class _HomePelangganState extends State<HomePelanggan> {
  List<Widget> widgets = [
    const DashboardPage(),
    const ProfileLaundry(),
    const NotificationPage(),
    const KategoriLaundry(),
    const LogoutButton(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgets[currentIndex],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.local_laundry_service, title: 'Tentang'),
          TabItem(icon: Icons.message, title: 'Pesan'),
          TabItem(icon: Icons.cleaning_services, title: 'Pelayanan'),
          TabItem(icon: Icons.logout, title: 'Logout'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) => setState(() {
          currentIndex = i;
        }),
      ),
    );
  }
}
