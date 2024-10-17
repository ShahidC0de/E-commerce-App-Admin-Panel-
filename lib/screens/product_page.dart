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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddProduct()),
              );
            },
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
          ),
        ],
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
        child: GridView.builder(
          padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
          shrinkWrap: true,
          primary: false,
          itemCount: appProvider.getProductList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 0.8, // Adjusted aspect ratio for better fit
            crossAxisCount: screenWidth > 600 ? 3 : 2, // Responsive grid
          ),
          itemBuilder: (ctx, index) {
            ProductModel singleProduct = appProvider.getProductList[index];
            return Card(
              elevation: 5, // Adding shadow
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              child: SingleProductItem(
                singleProduct: singleProduct,
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }
}
