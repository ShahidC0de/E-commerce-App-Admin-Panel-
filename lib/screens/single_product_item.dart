import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/models/product_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/edit_product.dart';

class SingleProductItem extends StatefulWidget {
  const SingleProductItem({
    super.key,
    required this.singleProduct,
    required this.index,
  });

  final ProductModel singleProduct;
  final int index;

  @override
  State<SingleProductItem> createState() => _SingleProductItemState();
}

class _SingleProductItemState extends State<SingleProductItem> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Card(
      color: Colors.white,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.singleProduct.image,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.singleProduct.name,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "Rs: ${widget.singleProduct.price}",
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: Row(
              children: [
                Center(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await appProvider.deleteProductFromFirebase(
                                widget.singleProduct);
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => EditProduct(
                          productModel: widget.singleProduct,
                          index: widget.index,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
