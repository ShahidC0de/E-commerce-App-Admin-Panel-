import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/category_view.dart';
import 'package:techtrove_admin/screens/product_page.dart';
import 'package:techtrove_admin/screens/single_dash_item.dart';
import 'package:techtrove_admin/screens/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  void getData() async {
    setState(() {
      isLoading = true;
    });
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    await appProvider.callBackFunction();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(12.0),
                      crossAxisCount: 2,
                      children: [
                        SingleDashItem(
                            onpressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const UsersPage()));
                            },
                            title: appProvider.getUserList.length.toString(),
                            subtitle: 'Users'),
                        SingleDashItem(
                            onpressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const CategoriesPage()));
                            },
                            title:
                                appProvider.getCatogoriesList.length.toString(),
                            subtitle: 'Categories'),
                        SingleDashItem(
                            onpressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => const ProductView()));
                            },
                            title: appProvider.getProductList.length.toString(),
                            subtitle: 'Products'),
                        SingleDashItem(
                            onpressed: () {},
                            title: 'Rs: 6000',
                            subtitle: 'Earning'),
                        SingleDashItem(
                            onpressed: () {},
                            title: '8',
                            subtitle: 'Pending Orders'),
                        SingleDashItem(
                            onpressed: () {},
                            title: '30',
                            subtitle: 'Completed Orders'),
                        SingleDashItem(
                            onpressed: () {}, title: '8', subtitle: 'Canceled'),
                        SingleDashItem(
                            onpressed: () {},
                            title: '18',
                            subtitle: 'Completed'),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
//its generally a list, where each map considered as an item,
