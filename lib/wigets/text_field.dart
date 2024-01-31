import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final void Function(String)? onchanged;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.onchanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        onChanged: onchanged,
      ),
    );
  }
}
