import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/screens/auth/kategori.dart';
import 'package:laundry_admin/screens/auth/laundry/laundry.dart';
import 'package:laundry_admin/screens/auth/pelanggan.dart';
import 'package:laundry_admin/screens/auth/pemesanan.dart';
import 'package:laundry_admin/screens/home_screen.dart';
import 'package:laundry_admin/screens/non_auth/forget_screen.dart';
import 'package:laundry_admin/screens/non_auth/login_screen.dart';
import 'package:laundry_admin/screens/non_auth/register_screen.dart';

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
            primaryColor: const Color.fromARGB(251, 83, 215, 255),
          ),
          home: const LoginScreen(),
          routes: {
            FetchScreen.routeName: (ctx) => const FetchScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            RegisterScreen.routeName: (ctx) => const RegisterScreen(),
            ForgetPasswordScreen.routeName: (ctx) =>
                const ForgetPasswordScreen(),

            // ? data admin ?
            SearchPage.routeName: (ctx) => const SearchPage(),
            DataLayndry.routeName: (ctx) => const DataLayndry(),
            DataPelanggan.routeName: (ctx) => const DataPelanggan(),
            DataKategori.routeName: (ctx) => const DataKategori(),
          },
        );
      },
    );
  }
}
