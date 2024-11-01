import 'package:flutter/material.dart';

class PieData {
  final String name;
  final double percent;
  final Color color;
  final int price;

  const PieData({
    required this.name,
    required this.percent,
    required this.color,
    required this.price,
  });
}
