// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/constants/constants.dart';

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

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Edit Product",
          style: TextStyle(
            color: Colors.lightBlueAccent,
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
                    radius: 70,
                    child: Icon(Icons.camera_alt),
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
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                //decoration of textformfield.
                //EMAIL TEXTFORM FILED
                hintText: 'product name',
                hintStyle: const TextStyle(
                  color: Colors.lightBlueAccent,
                ),
                prefixIcon: const Icon(
                  //putting an icon.
                  Icons.email_outlined,
                  color: Colors.lightBlueAccent,
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
            controller: description,
            keyboardType: TextInputType.emailAddress,
            maxLines: 8,
            decoration: InputDecoration(
                //decoration of textformfield.
                //EMAIL TEXTFORM FILED
                hintText: 'description',
                hintStyle: const TextStyle(
                  color: Colors.lightBlueAccent,
                ),
                prefixIcon: const Icon(
                  //putting an icon.
                  Icons.email_outlined,
                  color: Colors.lightBlueAccent,
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
                hintText: 'price',
                hintStyle: const TextStyle(
                  color: Colors.lightBlueAccent,
                ),
                prefixIcon: const Icon(
                  //putting an icon.
                  Icons.email_outlined,
                  color: Colors.lightBlueAccent,
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
            height: 25.0,
          ),
          ElevatedButton(
              onPressed: () async {
                if (image == null ||
                    name.text.isEmpty ||
                    description.text.isEmpty ||
                    price.text.isEmpty) {
                  showMessage('please fill all boxes');
                } else {
                  // String imageUrl = await FirebaseStorageHelper.instance
                  //     .uploadUserImage(widget.productModel.id, image!);
                  // ProductModel productModel = widget.productModel.copyWith(
                  //   description:
                  //       description.text.isEmpty ? null : description.text,
                  //   name: name.text.isEmpty ? null : name.text,
                  //   price: price.text.isEmpty ? null : price.text,
                  //   image: imageUrl,
                  // );

                  // appProvider.updateSingleProductToFirebase(
                  //     widget.index, productModel);
                  showMessage('updated');
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Add"))
        ],
      ),
    );
  }
}
