import 'package:techtrove_admin/models/product_model.dart';

class OrderModel {
  OrderModel({
    required this.payment,
    required this.orderId,
    required this.status,
    required this.totalPrice,
    required this.products,
    required this.orderAddress,
  });

  String payment;
  String status;
  String orderId;
  List<ProductModel> products;
  double totalPrice;
  String orderAddress;

  factory OrderModel.fronJson(Map<String, dynamic> json) {
    List<dynamic> productMap = json["products"] ?? [];
    return OrderModel(
      orderAddress: json["orderAddress"] ?? "",
      orderId: json["orderId"] ?? "",
      products: productMap.map((e) => ProductModel.fronJson(e)).toList(),
      totalPrice: json["totalPrice"] ?? 0.0,
      status: json["status"] ?? "",
      payment: json["payment"] ?? "",
    );
  }
}
