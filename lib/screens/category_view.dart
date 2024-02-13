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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const AddCategory()));
              },
              icon: const Icon(Icons.add_circle))
        ],
        centerTitle: true,
        title: const Text('Categories'),
      ),
      body: Consumer<AppProvider>(builder: (context, value, child) {
        return SingleChildScrollView(
          child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: value.getCatogoriesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                CategoryModel categoryModel = value.getCatogoriesList[index];
                return SingleCategoryItem(
                  singleCategory: categoryModel,
                  index: index,
                );
              }),
        );
      }),
    );
  }
}
