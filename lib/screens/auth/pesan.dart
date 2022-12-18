import 'package:flutter/material.dart';

class PesanUser extends StatefulWidget {
  static const routeName = '/pesan';
  const PesanUser({super.key});

  @override
  State<PesanUser> createState() => _PesanUserState();
}

class _PesanUserState extends State<PesanUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello')),
    );
  }
}
