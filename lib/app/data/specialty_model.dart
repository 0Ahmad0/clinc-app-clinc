import 'package:flutter/material.dart';

class SpecialtyModel {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  SpecialtyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.color = Colors.blue,
  });
}