import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/constants/constants.dart';
import 'package:techtrove_admin/models/category_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
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

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "Add Product",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: takePicture,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: MediaQuery.of(context).size.width *
                      0.2, // Responsive size
                  child: image == null
                      ? const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        )
                      : ClipOval(
                          child: Image.file(
                            image!,
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.width * 0.35,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            _buildTextField(name, 'Product Name', Icons.widgets),
            const SizedBox(height: 16.0),
            _buildTextField(description, 'Description', Icons.description,
                maxLines: 5),
            const SizedBox(height: 16.0),
            _buildTextField(price, 'Price', Icons.price_change,
                keyboardType: TextInputType.number),
            const SizedBox(height: 20.0),
            _buildDropdown(appProvider),
            const SizedBox(height: 20.0),
            _buildAddButton(appProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hintText, IconData icon,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.red),
          prefixIcon: Icon(icon, color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.lightBlueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Colors.red),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(AppProvider appProvider) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonFormField<CategoryModel>(
        value: _selectedCategory,
        hint: const Text(
          'Select Category',
          style: TextStyle(color: Colors.red),
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            _selectedCategory = value;
          });
        },
        items: appProvider.getCatogoriesList.map((CategoryModel val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val.name),
          );
        }).toList(),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        ),
      ),
    );
  }

  Widget _buildAddButton(AppProvider appProvider) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () async {
        if (image == null ||
            _selectedCategory == null ||
            name.text.isEmpty ||
            description.text.isEmpty ||
            price.text.isEmpty) {
          showMessage('Please fill all boxes');
        } else {
          appProvider.addProduct(image!, name.text, description.text,
              price.text, _selectedCategory!.id);
          showMessage('Product added successfully');
          Navigator.of(context).pop();
        }
      },
      child: const Text(
        "Add Product",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
