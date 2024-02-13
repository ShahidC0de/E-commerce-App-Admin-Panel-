import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.isFavourate,
    required this.categoryId,
    this.qty,
  });

  String image;
  String id;
  String name;
  String categoryId;
  double price;
  String description;

  bool isFavourate;
  int? qty;

  factory ProductModel.fronJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        description: json["description"] ?? "",
        qty: json["qty"],
        image: json["image"] ?? "default_image_url",
        isFavourate: json["isFavourate"] ?? false,
        price: double.parse(json["price"].toString()),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categoryId": categoryId,
        "image": image,
        "description": description,
        "price": price,
        "isFavourate": isFavourate,
        "qty": qty,
      };

  static fromJson(decode) {}
}
