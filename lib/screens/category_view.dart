import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/models/category_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/add_category.dart';
import 'package:techtrove_admin/screens/single_category_item.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLargeScreen = size.width > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.green, // Consistent color for categories section
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddCategory()));
            },
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 28,
            ),
            tooltip: 'Add Category', // Better UX with tooltip
          )
        ],
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold, // Enhanced title styling
          ),
        ),
      ),
      body: Consumer<AppProvider>(builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0), // Added padding for better layout
          child: value.getCatogoriesList.isEmpty
              ? const Center(
                  child: Text(
                    'No categories available',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: value.getCatogoriesList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isLargeScreen ? 3 : 2, // Responsive grid
                    mainAxisSpacing: 12.0, // Space between grid items
                    crossAxisSpacing: 12.0, // Space between grid columns
                    childAspectRatio:
                        3 / 2, // Item aspect ratio for better layout
                  ),
                  itemBuilder: (context, index) {
                    CategoryModel categoryModel =
                        value.getCatogoriesList[index];
                    return SingleCategoryItem(
                      singleCategory: categoryModel,
                      index: index,
                    );
                  },
                ),
        );
      }),
    );
  }
}
