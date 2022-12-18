import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/widgets/drawer.dart';

class FetchScreen extends StatefulWidget {
  static const routeName = '/fetch';
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pelanggan'),
        elevation: 0,
        iconTheme: const IconThemeData.fallback(),
      ),
      drawer: const Drawer(
        child: DrawerPage(),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        // is used to create container full screen with filled content.
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/dash_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 125,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'APLIKASI',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 18, 16, 155)),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'LAUNDRIMBUR',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 17, 255),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
