import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techtrove_admin/screens/users_screen.dart';
import 'package:techtrove_admin/wigets/button.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<List<String>> getCollections() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();
    List<String> collections = [];
    querySnapshot.docs.forEach(
      (doc) {
        collections.add(doc.id);
      },
    );
    return collections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            CustomElevatedButton(
              title: "users",
              onpressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const UsersPage(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomElevatedButton(
              title: "items",
              onpressed: () {},
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomElevatedButton(
              title: "orders",
              onpressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
