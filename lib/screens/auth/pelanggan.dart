// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laundry_admin/widgets/drawer.dart';

class DataPelanggan extends StatefulWidget {
  static const routeName = '/DataPelanggan';
  const DataPelanggan({super.key});

  @override
  State<DataPelanggan> createState() => _DataPelangganState();
}

class _DataPelangganState extends State<DataPelanggan> {
  // ? User Text Controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;
  String name = "";

  final CollectionReference _pelanggan =
      FirebaseFirestore.instance.collection('users_pelanggan');

  // ! Tambah Pelanggan !
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _emailController.text = documentSnapshot['email'];
      _passwordController.text = documentSnapshot['password'];
      _phoneController.text = documentSnapshot['phone_number'];
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
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telepon'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = _nameController.text;
                  final String email = _emailController.text;
                  final String password = _passwordController.text;
                  final String telepon = _phoneController.text;

                  await _pelanggan.add({
                    "name": name,
                    "email": email,
                    "password": password,
                    "phone_number": telepon,
                  });
                  _nameController.text = '';
                  _emailController.text = '';
                  _passwordController.text = '';
                  _phoneController.text = '';
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
        );
      },
    );
  }

  // ! Edit Pelanggan !
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _phoneController.text = documentSnapshot['phone_number'];
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
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Time'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String name = _nameController.text;
                  final String telepon = _phoneController.text;
                  await _pelanggan.doc(documentSnapshot!.id).update({
                    "name": name,
                    "phone_number": telepon,
                  });
                  _nameController.text = '';
                  _phoneController.text = '';
                },
                child: const Text('Update'),
              )
            ],
          ),
        );
      },
    );
  }

  // ! Hapus Pelanggan !
  Future<void> _delete(String pelangganId) async {
    await _pelanggan.doc(pelangganId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have been succesfully deleted a product')));
  }

  List<String> docIDs = [];

  Future getDocID() async {
    await FirebaseFirestore.instance.collection('users_pelanggan').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
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
        onPressed: () => _create(),
        child: const Icon(Icons.add),
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
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => _update(data),
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _delete(data.id),
                                  icon: const Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    if (data['name'].toString().toLowerCase().startsWith(
                          name.toLowerCase(),
                        )) {
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
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => _update(data),
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _delete(data.id),
                                  icon: const Icon(
                                    Icons.delete,
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
