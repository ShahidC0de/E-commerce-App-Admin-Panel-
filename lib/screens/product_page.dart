import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/models/product_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/add_product.dart';
import 'package:techtrove_admin/screens/single_product_item.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const AddProduct()));
              },
              icon: const Icon(
                Icons.add_circle,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            primary: false,
            itemCount: appProvider.getProductList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.9,
                crossAxisCount: 2),
            itemBuilder: (ctx, index) {
              ProductModel singleProduct = appProvider.getProductList[index];
              return SingleProductItem(
                singleProduct: singleProduct,
                index: index,
              );
            }),
      ),
    );
  }
}
