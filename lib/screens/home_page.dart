import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //crossAxisAlignment is for starting the widget in start of column,

            children: [
              //a widget which is for showing picture in a circle box,
              const CircleAvatar(
                radius: 30,
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                'shahidzada.cs@gmail.com',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }

  static final List<Map<String, dynamic>> _dashBoardItems = [
    {
      //1
      'title': '400',
      'subtitle': 'users'
    },
    {
      //2
      'title': '6',
      'subtitle': 'categories'
    },
    {
      //3
      'title': '600',
      'subtitle': 'products'
    },
    {
      //4
      'title': 'Rs: 7000',
      'subtitle': 'Earning'
    },
    {
      //5
      'title': '5',
      'subtitle': 'Canceled Orders'
    },
    {
      //6
      'title': '350',
      'subtitle': 'Completed Orders'
    },
    {
      //7
      'title': '8',
      'subtitle': 'Pending Orders'
    },
    {
      //8
      'title': '50',
      'subtitle': 'Deleiverd Orders'
    },
  ];
}
//its generally a list, where each map considered as an item,
