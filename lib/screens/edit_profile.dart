// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/constants/constants.dart';
import 'package:techtrove_admin/helpers/firebase_storage_helper.dart';
import 'package:techtrove_admin/models/user_model.dart';

import 'package:techtrove_admin/provider/app_provider.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  final int index;
  const EditProfile({super.key, required this.userModel, required this.index});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          "Edit Profile",
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
                      backgroundColor: Colors.blueAccent,
                      radius: 70,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )),
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
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                //decoration of textformfield.
                //EMAIL TEXTFORM FILED
                hintText: widget.userModel.name,
                hintStyle: const TextStyle(
                  color: Colors.blueAccent,
                ),
                prefixIcon: const Icon(
                  //putting an icon.
                  Icons.email_outlined,
                  color: Colors.blueAccent,
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.blueAccent,
                  ),
                  borderRadius: BorderRadius.circular(
                    40.0,
                  ),
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
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () async {
                  if (image == null && name.text.isEmpty) {
                    Navigator.of(context).pop();
                  } else if (image != null) {
                    String imageUrl = await FirebaseStorageHelper.instance
                        .uploadUserImage(widget.userModel.id, image!);
                    UserModel userModel = widget.userModel.copyWith(
                      image: imageUrl,
                      name: name.text.isEmpty ? null : name.text,
                    );
                    appProvider.updateUserInfo(widget.index, userModel);
                  } else {
                    UserModel userModel = widget.userModel.copyWith(
                      name: name.text.isEmpty ? null : name.text,
                    );
                    appProvider.updateUserInfo(widget.index, userModel);
                  }
                  showMessage('updated');
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
