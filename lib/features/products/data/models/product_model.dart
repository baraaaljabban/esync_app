import 'dart:convert';

import 'package:esync_app/features/products/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  final int id;
  final int price;
  final String name;
  final String imageUrl;

  ProductModel({
    required this.id,
    required this.price,
    required this.name,
    required this.imageUrl,
  }) : super(
          id: id,
          imageUrl: imageUrl,
          name: name,
          price: price,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'price': price,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      price: map['price']?.toInt() ?? 0,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}

class ProductListModel {
  ProductListModel({
    required this.products,
  });

  final List<ProductModel> products;

  factory ProductListModel.fromRawJson(String str) => ProductListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
        products: List<ProductModel>.from(json["items"].map((x) => ProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(products.map((x) => x.toJson() )),
      };
}
