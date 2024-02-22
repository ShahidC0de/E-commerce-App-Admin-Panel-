// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtrove_admin/models/order_model.dart';
import 'package:techtrove_admin/provider/app_provider.dart';

class SingleOrderWidget extends StatelessWidget {
  final OrderModel orderModel;

  const SingleOrderWidget({Key? key, required this.orderModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          leading: Container(
            width: 120,
            height: 140,
            color: Colors.grey.withOpacity(0.5),
            child: Image.network(
              orderModel.products[0].image,
              height: 100,
              width: 100,
            ),
          ),
          title: Text(
            orderModel.products[0].name,
            style: const TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              Text(
                "Total Price: Rs ${orderModel.totalPrice}",
                style: const TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 14,
                ),
              ),
              orderModel.status == 'pending'
                  ? Column(
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            appProvider.updateUserOrder(orderModel, 'delivery');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            height: 20,
                            width: 135,
                            child: const Text(
                              'Send to Delievery',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () {
                            appProvider.updateUserOrder(orderModel, 'Canceled');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(8)),
                            height: 20,
                            width: 135,
                            child: const Text(
                              '         Cancel',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Text(
                      "Status: ${orderModel.status}",
                      style: const TextStyle(
                        color: Colors.lightBlueAccent,
                        fontSize: 14,
                      ),
                    ),
              if (orderModel.products.length == 1) ...[
                const SizedBox(height: 4.0),
                Text(
                  "Quantity: ${orderModel.products[0].qty}",
                  style: const TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 14,
                  ),
                ),
                if (orderModel.orderAddress != null) ...[
                  const SizedBox(height: 4.0),
                  Text(
                    "Order Address: ${orderModel.orderAddress}",
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ],
          ),
          trailing: orderModel.products.length > 1
              ? const Icon(Icons.arrow_drop_down)
              : const SizedBox.shrink(),
          onTap: () {
            // Handle onTap if needed
          },
        ),
      ),
    );
  }
}
