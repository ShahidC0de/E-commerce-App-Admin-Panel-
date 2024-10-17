// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/constants/constants.dart';
import 'package:techtrove_admin/helpers/firebase_storage_helper.dart';
import 'package:techtrove_admin/models/product_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';

class EditProduct extends StatefulWidget {
  final ProductModel productModel;
  final int index;

  const EditProduct(
      {super.key, required this.productModel, required this.index});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File? image;

  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }

  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "Edit Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: 20.0), // Responsive padding
        child: SingleChildScrollView(
          // Scrollable for better UX on small screens
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: takePicture,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(widget.productModel.image),
                  child: image == null && widget.productModel.image.isEmpty
                      ? const Icon(Icons.add_a_photo,
                          color: Colors.white, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20.0),
              _buildTextField(
                controller: name,
                hintText: widget.productModel.name,
                prefixIcon: Icons.widgets,
              ),
              const SizedBox(height: 20.0),
              _buildTextField(
                controller: description,
                hintText: widget.productModel.description,
                prefixIcon: Icons.description,
                maxLines: 8,
              ),
              const SizedBox(height: 20.0),
              _buildTextField(
                controller: price,
                hintText: widget.productModel.price.toString(),
                prefixIcon: Icons.price_change,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.3,
                      vertical: 15.0), // Responsive button
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Rounded corners
                  ),
                ),
                onPressed: () async {
                  if (image == null &&
                      name.text.isEmpty &&
                      description.text.isEmpty &&
                      price.text.isEmpty) {
                    Navigator.of(context).pop();
                  } else {
                    ProductModel productModel = widget.productModel.copyWith(
                      description:
                          description.text.isEmpty ? null : description.text,
                      name: name.text.isEmpty ? null : name.text,
                      price: price.text.isEmpty ? null : price.text,
                      image: image != null
                          ? await FirebaseStorageHelper.instance
                              .uploadUserImage(widget.productModel.id, image!)
                          : widget.productModel.image,
                    );

                    appProvider.updateSingleProductToFirebase(
                        widget.index, productModel);
                    showMessage('Updated');
                    Navigator.of(context).pop();
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    int? maxLines,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.red),
        prefixIcon: Icon(prefixIcon, color: Colors.red),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius:
              BorderRadius.circular(30.0), // Rounded corners for input fields
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: Colors.red),
          borderRadius: BorderRadius.circular(30.0),
        ),
        filled: true,
        fillColor: Colors.white, // Background color for the text fields
      ),
    );
  }
}
