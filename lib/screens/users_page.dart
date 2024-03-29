import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/models/user_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/single_user_item.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Changed color to match prescription
        centerTitle: true,
        title: const Text(
          'Users',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<AppProvider>(builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.getUserList.length,
          itemBuilder: (context, index) {
            UserModel userModel = value.getUserList[index];
            return SingleUserItem(
              index: index,
              userModel: userModel,
              appProvider: value,
            );
          },
        );
      }),
    );
  }
}
