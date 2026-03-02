import 'package:flutter/material.dart';

class ServiceModel {
  String id;
  String name;
  String category;
  bool isAvailable;
  String notes;
  double price;

  ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    this.isAvailable = true,
    this.notes = '',
    this.price = 0.0,
  });
}

// 2. مودل التخصص (قلبية، جلدية...)
class SpecialtyModel {
  String id;
  String name;
  int colorValue;
  int iconCode;
  String notes;

  SpecialtyModel({
    required this.id,
    required this.name,
    required this.colorValue,
    required this.iconCode,
    this.notes = '',
  });

  Color get color => Color(colorValue);

  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');
}
