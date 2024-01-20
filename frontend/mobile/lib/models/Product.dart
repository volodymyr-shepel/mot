import 'dart:ffi';

import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  double price;
  String imageUrl;

  String? sku;
  String? description;
  int? categoryId;
  int? quantity;
  DateTime? createdOn;
  DateTime? updatedOn;
  Map<String, dynamic>? specification;
  bool isFavourite = false;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.sku,
    this.description,
    this.categoryId,
    this.quantity,
    this.createdOn,
    this.updatedOn,
    this.specification,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        price: json['price'] is double
            ? json['price']
            : double.tryParse(json['price'].toString()) ?? 0.0,
        imageUrl: json['imageUrl'] ?? '',
        sku: json['sku'] ?? '',
        description: json['description'] ?? '',
        categoryId: json['categoryId'] is int
            ? json['categoryId']
            : int.tryParse(json['categoryId']?.toString() ?? '0') ?? 0,
        quantity: json['quantity'] is int
            ? json['quantity']
            : int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
        createdOn: json['createdOn'] != null
            ? DateTime.parse(json['createdOn'])
            : null,
        updatedOn: json['updatedOn'] != null
            ? DateTime.parse(json['updatedOn'])
            : null,
        specification: json['specification']);
  }
}


// Our demo Products

// List<Product> demoProducts = [
//   Product(
//     id: 1,
//     images: [
//       "assets/images/ps4_console_white_1.png",
//       "assets/images/ps4_console_white_2.png",
//       "assets/images/ps4_console_white_3.png",
//       "assets/images/ps4_console_white_4.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Wireless Controller for PS4™",
//     price: 64.99,
//     description: description,
//     rating: 4.8,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 2,
//     images: [
//       "assets/images/Image Popular Product 2.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Nike Sport White - Man Pant",
//     price: 50.5,
//     description: description,
//     rating: 4.1,
//     isPopular: true,
//   ),
//   Product(
//     id: 3,
//     images: [
//       "assets/images/glap.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Gloves XC Omega - Polygon",
//     price: 36.55,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//     isPopular: true,
//   ),
//   Product(
//     id: 4,
//     images: [
//       "assets/images/wireless headset.png",
//     ],
//     colors: [
//       Color(0xFFF6625E),
//       Color(0xFF836DB8),
//       Color(0xFFDECB9C),
//       Colors.white,
//     ],
//     title: "Logitech Head",
//     price: 20.20,
//     description: description,
//     rating: 4.1,
//     isFavourite: true,
//   ),
// ];

// const String description =
//     "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
