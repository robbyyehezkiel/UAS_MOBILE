// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_pelanggan/screens/non_auth/login_screen.dart';
import 'package:laundry_pelanggan/services/global_methods.dart';

class LogoutButton extends StatefulWidget {
  static const routeName = '/logoutPage';
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 4 / 7,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff40dedf), Color(0xff0fb2ea)],
            ),
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.7),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Wrap(
                children: const [
                  Text(
                    textAlign: TextAlign.center,
                    'TERIMAKASIH TELAH MENGGUNAKAN APLIKASI LAUNDRIMBUR',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  )
                ],
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 125),
              Image.asset('assets/images/background.png')
            ],
          ),
        ),
      ],
    );
  }
}
