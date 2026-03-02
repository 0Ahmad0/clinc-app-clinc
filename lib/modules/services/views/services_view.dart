import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ==========================================
// 1. Models (النماذج)
// ==========================================
class SubTestModel {
  final String id;
  final String code;
  final String title;
  final String subtitle;
  RxInt price;
  RxBool isSelected;

  SubTestModel(this.id, this.code, this.title, this.subtitle, int p, bool sel)
      : price = p.obs,
        isSelected = sel.obs;
}

class MainLabCategoryModel {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final List<SubTestModel> subTests;

  MainLabCategoryModel(this.id, this.title, this.icon, this.color, this.subTests);

  int get activeTestsCount => subTests.where((t) => t.isSelected.value).length;
}

class SpecialtyModel {
  final String id;
  final String title;
  final IconData icon;
  final Color color;

  SpecialtyModel(this.id, this.title, this.icon, this.color);
}

// ==========================================
// 2. Controller (متحكم GetX)
// ==========================================
class ServicesController extends GetxController {
  var currentTab = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
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

  // ----------------------------------------
  // بيانات التحاليل
  // ----------------------------------------
  final activeLabCategories = <MainLabCategoryModel>[].obs;

  final availableLabCategories = [
    MainLabCategoryModel("1", "الهرمونات", Icons.biotech, Colors.purpleAccent, [
      SubTestModel("11", "TSH", "فحص الغدة الدرقية", "نشاط الغدة الدرقية (Free T4)", 0, false),
      SubTestModel("12", "PRL", "هرمون الحليب", "Prolactin", 0, false),
      SubTestModel("13", "TEST", "هرمون الذكورة", "Testosterone", 0, false),
      SubTestModel("14", "FSH/LH", "هرمونات الخصوبة", "الخصوبة والتبويض", 0, false),
      SubTestModel("15", "INS", "هرمون الأنسولين", "تمثيل السكر", 0, false),
      SubTestModel("16", "CORT", "هرمون التوتر", "الغدة الكظرية (Cortisol)", 0, false),
    ]),
    MainLabCategoryModel("2", "فحص الزواج", Icons.favorite, Colors.pinkAccent, [
      SubTestModel("21", "SCD", "الأنيميا المنجلية", "فحص أمراض الدم الوراثية", 0, false),
      SubTestModel("22", "THAL", "الثلاسيميا", "فحص وراثي لخلايا الدم", 0, false),
      SubTestModel("23", "HBV", "التهاب الكبد B", "فحص الفيروسات المعدية", 0, false),
      SubTestModel("24", "HCV", "التهاب الكبد C", "فحص الفيروسات المعدية", 0, false),
      SubTestModel("25", "HIV", "نقص المناعة", "الإيدز", 0, false),
    ]),
    MainLabCategoryModel("3", "الفيتامينات", Icons.wb_sunny, Colors.orangeAccent, [
      SubTestModel("31", "VIT-D", "فيتامين د", "صحة العظام والمناعة", 0, false),
      SubTestModel("32", "VIT-B12", "فيتامين ب12", "صحة الأعصاب والنشاط الذهني", 0, false),
      SubTestModel("33", "FA", "حمض الفوليك", "نمو الخلايا وصحة الدم", 0, false),
      SubTestModel("34", "VIT-C", "فيتامين سي", "مضاد أكسدة ومناعة", 0, false),
    ]),
  ];

  List<MainLabCategoryModel> get unaddedLabCategories {
    return availableLabCategories
        .where((avail) => !activeLabCategories.any((active) => active.id == avail.id))
        .toList();
  }

  void addLabCategory(MainLabCategoryModel category) {
    if (!activeLabCategories.any((element) => element.id == category.id)) {
      activeLabCategories.add(category);
    }
  }

  // دالة حذف قسم تحاليل (مع تصفير البيانات)
  void removeLabCategory(MainLabCategoryModel category) {
    // تصفير التحاليل عشان لو رجع أضافها تكون جديدة
    for (var test in category.subTests) {
      test.isSelected.value = false;
      test.price.value = 0;
    }
    activeLabCategories.removeWhere((element) => element.id == category.id);
  }

  // ----------------------------------------
  // بيانات التخصصات
  // ----------------------------------------
  final activeSpecialties = <SpecialtyModel>[].obs;

  final availableSpecialties = [
    SpecialtyModel("1", "طب الأطفال", Icons.child_care, Colors.green),
    SpecialtyModel("2", "القلب والأوعية", Icons.monitor_heart, Colors.redAccent),
    SpecialtyModel("3", "العيون", Icons.visibility, Colors.blue),
    SpecialtyModel("4", "العظام", Icons.accessibility_new, Colors.brown),
    SpecialtyModel("5", "الباطنية", Icons.healing, Colors.teal),
  ];

