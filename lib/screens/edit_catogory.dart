// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/helpers/firebase_storage_helper.dart';
import 'package:techtrove_admin/models/category_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';

class EditCategory extends StatefulWidget {
  final CategoryModel categoryModel;
  final int index;
  const EditCategory(
      {super.key, required this.categoryModel, required this.index});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  File? image;
  final TextEditingController name = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill the text field with the current category name
    name.text = widget.categoryModel.name;
  }

  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final size = MediaQuery.of(context).size;
    final bool isLargeScreen = size.width > 600; // Screen size check

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Edit Category",
          style: TextStyle(
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        elevation: 2.0, // Slight shadow effect for AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Picker with improved styling
              image == null
                  ? CupertinoButton(
                      onPressed: takePicture,
                      child: const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : CupertinoButton(
                      onPressed: takePicture,
                      child: CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 70,
                      ),
                    ),
              const SizedBox(height: 20.0),

              // Name input field with better padding and styling
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  hintText: "Category Name",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  prefixIcon: const Icon(
                    Icons.category,
                    color: Colors.lightBlueAccent,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100], // Light background for input
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide.none, // No default border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: const BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),

              // Responsive Update button
              SizedBox(
                width: isLargeScreen
                    ? 300
                    : double.infinity, // Responsive button width
                child: ElevatedButton(
                  onPressed: () async {
                    if (image == null && name.text.isEmpty) {
                      Navigator.of(context).pop();
                    } else if (image != null) {
                      String imageUrl = await FirebaseStorageHelper.instance
                          .uploadUserImage(widget.categoryModel.id, image!);
                      CategoryModel categoryModel =
                          widget.categoryModel.copyWith(
                        image: imageUrl,
                        name: name.text.isEmpty ? null : name.text,
                      );
                      appProvider.updateCategoryList(
                          widget.index, categoryModel);
                    } else {
                      CategoryModel categoryModel =
                          widget.categoryModel.copyWith(
                        name: name.text.isEmpty ? null : name.text,
                      );
                      appProvider.updateCategoryList(
                          widget.index, categoryModel);
                    }
                    showMessage('Category updated successfully');
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Colors.lightBlueAccent,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text("Update Category"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.lightBlueAccent,
    ));
  }
}
