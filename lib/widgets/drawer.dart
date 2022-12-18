// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:laundry_admin/screens/auth/kategori.dart';
import 'package:laundry_admin/screens/auth/pemesanan.dart';
import 'package:laundry_admin/screens/non_auth/login_screen.dart';
import 'package:laundry_admin/screens/auth/pelanggan.dart';
import 'package:laundry_admin/screens/home_screen.dart';
import 'package:laundry_admin/services/global_methods.dart';
import 'package:laundry_admin/widgets/text_widget.dart';

class DrawerPage extends StatefulWidget {
  static const routeName = '/drawer';
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final TextEditingController _phoneTextController = TextEditingController();

  @override
  void dispose() {
    _phoneTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? phone;

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {});
    if (user == null) {
      setState(() {});
      return;
    }
    try {
      String uid = user!.uid;

      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users_admin')
          .doc(uid)
          .get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        phone = userDoc.get('phone_number');
      }
    } catch (error) {
      setState(() {});
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {});
    }
  }

  Future<void> _showPhoneDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update'),
          content: TextField(
            controller: _phoneTextController,
            decoration: const InputDecoration(labelText: 'Nomor Telepon'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String uid = user!.uid;
                try {
                  await FirebaseFirestore.instance
                      .collection('users_admin')
                      .doc(uid)
                      .update({'phone_number': _phoneTextController.text});
                  Navigator.pop(context);
                  setState(() {
                    phone = _phoneTextController.text;
                  });
                } catch (error) {
                  GlobalMethods.errorDialog(
                      subtitle: error.toString(), context: context);
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[100],
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/profile_logo.png',
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _name ?? 'user',
                        style: const TextStyle(fontSize: 35),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _email ?? 'email',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text(
              'Dashboard',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FetchScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: const Text(
              'Buat Pesanan',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_laundry_service_outlined),
            title: const Text(
              'Data Kategori Laundry',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const DataKategori()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text(
              'Data Pelanggan',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const DataPelanggan()),
              );
            },
          ),
          _listTiles(
            title: 'Edit Phone',
            icon: Icons.phone_android_outlined,
            onPressed: () async {
              await _showPhoneDialog();
            },
            color: Colors.black,
          ),
          _listTiles(
            title: user == null ? 'Login' : 'Logout',
            icon: user == null ? IconlyLight.login : IconlyLight.logout,
            onPressed: () {
              if (user == null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
                return;
              }
              GlobalMethods.warningDialog(
                  title: 'Sign Out',
                  subtitle: 'Do you want to sign out ?',
                  fct: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  context: context);
            },
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

Widget _listTiles({
  required String title,
  required IconData icon,
  required Function onPressed,
  required Color color,
}) {
  return ListTile(
    title: TextWidget(
      text: title,
      color: color,
      textSize: 20,
    ),
    leading: Icon(icon),
    trailing: const Icon(IconlyLight.arrow_right_2),
    onTap: () {
      onPressed();
    },
  );
}
