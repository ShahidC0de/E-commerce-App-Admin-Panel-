// ignore_for_file: unnecessary_null_comparison, use_super_parameters, use_build_context_synchronously, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/models/order_model.dart';
import 'package:techtrove_admin/models/user_model.dart'; // Import UserModel
import 'package:techtrove_admin/provider/app_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techtrove_admin/screens/home_page.dart'; // Import for Firestore

class SingleOrderWidget extends StatefulWidget {
  final OrderModel orderModel;

  const SingleOrderWidget({Key? key, required this.orderModel})
      : super(key: key);

  @override
  State<SingleOrderWidget> createState() => _SingleOrderWidgetState();
}

class _SingleOrderWidgetState extends State<SingleOrderWidget> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: width * 0.25,
              height: width * 0.25,
              color: Colors.grey.withOpacity(0.2),
              child: Image.network(
                widget.orderModel.products[0].image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            widget.orderModel.products[0].name,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              Text(
                "Total Price: Rs ${widget.orderModel.totalPrice}",
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8.0),
              if (widget.orderModel.status == 'pending') ...[
                Text(
                  "Payment Status: ${widget.orderModel.payment}",
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            appProvider.updateUserOrder(
                                widget.orderModel, 'delivery');
                          });
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) =>
                                false, // This removes all previous routes from the stack
                          );
                        },
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: const Text(
                            'Send to Delivery',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CupertinoButton(
                        onPressed: () {
                          appProvider.updateUserOrder(
                              widget.orderModel, 'Canceled');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (Route<dynamic> route) =>
                                false, // This removes all previous routes from the stack
                          );
                        },
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Text(
                  "Status: ${widget.orderModel.status}",
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 8.0),
              if (widget.orderModel.products.length == 1) ...[
                Text(
                  "Quantity: ${widget.orderModel.products[0].qty}",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
                if (widget.orderModel.orderAddress != null) ...[
                  const SizedBox(height: 4.0),
                  Text(
                    "Order Address: ${widget.orderModel.orderAddress}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ],
          ),
          trailing: widget.orderModel.products.length > 1
              ? const Icon(Icons.arrow_drop_down, color: Colors.black54)
              : const SizedBox.shrink(),
          onTap: () async {
            UserModel? user = await fetchUserDetails(widget.orderModel.userId);
            if (user != null) {
              _showUserDetailsDialog(context, user);
            } else {
              // Handle case where user is not found
              print('User not found.');
            }
          },
        ),
      ),
    );
  }

  Future<UserModel?> fetchUserDetails(String userId) async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Convert Firestore data to UserModel
        return UserModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Handle error
      print('Error fetching user details: $e');
      return null;
    }
  }

  void _showUserDetailsDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(user.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user.image != null)
              ClipOval(
                child: Image.network(user.image!, height: 100),
              ),
            Text('Email: ${user.email}'),
            Text('Address: ${user.streetAddress}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
