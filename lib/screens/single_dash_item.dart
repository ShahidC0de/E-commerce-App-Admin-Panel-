import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SingleDashItem extends StatelessWidget {
  final String title, subtitle;
  final void Function()? onpressed;
  const SingleDashItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onpressed,
      child: Card(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40.0,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: subtitle == 'Earning' ? 20 : 25,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
