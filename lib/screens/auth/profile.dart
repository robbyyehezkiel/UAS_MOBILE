import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileLaundry extends StatefulWidget {
  static const routeName = '/profilePage';
  const ProfileLaundry({super.key});

  @override
  State<ProfileLaundry> createState() => _ProfileLaundryState();
}

class _ProfileLaundryState extends State<ProfileLaundry> {
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
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),

              // * Start Profile Image
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 200,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/laundry.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            // Clip it cleanly.
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Container(
                                color: Colors.grey.withOpacity(0.5),
                                alignment: Alignment.center,
                                child: const Text(
                                  "LAUNDRIMBUR",
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 55,
              ),
              // * Close Profile Image

              // * Start Table Jadwal
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Jadwal Buka',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Table(
                      border: TableBorder.all(
                          borderRadius: BorderRadius.circular(5), width: 2),
                      // columnWidths: const <int, TableColumnWidth>{
                      //   0: IntrinsicColumnWidth(),
                      //   1: FlexColumnWidth(),
                      // },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: const Color.fromARGB(255, 207, 196, 195),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Hari',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: const Color.fromARGB(255, 207, 196, 195),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Hari',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        //* Hari -1
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Senin',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '09.00 - 21.00',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        //* Hari -2
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Selasa',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '09.00 - 21.00',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        //* Hari -3
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Rabu',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '09.00 - 21.00',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        //* Hari -4
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Kamis',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '09.00 - 21.00',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        //* Hari -5
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Jum\'at',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '09.00 - 20.00',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ), //* Hari -5
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Sabtu',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '09.00 - 20.00',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        //* Hari -7
                        TableRow(
                          children: <Widget>[
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Minggu',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    '09.00 - 17.00',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //* End Table Jadwal

              // * Start Kontak Laundry
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Kontak Kami',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Table(
                      border: TableBorder.all(
                        width: 0,
                        color: Colors.transparent,
                      ),
                      columnWidths: const <int, TableColumnWidth>{
                        0: IntrinsicColumnWidth(),
                        1: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        //* Item-1
                        TableRow(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.phone_android,
                                    size: 35,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    '(+62) 821-7425-321',
                                    style: TextStyle(fontSize: 25),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        //* Item-2
                        TableRow(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.mail_outline,
                                    size: 35,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    'laundrimbur@gmail.com',
                                    style: TextStyle(fontSize: 25),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        //* Item-2
                        TableRow(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                              ),
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.instagram,
                                    size: 35,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    '@laundrimbur_jambi',
                                    style: TextStyle(fontSize: 25),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // * End Kontak Laundry
            ],
          ),
        ),
      ],
    );
  }
}