  List<SpecialtyModel> get unaddedSpecialties {
    return availableSpecialties
        .where((avail) => !activeSpecialties.any((active) => active.id == avail.id))
        .toList();
  }

  void addSpecialty(SpecialtyModel specialty) {
    if (!activeSpecialties.any((element) => element.id == specialty.id)) {
      activeSpecialties.add(specialty);
    }
  }

  // دالة حذف تخصص
  void removeSpecialty(SpecialtyModel specialty) {
    activeSpecialties.removeWhere((element) => element.id == specialty.id);
  }
}

// ==========================================
// 3. Main View (الشاشة الرئيسية للتابات)
// ==========================================
class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("إدارة الخدمات", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Get.back()),
        ),
        body: Column(
          children: [
            _buildCustomTabBar(),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (index) => controller.currentTab.value = index,
                children: [
                  _buildLabsGrid(),
                  _buildSpecialtiesGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)),
      child: Obx(() => Row(
        children: [
          _buildTabItem(title: "التحاليل", index: 0),
          _buildTabItem(title: "التخصصات", index: 1),
        ],
      )),
    );
  }

  Widget _buildTabItem({required String title, required int index}) {
    bool isActive = controller.currentTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue.shade600 : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isActive ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: isActive ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }

  // --- شبكة التحاليل ---
  Widget _buildLabsGrid() {
    return Obx(() => GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.9,
      ),
      itemCount: controller.activeLabCategories.length + 1,
      itemBuilder: (context, index) {
        if (index == controller.activeLabCategories.length) {
          return _buildAddCustomCard("إضافة قسم تحاليل", () => _showAddLabBottomSheet(context));
        }
        final cat = controller.activeLabCategories[index];
        return Obx(() => _buildCard(
          title: cat.title,
          subtitle: "${cat.activeTestsCount} تحاليل مفعلة",
          icon: cat.icon,
          color: cat.color,
          onTap: () => Get.to(() => SubTestsView(category: cat)),
          onDelete: () => _confirmDeleteDialog(cat.title, () => controller.removeLabCategory(cat)),
        ));
      },
    ));
  }

  // --- شبكة التخصصات ---
  Widget _buildSpecialtiesGrid() {
    return Obx(() => GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.9,
      ),
      itemCount: controller.activeSpecialties.length + 1,
      itemBuilder: (context, index) {
        if (index == controller.activeSpecialties.length) {
          return _buildAddCustomCard("إضافة تخصص", () => _showAddSpecialtyBottomSheet(context));
        }
        final spec = controller.activeSpecialties[index];
        return _buildCard(
          title: spec.title,
          subtitle: "تخصص متاح",
          icon: spec.icon,
          color: spec.color,
          onTap: () {},
          onDelete: () => _confirmDeleteDialog(spec.title, () => controller.removeSpecialty(spec)),
        );
      },
    ));
  }

  // --- تصميم البطاقة (موحد ومحدث بحاضنة الحذف) ---
  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required VoidCallback onDelete, // دالة الحذف الجديدة
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // الكرت الأساسي
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.06), blurRadius: 15, spreadRadius: 2, offset: const Offset(0, 5))],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle), child: Icon(icon, color: color, size: 36)),
                const SizedBox(height: 14),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ),
              ],
            ),
          ),
          // زر الحذف العائم (فوق الكرت يساراً لأننا RTL)
          Positioned(
            top: 8,
            left: 8,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delete_outline, color: Colors.red, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- ديالوج تأكيد الحذف ---
  void _confirmDeleteDialog(String itemName, VoidCallback onConfirm) {
    Get.defaultDialog(
      title: "تأكيد الحذف",
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
      middleText: "هل أنت متأكد من حذف '$itemName'؟",
      middleTextStyle: const TextStyle(fontSize: 15),
      backgroundColor: Colors.white,
      radius: 16,
      textConfirm: "نعم، احذف",
      textCancel: "إلغاء",
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.red,
      onConfirm: () {
        onConfirm();
        Get.back(); // إغلاق الديالوج
        Get.snackbar(
            "تم الحذف",
            "تم حذف $itemName بنجاح",
            backgroundColor: Colors.redAccent,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(16)
        );
      },
    );
  }

  // --- زر الإضافة (+) ---
  Widget _buildAddCustomCard(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.shade200, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle), child: Icon(Icons.add, color: Colors.blue.shade600, size: 32)),
            const SizedBox(height: 12),
            Text(title, style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // --- Bottom Sheet لإضافة قسم تحاليل ---
  void _showAddLabBottomSheet(BuildContext context) {
    MainLabCategoryModel? selected;
    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        final options = controller.unaddedLabCategories;
        return _buildBottomSheetBase(
          title: "إضافة قسم تحاليل شامل",
          subtitle: "اختر القسم لإضافته وإدارة أسعار تحاليله.",
          isEmpty: options.isEmpty,
          dropdown: DropdownButtonHideUnderline(
            child: DropdownButton<MainLabCategoryModel>(
              isExpanded: true, hint: const Text("اختر قسم التحاليل..."), value: selected, icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
              items: options.map((cat) => DropdownMenuItem(value: cat, child: Row(children: [Icon(cat.icon, color: cat.color), const SizedBox(width: 12), Text(cat.title, style: const TextStyle(fontWeight: FontWeight.bold))]))).toList(),
              onChanged: (val) => setState(() => selected = val),
            ),
          ),
          onSave: selected == null ? null : () {
            controller.addLabCategory(selected!);
            Get.back();
            Get.snackbar("نجاح", "تم إضافة ${selected!.title}", backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.TOP, margin: const EdgeInsets.all(16));
          },
        );
      }),
    );
  }

  // --- Bottom Sheet لإضافة تخصص ---
  void _showAddSpecialtyBottomSheet(BuildContext context) {
    SpecialtyModel? selected;
    Get.bottomSheet(
      StatefulBuilder(builder: (context, setState) {
        final options = controller.unaddedSpecialties;
        return _buildBottomSheetBase(
          title: "إضافة تخصص جديد", subtitle: "اختر التخصص من القائمة لإضافته.", isEmpty: options.isEmpty,
          dropdown: DropdownButtonHideUnderline(
            child: DropdownButton<SpecialtyModel>(
              isExpanded: true, hint: const Text("اضغط لاختيار تخصص..."), value: selected, icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blue),
              items: options.map((spec) => DropdownMenuItem(value: spec, child: Row(children: [Icon(spec.icon, color: spec.color), const SizedBox(width: 12), Text(spec.title, style: const TextStyle(fontWeight: FontWeight.bold))]))).toList(),
              onChanged: (val) => setState(() => selected = val),
            ),
          ),
          onSave: selected == null ? null : () {
            controller.addSpecialty(selected!);
            Get.back();
            Get.snackbar("نجاح", "تم إضافة ${selected!.title}", backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.TOP, margin: const EdgeInsets.all(16));
          },
        );
      }),
    );
  }

  // هيكل موحد للـ Bottom Sheet
  Widget _buildBottomSheetBase({required String title, required String subtitle, required bool isEmpty, required Widget dropdown, required VoidCallback? onSave}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Column(
        mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)))),
          const SizedBox(height: 24),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8), Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
          const SizedBox(height: 24),
          if (isEmpty) Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)), child: const Row(children: [Icon(Icons.check_circle, color: Colors.green), SizedBox(width: 12), Expanded(child: Text("تم إضافة جميع العناصر المتاحة!", style: TextStyle(color: Colors.green)))]))
          else Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(16)), child: dropdown),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity, height: 55,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600, disabledBackgroundColor: Colors.grey.shade300, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: const Text("حفظ الإضافة", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ==========================================
// 4. Sub Tests View (شاشة التحاليل الفرعية للقسم)
// ==========================================
class SubTestsView extends StatelessWidget {
  final MainLabCategoryModel category;

  const SubTestsView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(category.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: true,
          leading: IconButton(icon: const Icon(Icons.arrow_forward, color: Colors.black), onPressed: () => Get.back()),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: category.subTests.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final test = category.subTests[index];
            return Obx(() => _buildTestItem(test));
          },
        ),
      ),
    );
  }

  Widget _buildTestItem(SubTestModel test) {
    bool isSelected = test.isSelected.value;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? Colors.blue.shade300 : Colors.grey.shade200, width: isSelected ? 1.5 : 1),
        boxShadow: isSelected ? [BoxShadow(color: Colors.blue.withOpacity(0.05), blurRadius: 10, spreadRadius: 2)] : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                  child: Text(test.code, style: TextStyle(color: Colors.blue.shade700, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 6),
                Text(test.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(test.subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 90, height: 35,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(right: 8.0), child: Text("ر.س", style: TextStyle(color: Colors.grey, fontSize: 12))),
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: test.price.value.toString()),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                        onChanged: (val) => test.price.value = int.tryParse(val) ?? 0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => test.isSelected.value = !test.isSelected.value,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: isSelected ? const Color(0xFF10B981) : Colors.blue.shade50, shape: BoxShape.circle),
                  child: Icon(isSelected ? Icons.check : Icons.add, color: isSelected ? Colors.white : Colors.blue.shade700, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
