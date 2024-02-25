// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
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

  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        children: [
          image == null && widget.productModel.image.isNotEmpty
              ? CupertinoButton(
                  onPressed: takePicture,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 70,
                    backgroundImage: NetworkImage(widget.productModel.image),
                  ),
                )
              : CupertinoButton(
                  onPressed: takePicture,
                  child: CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 70,
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
                hintText: widget.productModel.name,
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
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2, color: Colors.red),
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
                hintText: widget.productModel.description,
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
                    color: Colors.lightBlueAccent,
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
                hintText: widget.productModel.price.toString(),
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
                    color: Colors.red,
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
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () async {
                if (image == null &&
                    name.text.isEmpty &&
                    description.text.isEmpty &&
                    price.text.isEmpty) {
                  Navigator.of(context).pop();
                } else if (image != null) {
                  String imageUrl = await FirebaseStorageHelper.instance
                      .uploadUserImage(widget.productModel.id, image!);
                  ProductModel productModel = widget.productModel.copyWith(
                    description:
                        description.text.isEmpty ? null : description.text,
                    name: name.text.isEmpty ? null : name.text,
                    price: price.text.isEmpty ? null : price.text,
                    image: imageUrl,
                  );

                  appProvider.updateSingleProductToFirebase(
                      widget.index, productModel);
                } else {
                  ProductModel productModel = widget.productModel.copyWith(
                    description:
                        description.text.isEmpty ? null : description.text,
                    name: name.text.isEmpty ? null : name.text,
                    price: price.text.isEmpty ? null : price.text,
                  );

                  appProvider.updateSingleProductToFirebase(
                      widget.index, productModel);
                }
                showMessage('updated');
                Navigator.of(context).pop();
              },
              child: const Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
