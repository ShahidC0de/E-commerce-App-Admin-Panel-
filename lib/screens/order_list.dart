import 'package:flutter/material.dart';
import 'package:techtrove_admin/models/order_model.dart';
import 'package:techtrove_admin/widgets/single_order_item.dart';

class OrderViewList extends StatefulWidget {
  final List<OrderModel> ordermodelList;
  final String title;
  const OrderViewList(
      {super.key, required this.ordermodelList, required this.title});

  @override
  State<OrderViewList> createState() => _OrderViewListState();
}

class _OrderViewListState extends State<OrderViewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: widget.ordermodelList.length,
            itemBuilder: (context, index) {
              OrderModel orderModel = widget.ordermodelList[index];
              return SingleOrderWidget(
                orderModel: orderModel,
              );
            }));
  }
}
