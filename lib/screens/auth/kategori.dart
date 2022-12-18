// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/widgets/drawer.dart';

class DataKategori extends StatefulWidget {
  static const routeName = '/kategori';
  const DataKategori({super.key});

  @override
  State<DataKategori> createState() => _DataKategoriState();
}

class _DataKategoriState extends State<DataKategori> {
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

    String? size;
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              DropdownSearch<String>(
                items: const [
                  "Kg",
                  "Item",
                ],
                onChanged: ((value) {
                  size = value;
                }),
                selectedItem: "-- Pilih Kategori --",
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final String kategori = _kategoriController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (price != null) {
                      await _kategori.doc(documentSnapshot!.id).update({
                        "kategori": kategori,
                        "price": price,
                        "size": size,
                      });
                      _kategoriController.text = '';
                      _priceController.text = '';
                    }
                  },
                  child: const Text('Update'))
            ],
          ),
        );
      },
    );
  }

  // ! Tambah Kategori !
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _kategoriController.text = documentSnapshot['kategori'];
      _priceController.text = documentSnapshot['price'].toString();
    }
    String? size;

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
              DropdownSearch<String>(
                items: const [
                  "Kg",
                  "Item",
                ],
                onChanged: ((value) {
                  size = value;
                }),
                selectedItem: "-- Pilih Kategori --",
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String kategori = _kategoriController.text;
                  final double? price = double.tryParse(_priceController.text);
                  if (price != null) {
                    await _kategori.add({
                      "kategori": kategori,
                      "price": price,
                      "size": size,
                    });
                    _kategoriController.text = '';
                    _priceController.text = '';
                  }
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _delete(String kategoriId) async {
    await _kategori.doc(kategoriId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have been succesfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kategori Laundry'),
        elevation: 0,
        iconTheme: const IconThemeData.fallback(),
      ),
      drawer: const Drawer(
        child: DrawerPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: _kategori.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['kategori']),
                    subtitle: Text(
                        '${documentSnapshot['price']} / ${documentSnapshot['size']}'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _update(documentSnapshot),
                            icon: const Icon(
                              Icons.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _delete(documentSnapshot.id),
                            icon: const Icon(
                              Icons.delete,
                            ),
                          ),
                        ],
                      ),
                    ),
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
    );
  }
}
