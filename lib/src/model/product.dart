import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String price;
  final String stock;
  final String productImage;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.stock,
      required this.productImage});
}
