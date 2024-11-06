import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/helpers/firebase_firestore.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/category_view.dart';
import 'package:techtrove_admin/screens/order_list.dart';
import 'package:techtrove_admin/screens/product_page.dart';
import 'package:techtrove_admin/screens/single_dash_item.dart';
import 'package:techtrove_admin/screens/users_page.dart';
import 'package:techtrove_admin/screens/users_rating_page.dart';

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
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // User Info Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: const Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30,
                            child: Icon(Icons.person,
                                color: Colors.white, size: 40),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'shahidzada.cs@gmail.com',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Dashboard Items (Responsive Grid)
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      crossAxisCount:
                          isLargeScreen ? 4 : 2, // Responsive columns
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        SingleDashItem(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const UsersPage(),
                            ));
                          },
                          title: appProvider.getUserList.length.toString(),
                          subtitle: 'Users',
                          backgroundColor: Colors.blue,
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
                          backgroundColor: Colors.green,
                        ),
                        SingleDashItem(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const ProductView(),
                            ));
                          },
                          title: appProvider.getProductList.length.toString(),
                          subtitle: 'Products',
                          backgroundColor: Colors.red,
                        ),
                        SingleDashItem(
                          onPressed: () {},
                          title: 'Rs: ${appProvider.getTotalEarning}',
                          subtitle: 'Earning',
                          backgroundColor: Colors.purple,
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
                          backgroundColor: Colors.blue,
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
                          backgroundColor: Colors.green,
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
                          backgroundColor: Colors.red,
                        ),
                        SingleDashItem(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UsersRatingPage()));
                          },
                          title: '.....',
                          subtitle: 'Users Rating',
                          backgroundColor: Colors.yellow.withOpacity(0.4),
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
