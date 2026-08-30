import 'package:flutter/material.dart';

class CoffeeItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final Color avatarColor;
  final String initials;
  bool isInCart;

  CoffeeItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.avatarColor,
    required this.initials,
    this.isInCart = false,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}
