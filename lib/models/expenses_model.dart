import 'package:flutter/material.dart';

class Expense {
  final String title;
  final double? price;
  final Category category;
  final DateTime? date;
  String formatedPrice() {
    return "\$ ${price?.toStringAsFixed(2)}";
  }

  IconData? getCategoryIcon(Category category) {
    return categoryIcons[category];
  }

  Expense(
      {required this.title,
      required this.price,
      required this.category,
      required this.date});
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

enum Category { food, travel, leisure, work }
