import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:techtrove_admin/screens/dash_board.dart';
import 'package:techtrove_admin/wigets/button.dart';
import 'package:techtrove_admin/wigets/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  late final TextEditingController _email = TextEditingController();
  late final TextEditingController _passwod = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TechTrove Admin Panel'),
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: _email,
            labelText: "Email",
            onchanged: (text) {},
          ),
          const SizedBox(
            height: 12.0,
          ),
          CustomTextField(
            controller: _passwod,
            labelText: "Password",
            onchanged: (text) {},
          ),
          const SizedBox(
            height: 12.0,
          ),
          CustomElevatedButton(
            title: "login",
            onpressed: () async {
              final email = _email.text;
              final password = _passwod.text;
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(email: email, password: password);
              final currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              } else {}
            },
          ),
        ],
      ),
    );
  }
}
