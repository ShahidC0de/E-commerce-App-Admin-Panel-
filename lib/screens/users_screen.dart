import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Future<List<DocumentSnapshot>> getUsers() async {
    QuerySnapshot<Map<String, dynamic>> collections =
        await FirebaseFirestore.instance.collection('users').get();
    return collections.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Users'),
      ),
      body: FutureBuilder(
          future: getUsers(),
          builder: (context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<DocumentSnapshot> users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  var user = users[index];
                  var imageUrl = user['image'] as String?;
                  var email = user['email'] as String?;
                  var name = user['name'] as String?;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: imageUrl != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(imageUrl),
                            )
                          : const Icon(Icons.person),
                      title: Text(name ?? ''),
                      subtitle: Text(email ?? ''),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
