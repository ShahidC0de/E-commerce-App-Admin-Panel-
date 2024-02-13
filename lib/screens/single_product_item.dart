import 'package:flutter/material.dart';
import 'package:techtrove_admin/models/product_model.dart';

class SingleProductItem extends StatefulWidget {
  const SingleProductItem({
    super.key,
    required this.singleProduct,
  });

  final ProductModel singleProduct;

  @override
  State<SingleProductItem> createState() => _SingleProductItemState();
}

class _SingleProductItemState extends State<SingleProductItem> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
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
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.singleProduct.name,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                Text("Rs: ${widget.singleProduct.price}"),
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
                            // await appProvider.deleteCategoryFromFirebase(
                            //     widget.singleCategory);
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: const Icon(Icons.delete),
                        ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (ctx) => EditCategory(
                    //       categoryModel: widget.singleCategory,
                    //       index: widget.index,
                    //     ),
                    //   ),
                    // );
                  },
                  child: const Icon(Icons.edit),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
