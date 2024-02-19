import 'package:flutter/material.dart';
import 'package:techtrove_admin/models/order_model.dart';
import 'package:techtrove_admin/widgets/single_order_item.dart';

class OrderViewList extends StatelessWidget {
  final List<OrderModel> ordermodelList;
  final String title;
  const OrderViewList(
      {super.key, required this.ordermodelList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
        ),
        body: ListView.builder(
            itemCount: ordermodelList.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = ordermodelList[index];
              return SingleOrderWidget(orderModel: orderModel);
            }));
  }
}
