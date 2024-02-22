import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/category_view.dart';
import 'package:techtrove_admin/screens/order_list.dart';
import 'package:techtrove_admin/screens/product_page.dart';
import 'package:techtrove_admin/screens/single_dash_item.dart';
import 'package:techtrove_admin/screens/users_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 30,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'shahidzada.cs@gmail.com',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(12),
                      crossAxisCount: 2,
                      children: [
                        SingleDashItem(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const UsersPage(),
                            ));
                          },
                          title: appProvider.getUserList.length.toString(),
                          subtitle: 'Users',
                          backgroundColor: Colors.blue, // Blue color
                        ),
                        SingleDashItem(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const CategoriesPage(),
                            ));
                          },
                          title:
                              appProvider.getCatogoriesList.length.toString(),
                          subtitle: 'Categories',
                          backgroundColor: Colors.green, // Green color
                        ),
                        SingleDashItem(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const ProductView(),
                            ));
                          },
                          title: appProvider.getProductList.length.toString(),
                          subtitle: 'Products',
                          backgroundColor: Colors.red, // Red color
                        ),
                        SingleDashItem(
                          onPressed: () {},
                          title: 'Rs: ${appProvider.getTotalEarning}',
                          subtitle: 'Earning',
                          backgroundColor: Colors.purple, // Purple color
                        ),
                        SingleDashItem(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => OrderViewList(
                                ordermodelList: appProvider.getPendOrders,
                                title: 'Pending Orders',
                              ),
                            ));
                          },
                          title: appProvider.getPendOrders.length.toString(),
                          subtitle: 'Pending Orders',
                          backgroundColor: Colors.blue, // Blue color
                        ),
                        SingleDashItem(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => OrderViewList(
                                title: "Completed Orders",
                                ordermodelList: appProvider.getComPletedOrdErs,
                              ),
                            ));
                          },
                          title:
                              appProvider.getComPletedOrdErs.length.toString(),
                          subtitle: 'Delivered Orders',
                          backgroundColor: Colors.green, // Green color
                        ),
                        SingleDashItem(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => OrderViewList(
                                ordermodelList: appProvider.getCancelOrders,
                                title: "Canceled Orders",
                              ),
                            ));
                          },
                          title: appProvider.getCancelOrders.length.toString(),
                          subtitle: 'Canceled Orders',
                          backgroundColor: Colors.red, // Red color
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
