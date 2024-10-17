import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/models/user_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/single_user_item.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Users',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold, // Enhanced title styling
          ),
        ),
      ),
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          if (appProvider.getUserList.isEmpty) {
            return const Center(
              child: Text(
                'No users found',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: appProvider.getUserList.length,
            itemBuilder: (context, index) {
              UserModel userModel = appProvider.getUserList[index];
              return SingleUserItem(
                index: index,
                userModel: userModel,
                appProvider: appProvider,
              );
            },
          );
        },
      ),
    );
  }
}
