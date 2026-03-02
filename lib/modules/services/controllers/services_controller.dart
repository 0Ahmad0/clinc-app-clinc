// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// // --- Models ---
// class CategoryModel {
//   final String title;
//   final String testsCount;
//   final IconData icon;
//   final Color color;
//
//   CategoryModel(this.title, this.testsCount, this.icon, this.color);
// }
//
// class TestItemModel {
//   final String code;
//   final String titleAr;
//   final String titleEn;
//   int price;
//   bool isSelected;
//
//   TestItemModel(this.code, this.titleAr, this.titleEn, this.price, this.isSelected);
// }
//
// // --- Controller ---
// class ServicesController extends GetxController {
//   // بيانات الشاشة الأولى (الأقسام)
//   final categories = [
//     CategoryModel("أمراض الدم", "٢٤ تحليل", Icons.water_drop, Colors.redAccent),
//     CategoryModel("الكيمياء الحيوية", "١٨ تحليل", Icons.science, Colors.blue),
//     CategoryModel("الهرمونات", "١٢ تحليل", Icons.biotech, Colors.purpleAccent),
//     CategoryModel("المناعة", "٩ تحاليل", Icons.coronavirus, Colors.teal),
//     CategoryModel("الميكروبيولوجي", "٣٠ تحليل", Icons.mic_none_rounded, Colors.orange),
//     CategoryModel("تحليل البول", "٥ تحاليل", Icons.water, Colors.amber),
//     CategoryModel("باثولوجي", "١١ تحليل", Icons.folder_special, Colors.pinkAccent),
//   ];
//
//   // بيانات الشاشة الثانية (التحاليل)
//   final tests = <TestItemModel>[
//     TestItemModel("CBC", "صورة دم كاملة", "Complete Blood Count", 50, true),
//     TestItemModel("LFT", "وظائف كبد", "Liver Function Tests", 0, false),
//     TestItemModel("KFT", "وظائف كلى", "Kidney Function Tests", 0, false),
//     TestItemModel("TFT", "وظائف غدة درقية", "Thyroid Function Tests", 120, true),
//     TestItemModel("BS", "سكر دم", "Blood Sugar", 0, false),
//   ].obs;
//
//   // دوال الشاشة الثانية
//   int get selectedTestsCount => tests.where((t) => t.isSelected).length;
//
//   void toggleTest(int index) {
//     tests[index].isSelected = !tests[index].isSelected;
//     tests.refresh();
//   }
//
//   void updatePrice(int index, String val) {
//     tests[index].price = int.tryParse(val) ?? 0;
//   }
// }