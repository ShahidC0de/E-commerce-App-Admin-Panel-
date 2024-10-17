import 'package:flutter/material.dart';
import 'package:techtrove_admin/models/user_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';

class SingleUserItem extends StatefulWidget {
  final UserModel userModel;
  final AppProvider appProvider;
  final int index;

  const SingleUserItem({
    super.key,
    required this.userModel,
    required this.appProvider,
    required this.index,
  });

  @override
  State<SingleUserItem> createState() => _SingleUserItemState();
}

class _SingleUserItemState extends State<SingleUserItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isLargeScreen = size.width > 600; // For responsive layout

    return Card(
      elevation: 4, // Slight shadow for depth
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // Rounded corners for a modern look
      ),
      color: Colors.blueAccent, // Consistent color for branding
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            widget.userModel.image != null
                ? ClipOval(
                    child: SizedBox(
                      height: isLargeScreen ? 80 : 60,
                      width: isLargeScreen ? 80 : 60,
                      child: Image.network(
                        widget.userModel.image!,
                        fit: BoxFit.cover, // Ensure the image covers the area
                      ),
                    ),
                  )
                : CircleAvatar(
                    radius: isLargeScreen ? 40 : 30,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: const Icon(
                      Icons.person,
                      color: Colors.blueAccent,
                      size: 30,
                    ),
                  ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userModel.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isLargeScreen ? 20 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    widget.userModel.email,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: isLargeScreen ? 16 : 14,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            widget.appProvider.getDeletingLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : IconButton(
                    onPressed: () async {
                      await widget.appProvider.deleteTheUser(widget.userModel);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 28,
                    ),
                    splashRadius: 24,
                    tooltip: 'Delete User',
                  ),
          ],
        ),
      ),
    );
  }
}
