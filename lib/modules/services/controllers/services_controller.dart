import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../models/main_lab_category_model.dart';
import '../models/specialty_model.dart';
import '../models/sub_test_model.dart';

class ServicesController extends GetxController {
  // ── Navigation ─────────────────────────────────────────────────────────────

  final currentTab = 0.obs;
  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changeTab(int index) {
    currentTab.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // ── Lab Categories ──────────────────────────────────────────────────────────

  final activeLabCategories = <MainLabCategoryModel>[].obs;

  final availableLabCategories = [
    MainLabCategoryModel('1', 'الهرمونات', Icons.biotech, const Color(0xFF8B5CF6), [
      SubTestModel('11', 'TSH',    'فحص الغدة الدرقية', 'نشاط الغدة الدرقية (Free T4)', 0, false),
      SubTestModel('12', 'PRL',    'هرمون الحليب',       'Prolactin',                    0, false),
      SubTestModel('13', 'TEST',   'هرمون الذكورة',      'Testosterone',                 0, false),
      SubTestModel('14', 'FSH/LH', 'هرمونات الخصوبة',   'الخصوبة والتبويض',            0, false),
      SubTestModel('15', 'INS',    'هرمون الأنسولين',    'تمثيل السكر',                  0, false),
      SubTestModel('16', 'CORT',   'هرمون التوتر',       'الغدة الكظرية (Cortisol)',     0, false),
    ]),
    MainLabCategoryModel('2', 'فحص الزواج', Icons.favorite, const Color(0xFFEC4899), [
      SubTestModel('21', 'SCD',  'الأنيميا المنجلية', 'فحص أمراض الدم الوراثية', 0, false),
      SubTestModel('22', 'THAL', 'الثلاسيميا',         'فحص وراثي لخلايا الدم',  0, false),
      SubTestModel('23', 'HBV',  'التهاب الكبد B',     'فحص الفيروسات المعدية',  0, false),
      SubTestModel('24', 'HCV',  'التهاب الكبد C',     'فحص الفيروسات المعدية',  0, false),
      SubTestModel('25', 'HIV',  'نقص المناعة',         'الإيدز',                 0, false),
    ]),
    MainLabCategoryModel('3', 'الفيتامينات', Icons.wb_sunny, const Color(0xFFF59E0B), [
      SubTestModel('31', 'VIT-D',   'فيتامين د',   'صحة العظام والمناعة',         0, false),
      SubTestModel('32', 'VIT-B12', 'فيتامين ب12', 'صحة الأعصاب والنشاط الذهني', 0, false),
      SubTestModel('33', 'FA',      'حمض الفوليك', 'نمو الخلايا وصحة الدم',       0, false),
      SubTestModel('34', 'VIT-C',   'فيتامين سي',  'مضاد أكسدة ومناعة',          0, false),
    ]),
  ];

  List<MainLabCategoryModel> get unaddedLabCategories => availableLabCategories
      .where((a) => !activeLabCategories.any((b) => b.id == a.id))
      .toList();

  void addLabCategory(MainLabCategoryModel cat) {
    if (!activeLabCategories.any((e) => e.id == cat.id)) {
      activeLabCategories.add(cat);
    }
  }

  void removeLabCategory(MainLabCategoryModel cat) {
    for (final t in cat.subTests) {
      t.isSelected.value = false;
      t.price.value = 0;
    }
    activeLabCategories.removeWhere((e) => e.id == cat.id);
  }

  // ── Specialties ────────────────────────────────────────────────────────────

  final activeSpecialties = <SpecialtyModel>[].obs;

  final availableSpecialties = const [
    SpecialtyModel('1', 'طب الأطفال',      Icons.child_care,        Color(0xFF10B981)),
    SpecialtyModel('2', 'القلب والأوعية',  Icons.monitor_heart,     Color(0xFFEF4444)),
    SpecialtyModel('3', 'طب العيون',        Icons.visibility,        Color(0xFF3B82F6)),
    SpecialtyModel('4', 'العظام والمفاصل', Icons.accessibility_new,  Color(0xFFF59E0B)),
    SpecialtyModel('5', 'الباطنية',         Icons.healing,           Color(0xFF009688)),
  ];

  List<SpecialtyModel> get unaddedSpecialties => availableSpecialties
      .where((a) => !activeSpecialties.any((b) => b.id == a.id))
      .toList();

  void addSpecialty(SpecialtyModel spec) {
    if (!activeSpecialties.any((e) => e.id == spec.id)) {
      activeSpecialties.add(spec);
    }
  }

  void removeSpecialty(SpecialtyModel spec) =>
      activeSpecialties.removeWhere((e) => e.id == spec.id);

  // ── UX helpers ─────────────────────────────────────────────────────────────

  void confirmDelete(String name, VoidCallback onConfirm) {
    Get.defaultDialog(
      title: 'تأكيد الحذف',
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: const Color(0xFFEF4444),
        fontSize: 18.sp,
      ),
      middleText: 'هل أنت متأكد من حذف "$name"؟',
      backgroundColor: Colors.white,
      radius: 16,
      textConfirm: 'نعم، احذف',
      textCancel: 'إلغاء',
      confirmTextColor: Colors.white,
      buttonColor: const Color(0xFFEF4444),
      onConfirm: () {
        onConfirm();
        Get.back();
        Get.snackbar(
          'تم الحذف',
          'تم حذف $name بنجاح',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          margin: EdgeInsets.all(16.r),
          icon: const Icon(Icons.delete_rounded, color: Colors.white),
        );
      },
    );
  }
}
