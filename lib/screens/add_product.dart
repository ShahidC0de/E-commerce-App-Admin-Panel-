// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: takePicture,
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 70,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                  ),
                ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: name,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                //decoration of textformfield.
                //EMAIL TEXTFORM FILED
                hintText: 'Product Name',
                hintStyle: const TextStyle(
                  color: Colors.red,
                ),
                prefixIcon: const Icon(
                  //putting an icon.
                  Icons.widgets,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.lightBlueAccent,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                )),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: description,
            keyboardType: TextInputType.text,
            maxLines: 8,
            decoration: InputDecoration(
                //decoration of textformfield.
                //EMAIL TEXTFORM FILED
                hintText: 'description',
                hintStyle: const TextStyle(
                  color: Colors.red,
                ),
                prefixIcon: const Icon(
                  //putting an icon.
                  Icons.description,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.lightBlueAccent,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                )),
          ),
          const SizedBox(
            height: 12.0,
          ),
          TextFormField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                //decoration of textformfield.
                //EMAIL TEXTFORM FILED
                hintText: 'price',
                hintStyle: const TextStyle(
                  color: Colors.red,
                ),
                prefixIcon: const Icon(
                  //putting an icon.
                  Icons.price_change,
                  color: Colors.red,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.lightBlueAccent,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                )),
          ),
          const SizedBox(
            height: 25.0,
          ),
          DropdownButtonFormField(
            value: _selectedCategory,
            hint: const Text(
              'Select Category',
              style: TextStyle(
                color: Colors.red,
              ),
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
                child: Text(
                  val.name,
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                if (image == null ||
                    _selectedCategory == null ||
                    name.text.isEmpty ||
                    description.text.isEmpty ||
                    price.text.isEmpty) {
                  showMessage('please fill all boxes');
                } else {
                  appProvider.addProduct(image!, name.text, description.text,
                      price.text, _selectedCategory!.id);

                  showMessage('updated');
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
