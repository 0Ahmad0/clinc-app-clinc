import 'package:flutter/material.dart';
import 'sub_test_model.dart';

class MainLabCategoryModel {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<SubTestModel> subTests;

  MainLabCategoryModel(this.id, this.title, this.icon, this.color, this.subTests);

  int get activeTestsCount => subTests.where((t) => t.isSelected.value).length;
}
