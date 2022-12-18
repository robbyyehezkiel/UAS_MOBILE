// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/screens/auth/laundry/cetak.dart';
import 'package:laundry_admin/screens/auth/laundry/pdf_Api.dart';
import 'package:laundry_admin/screens/auth/laundry/pdf_Invoice.dart';

class DataLayndry extends StatefulWidget {
  static const routeName = '/datalaundry';
  const DataLayndry({super.key});

  @override
  State<DataLayndry> createState() => _DataLayndryState();
}

class _DataLayndryState extends State<DataLayndry> {
  final CollectionReference _pemesanan =
      FirebaseFirestore.instance.collection('pemesanan');

  String name = "";

  // ! Hapus Pemesanan !
  Future<void> _delete(String pemesananId) async {
    await _pemesanan.doc(pemesananId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have been succesfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('pemesanan').snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index];

                    // ! Data laundry tanpa search !
                    if (name.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.29,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 234, 240, 241),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.25)),
                          ),
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
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                  child: Container(
                                    color: Colors.grey.withOpacity(0.8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Color.fromARGB(
                                                    255, 11, 4, 104),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    final pdfFile =
                                                        await PdfInvoiceApi
                                                            .generate(data);

                                                    PdfApi.openFile(pdfFile);
                                                  },
                                                  child: const Icon(
                                                    Icons.local_laundry_service,
                                                    size: 100,
                                                    color: Color.fromARGB(
                                                        255, 17, 0, 255),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .local_laundry_service_outlined,
                                                      size: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data['kategori'],
                                                      style: const TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .monitor_weight_outlined,
                                                      size: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data['weight'].toString(),
                                                      style: const TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                      ),
                                                    ),
                                                    const Text(
                                                      '  Kg/Item',
                                                      style: TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.money_outlined,
                                                      size: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data['total'].toString(),
                                                      style: const TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                      ),
                                                    ),
                                                    const Text(
                                                      '  Rupiah',
                                                      style: TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  child: const Icon(
                                                    Icons.print,
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailLaundry(
                                                                  data)),
                                                    );
                                                  },
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 88, 244, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  width: 45,
                                                  height: 45,
                                                  child: IconButton(
                                                    onPressed: () =>
                                                        DetailLaundry(data),
                                                    color: const Color.fromARGB(
                                                        255, 22, 0, 122),
                                                    icon: const Icon(
                                                      Icons.print,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 22, 0, 122),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  width: 140,
                                                  height: 45,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .access_time_outlined,
                                                        color: Color.fromARGB(
                                                            255, 88, 244, 255),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        data['pemesanan']
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                          color: Color.fromARGB(
                                                              255,
                                                              88,
                                                              244,
                                                              255),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 88, 244, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  width: 45,
                                                  height: 45,
                                                  child: IconButton(
                                                    onPressed: () =>
                                                        _delete(data.id),
                                                    color: const Color.fromARGB(
                                                        255, 22, 0, 122),
                                                    icon: const Icon(
                                                      Icons.delete,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    if (data['name']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.29,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 234, 240, 241),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.25)),
                          ),
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
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                  child: Container(
                                    color: Colors.grey.withOpacity(0.8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Color.fromARGB(
                                                    255, 11, 4, 104),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    final pdfFile =
                                                        await PdfInvoiceApi
                                                            .generate(data);

                                                    PdfApi.openFile(pdfFile);
                                                  },
                                                  child: const Icon(
                                                    Icons.local_laundry_service,
                                                    size: 100,
                                                    color: Color.fromARGB(
                                                        255, 17, 0, 255),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .local_laundry_service_outlined,
                                                      size: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data['kategori'],
                                                      style: const TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .monitor_weight_outlined,
                                                      size: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data['weight'].toString(),
                                                      style: const TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                      ),
                                                    ),
                                                    const Text(
                                                      '  Kg/Item',
                                                      style: TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.money_outlined,
                                                      size: 30,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      data['total'].toString(),
                                                      style: const TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                      ),
                                                    ),
                                                    const Text(
                                                      '  Rupiah',
                                                      style: TextStyle(
                                                        fontSize: 19,
                                                        color: Color.fromARGB(
                                                            255, 40, 29, 197),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 88, 244, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  width: 45,
                                                  height: 45,
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    color: const Color.fromARGB(
                                                        255, 22, 0, 122),
                                                    icon: const Icon(
                                                      Icons.print,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 22, 0, 122),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  width: 140,
                                                  height: 45,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .access_time_outlined,
                                                        color: Color.fromARGB(
                                                            255, 88, 244, 255),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        data['pemesanan']
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17,
                                                          color: Color.fromARGB(
                                                              255,
                                                              88,
                                                              244,
                                                              255),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 88, 244, 255),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  width: 45,
                                                  height: 45,
                                                  child: IconButton(
                                                    onPressed: () =>
                                                        _delete(data.id),
                                                    color: const Color.fromARGB(
                                                        255, 22, 0, 122),
                                                    icon: const Icon(
                                                      Icons.delete,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                );
        },
      ),
    );
  }
}
