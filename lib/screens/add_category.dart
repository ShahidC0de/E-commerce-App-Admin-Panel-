// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/constants/constants.dart';
import 'package:techtrove_admin/provider/app_provider.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  File? image;
  final TextEditingController nameController = TextEditingController();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Add Category",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: takePicture,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.green,
                  backgroundImage: image != null ? FileImage(image!) : null,
                  child: image == null
                      ? const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: 'Category Name',
                hintStyle: const TextStyle(color: Colors.green),
                prefixIcon: const Icon(
                  Icons.category,
                  color: Colors.green,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: const BorderSide(width: 2, color: Colors.green),
                ),
              ),
            ),
            const SizedBox(height: 25.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
              ),
              onPressed: () async {
                try {
                  if (image == null || nameController.text.isEmpty) {
                    showMessage('Please provide both image and name.');
                  } else {
                    appProvider.addCategoryModel(image!, nameController.text);
                    showMessage('Successfully Added');
                    Navigator.of(context).pop();
                  }
                } catch (e) {
                  showMessage('Error adding category: $e');
                }
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
