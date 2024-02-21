// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:techtrove_admin/models/order_model.dart';

class SingleOrderWidget extends StatelessWidget {
  final OrderModel orderModel;
  const SingleOrderWidget({super.key, required this.orderModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          collapsedShape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent, width: 2.3)),
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.lightBlueAccent, width: 2.3)),
          title: Row(
            children: [
              //the image part of item in listview.

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.white.withOpacity(0.5),
                    child: Image.network(orderModel.products[0].image)),
              ),
              //the rest space of listview.
              Expanded(
                flex: 2,
                child: FittedBox(
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderModel.products[0].name,
                            style: const TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "Rs: ${orderModel.totalPrice.toString()}",
                            style: const TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          Text(
                            "Status: ${orderModel.status}",
                            style: const TextStyle(
                              color: Colors.lightBlueAccent,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 2.0,
                          ),
                          orderModel.products.length > 1
                              ? SizedBox.fromSize()
                              : Column(
                                  children: [
                                    Text(
                                      "Quantity: ${orderModel.products[0].qty.toString()}",
                                      style: const TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 12,
                                      ),
                                    ),
                                    orderModel.orderAddress != null
                                        ? Text(
                                            "OrderAddress: ${orderModel.orderAddress}",
                                            style: const TextStyle(
                                              color: Colors.lightBlueAccent,
                                              fontSize: 12,
                                            ),
                                          )
                                        : SizedBox.fromSize(),
                                  ],
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          children: orderModel.products.length > 1
              ? [
                  const Text("Order Details"),
                  const Divider(
                    color: Colors.lightBlueAccent,
                  ),
                  ...orderModel.products.map((singleProduct) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              //the image part of item in listview.

                              Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.white.withOpacity(0.5),
                                  child: Image.network(singleProduct.image)),
                              //the rest space of listview.
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  color: Colors.white.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          singleProduct.name,
                                          style: const TextStyle(
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        Text(
                                          "Rs: ${singleProduct.price.toString()}",
                                          style: const TextStyle(
                                            color: Colors.lightBlueAccent,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 2.0,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Quantity: ${singleProduct.qty.toString()}",
                                              style: const TextStyle(
                                                color: Colors.lightBlueAccent,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList()
                ]
              : []),
    );
  }
}
