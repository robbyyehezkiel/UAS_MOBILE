import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KategoriLaundry extends StatefulWidget {
  static const routeName = '/kategoriPage';
  const KategoriLaundry({super.key});

  @override
  State<KategoriLaundry> createState() => _KategoriLaundryState();
}

class _KategoriLaundryState extends State<KategoriLaundry> {
  final CollectionReference _kategori =
      FirebaseFirestore.instance.collection('kategori');

  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // ! Edit Kategori !
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _kategoriController.text = documentSnapshot['kategori'];
      _priceController.text = documentSnapshot['price'].toString();
    }
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return SizedBox(
          width: 300,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AlertDialog(
                title: Center(
                    child: Text(
                  documentSnapshot!['kategori'],
                  style: const TextStyle(fontSize: 25),
                )),
                content: Center(
                  child: Text(
                    'Harga : ${documentSnapshot['price']} / ${documentSnapshot['size']}',
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                actions: const <Widget>[],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 350,
              ),
              const Text(
                'PILIH KATEGORI',
                style: TextStyle(
                  fontSize: 45,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: _kategori.snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 20.0,
                          childAspectRatio: 1.0 / 1.0,
                        ),
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _update(documentSnapshot);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 70,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 5, 58, 136),
                                            width: 3,
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                              'assets/images/kategori_photo.png'),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        documentSnapshot['kategori'],
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 5, 58, 136),
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
