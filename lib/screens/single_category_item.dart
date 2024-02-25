import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/models/category_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/edit_catogory.dart';

class SingleCategoryItem extends StatefulWidget {
  final CategoryModel singleCategory;
  final int index;
  const SingleCategoryItem(
      {super.key, required this.singleCategory, required this.index});

  @override
  State<SingleCategoryItem> createState() => _SingleCategoryItemState();
}

class _SingleCategoryItemState extends State<SingleCategoryItem> {
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
        children: [
          Center(
            child: SizedBox(
              //the space given to a single card.

              child: Image.network(
                widget.singleCategory.image,
              ),
              //the child of card which is image/image.network is use to access internet for the link.
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
                            await appProvider.deleteCategoryFromFirebase(
                                widget.singleCategory);
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
                        builder: (ctx) => EditCategory(
                          categoryModel: widget.singleCategory,
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
