// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DetailLaundry extends StatelessWidget {
  dynamic data;

  DetailLaundry(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const PrintPDF(),
          //   ),
          // );
        },
        child: const Icon(Icons.print),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'TRANSAKSI BERHASIL',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              bottom: 20,
              right: 20,
            ),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 241, 241, 241),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Table(
                border: const TableBorder(
                  horizontalInside: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 109, 106, 106),
                    style: BorderStyle.solid,
                  ),
                ),
                columnWidths: const <int, TableColumnWidth>{
                  0: IntrinsicColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FixedColumnWidth(64),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  //* Row-1
                  TableRow(
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        width: 128,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Text(
                                'Tanggal',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TableCell(
                        child: Container(
                          height: 32,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data['pemesanan'],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //* Row-2
                  TableRow(
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        width: 128,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Text(
                                'Nama',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TableCell(
                        child: Container(
                          height: 32,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //* Row-3
                  TableRow(
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        width: 128,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Text(
                                'Kategori',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TableCell(
                        child: Container(
                          height: 32,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data['kategori'],
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  //* Row-4
                  TableRow(
                    children: <Widget>[
                      SizedBox(
                        height: 45,
                        width: 128,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20,
                              ),
                              child: Text(
                                'Berat',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TableCell(
                        child: Container(
                          height: 32,
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data['weight'].toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Rp. ',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                data['harga'].toString(),
                style: const TextStyle(
                  fontSize: 35,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Terimakasih telah menggunakan jasa laundrimbur',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 109, 106, 106),
                ),
                maxLines: 2,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'kami tunggu kedatangan anda selanjutnya',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 109, 106, 106),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
