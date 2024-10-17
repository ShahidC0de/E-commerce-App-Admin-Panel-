// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.image,
    required this.id,
    required this.name,
    required this.email,
    required this.streetAddress,
  });

  String? image;
  String id;
  String name;
  String email;
  String streetAddress;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? '', // Handling null with default value
        image: json["image"],
        name: json["name"] ?? 'Unknown', // Default value for name
        email: json["email"] ?? '', // Default value for email
        streetAddress: json["streetAddress"] ?? '', // Default for streetAddress
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "streetAddress": streetAddress,
      };

  UserModel copyWith({
    String? name,
    image,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        email: email,
        image: image ?? this.image,
        streetAddress: streetAddress,
      );
}
