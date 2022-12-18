import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laundry_pelanggan/screens/auth/dashboard.dart';
import 'package:laundry_pelanggan/screens/auth/kategori.dart';
import 'package:laundry_pelanggan/screens/auth/notification.dart';
import 'package:laundry_pelanggan/screens/auth/pesan.dart';
import 'package:laundry_pelanggan/screens/auth/profile.dart';
import 'package:laundry_pelanggan/screens/auth/home_screen.dart';
import 'package:laundry_pelanggan/screens/non_auth/forget_screen.dart';
import 'package:laundry_pelanggan/screens/non_auth/login_screen.dart';
import 'package:laundry_pelanggan/screens/non_auth/register_screen.dart';

// ! To initialize Firebase in the main.dart !

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('An error occured'),
              ),
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Colors.transparent,
          ),
          home: const LoginScreen(),
          routes: {
            HomePelanggan.routeName: (ctx) => const HomePelanggan(),
            DashboardPage.routeName: (ctx) => const DashboardPage(),
            ProfileLaundry.routeName: (ctx) => const ProfileLaundry(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            RegisterScreen.routeName: (ctx) => const RegisterScreen(),
            PesanUser.routeName: (ctx) => const PesanUser(),
            ForgetPasswordScreen.routeName: (ctx) =>
                const ForgetPasswordScreen(),
            KategoriLaundry.routeName: (ctx) => const KategoriLaundry(),
            NotificationPage.routeName: (ctx) => const NotificationPage(),
          },
        );
      },
    );
  }
}
