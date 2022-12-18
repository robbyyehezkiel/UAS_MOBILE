// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laundry_admin/screens/auth/laundry/laundry.dart';
import 'package:laundry_admin/widgets/drawer.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/searchpage';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // ? Kategori Text Controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  String name = "";
  CollectionReference<Map<String, dynamic>> data =
      FirebaseFirestore.instance.collection('users_pelanggan');

  final CollectionReference _pemesanan =
      FirebaseFirestore.instance.collection('pemesanan');

  // ! Tambah Pemesanan !
  Future<void> _createpemesanan([DocumentSnapshot? documentSnapshot]) async {
    double? result, num1, num2;
    total() {
      setState(() {
        num1 = double.parse(_priceController.text);
        num2 = double.parse(_weightController.text);

        result = num1! * num2!;
      });
    }

    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
    }

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
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _kategoriController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga'),
              ),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Ukuran'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        total();
                        _resultController.text = result.toString();
                      });
                    },
                    child: const Text('Hitung Total'),
                  ),
                ],
              ),
              TextFormField(
                readOnly: true,
                controller: _resultController,
                decoration: InputDecoration(labelText: _resultController.text),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = _nameController.text;
                  final String kategori = _kategoriController.text;
                  final double? harga = double.tryParse(_priceController.text);
                  final double? weight =
                      double.tryParse(_weightController.text);
                  var now = DateTime.now();
                  var formatter = DateFormat('dd-MM-yyyy');
                  String formattedDate = formatter.format(now);
                  print(formattedDate); // 2016-01-25

                  await _pemesanan.add({
                    "name": name,
                    "kategori": kategori,
                    "harga": harga,
                    "weight": weight,
                    "total": '$result',
                    "pemesanan": formattedDate
                  });
                  _nameController.text = '';
                  _kategoriController.text = '';
                  _priceController.text = '';
                  _weightController.text = '';
                  _resultController.text = '';
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
        );
      },
    );
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
      drawer: const Drawer(
        child: DrawerPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const DataLayndry()),
          );
        },
        child: const Icon(Icons.read_more_outlined),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users_pelanggan')
            .snapshots(),
        builder: (context, snapshots) {
          return (snapshots.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: snapshots.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshots.data!.docs[index];

                    if (name.isEmpty) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            backgroundImage: const NetworkImage(
                                "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"),
                          ),
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['phone_number'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => _createpemesanan(data),
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    if (data['name']
                        .toString()
                        .toLowerCase()
                        .startsWith(name.toLowerCase())) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            backgroundImage: const NetworkImage(
                                "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png"),
                          ),
                          title: Text(
                            data['name'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            data['phone_number'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: SizedBox(
                            width: 50,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => _createpemesanan(data),
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ],
                            ),
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
