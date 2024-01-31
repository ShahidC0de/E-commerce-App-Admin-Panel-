import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() onpressed;
  final String title;
  const CustomElevatedButton(
      {super.key, required this.title, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onpressed,
        child: Text(title),
      ),
    );
  }
}
