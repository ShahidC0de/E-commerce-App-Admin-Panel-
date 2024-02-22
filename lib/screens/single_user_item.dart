import 'package:flutter/material.dart';
import 'package:techtrove_admin/models/user_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:techtrove_admin/screens/edit_profile.dart';

class SingleUserItem extends StatefulWidget {
  final UserModel userModel;
  final AppProvider appProvider;
  final int index;

  const SingleUserItem({
    Key? key,
    required this.userModel,
    required this.appProvider,
    required this.index,
  }) : super(key: key);

  @override
  State<SingleUserItem> createState() => _SingleUserItemState();
}

class _SingleUserItemState extends State<SingleUserItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent, // Changed color to match prescription
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            widget.userModel.image != null
                ? ClipOval(
                    child: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.network(
                        widget.userModel.image!,
                      ),
                    ),
                  )
                : const CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                    ),
                  ),
            const SizedBox(
              width: 6.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userModel.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.userModel.email,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            widget.appProvider.getDeletingLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : IconButton(
                    onPressed: () async {
                      await widget.appProvider.deleteTheUser(widget.userModel);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
            IconButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => EditProfile(
                    userModel: widget.userModel,
                    index: widget.index,
                  ),
                ));
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
