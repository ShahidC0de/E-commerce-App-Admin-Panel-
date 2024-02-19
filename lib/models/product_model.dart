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
        id: json["id"].toString(),
        name: json["name"],
        categoryId: json["categoryId"] ?? "",
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
  ProductModel copyWith({
    String? name,
    String? image,
    String? id,
    String? categoryId,
    String? description,
    String? price,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        description: description ?? this.description,
        image: image ?? this.image,
        price: price != null ? double.parse(price) : this.price,
        qty: 1,
        isFavourate: false,
      );

  static fromJson(decode) {}
}
