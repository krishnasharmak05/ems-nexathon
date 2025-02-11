import 'package:flutter/material.dart';

class IconModels {
  final int id;
  final String name;
  final IconData icon;
  final Color color;

  IconModels({required this.id, required this.name, required this.icon, required this.color});

  // factory IconModels.fromJson(Map<String, dynamic> json) {
  //   return IconModels(
  //     name: json['name'],
  //     icon: json['icon'],
  //     color: json['color'],
  //   );
  // }
}