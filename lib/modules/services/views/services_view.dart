import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/services_controller.dart';
import '../models/clinic_service_model.dart';

// ===== نماذج البيانات (من الجديد) =====
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

  MainLabCategoryModel(
      this.id,
      this.title,
      this.icon,
      this.color,
      this.subTests,
      );

  int get activeTestsCount => subTests.where((t) => t.isSelected.value).length;
}

class SpecialtyModel {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final RxList<SpecialtyServiceModel> services;

  SpecialtyModel(
      this.id,
      this.title,
      this.icon,
      this.color, [
        List<SpecialtyServiceModel> initialServices = const [],
      ]) : services = initialServices.obs;

  int get servicesCount => services.length;
}

class SpecialtyServiceModel {
  final String id;
  final RxString name;
  final RxInt price;

  SpecialtyServiceModel({
    required this.id,
    required String name,
    required int price,
  }) : name = name.obs,
        price = price.obs;
}

// ===== الواجهة الرئيسية (مدمجة) =====
class ServicesView extends GetView<ServicesController> {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: cs.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [const Color(0xFF1E3A8A), const Color(0xFF1E1B4B)]
                      : [const Color(0xFF2563EB), const Color(0xFF1E1B4B)],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Icon(
                          Icons.medical_services_rounded,
                          color: Colors.white,
                          size: 26.sp,
                        ),
                      ),
                      14.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr('services_page.title'),
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Obx(() {
                              final activeLabs =
                                  controller.activeLabCategories.length;
                              final activeSpecs =
                                  controller.activeSpecialties.length;
                              return Text(
                                '${activeLabs + activeSpecs} خدمة نشطة',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      Obx(() {
                        final totalLabs =
                            controller.availableLabCategories.length;
                        final totalSpecs =
                            controller.availableSpecialties.length;
                        return Row(
                          children: [
                            _ServiceMiniStat(
                              count: totalLabs,
                              label: 'تحاليل',
                              theme: theme,
                            ),
                            8.horizontalSpace,
                            _ServiceMiniStat(
                              count: totalSpecs,
                              label: 'تخصصات',
                              theme: theme,
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            _buildTabBar(theme, cs),
            Expanded(
              child: Obx(
                    () => IndexedStack(
                  index: controller.currentTab.value,
                  children: [
                    _buildLabsGrid(context),
                    _buildSpecialtiesGrid(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== شريط التبويبات (جديد) =====
  Widget _buildTabBar(ThemeData theme, ColorScheme cs) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      padding: EdgeInsets.all(5.r),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Obx(
            () => Row(
          children: [
            _buildTabItem(
              theme,
              cs,
              title: tr('services_page.tabs.labs'),
              icon: Icons.biotech_rounded,
              index: 0,
            ),
            _buildTabItem(
              theme,
              cs,
              title: tr('services_page.tabs.specialties'),
              icon: Icons.local_hospital_rounded,
              index: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(
      ThemeData theme,
      ColorScheme cs, {
        required String title,
        required IconData icon,
        required int index,
      }) {
    final isActive = controller.currentTab.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 11.h),
          decoration: BoxDecoration(
            gradient: isActive
                ? const LinearGradient(
              colors: [Color(0xFF2563EB), Color(0xFF1E1B4B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isActive
                ? [
              BoxShadow(
                color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15.sp,
                color: isActive ? Colors.white : cs.onSurfaceVariant,
              ),
              5.horizontalSpace,
              Text(
                title,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isActive ? Colors.white : cs.onSurfaceVariant,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== شبكة التحاليل المخبرية (مدمجة مع ربط قديم) =====
  Widget _buildLabsGrid(BuildContext context) {
    return Obx(
          () => GridView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 14.h,
          childAspectRatio: 0.88,
        ),
        itemCount: controller.activeLabCategories.length + 1,
        itemBuilder: (context, index) {
          if (index == controller.activeLabCategories.length) {
            return _buildAddCard(
              'إضافة قسم تحاليل',
                  () => _showAddLabSheet(context),
            );
          }
          final cat = controller.activeLabCategories[index];
          return Obx(
                () => _buildServiceCard(
              title: cat.title,
              subtitle: '${cat.activeTestsCount} تحليل مفعل',
              icon: cat.icon,
              color: cat.color,
              onTap: () => Get.to(() => SubTestsView(category: cat)),
              onDelete: () => _confirmDelete(
                cat.title,
                    () => controller.removeLabCategory(cat),
              ),
            ),
          );
        },
      ),
    );
  }

  // ===== شبكة التخصصات الطبية (مدمجة مع ربط قديم) =====
  Widget _buildSpecialtiesGrid(BuildContext context) {
    return Obx(
          () => GridView.builder(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 14.h,
          childAspectRatio: 0.88,
        ),
        itemCount: controller.activeSpecialties.length + 1,
        itemBuilder: (context, index) {
          if (index == controller.activeSpecialties.length) {
            return _buildAddCard(
              'إضافة تخصص',
                  () => _showAddSpecialtySheet(context),
            );
          }
          final spec = controller.activeSpecialties[index];
          return Obx(
                () => _buildServiceCard(
              title: spec.title,
              subtitle: '${spec.servicesCount} خدمة',
              icon: spec.icon,
              color: spec.color,
              onTap: () => Get.to(() => SpecialtyServicesView(specialty: spec)),
              onDelete: () => _confirmDelete(
                spec.title,
                    () => controller.removeSpecialty(spec),
              ),
            ),
          );
        },
      ),
    );
  }

  // ===== بطاقة الخدمة (جديد) =====
  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: color.withValues(alpha: 0.12),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 58.r,
                  height: 58.r,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withValues(alpha: 0.15),
                        color.withValues(alpha: 0.08),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 28.sp),
                ),
                14.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14.sp,
                      color: const Color(0xFF1A1A2E),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                8.verticalSpace,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: color,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 8.r,
            left: 8.r,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 28.r,
                height: 28.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4444).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFF4444).withValues(alpha: 0.2),
                  ),
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: const Color(0xFFFF4444),
                  size: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== بطاقة الإضافة (جديد) =====
  Widget _buildAddCard(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: const Color(0xFF2563EB).withValues(alpha: 0.3),
            width: 2,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52.r,
              height: 52.r,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add_rounded,
                color: const Color(0xFF2563EB),
                size: 28.sp,
              ),
            ),
            14.verticalSpace,
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF2563EB),
                fontWeight: FontWeight.w700,
                fontSize: 13.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ===== دوال مساعدة (من الكود القديم) =====
  void _confirmDelete(String name, VoidCallback onConfirm) {
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

  void _showAddLabSheet(BuildContext context) {
    MainLabCategoryModel? selected;
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          final options = controller.unaddedLabCategories;
          return _buildBottomSheet(
            title: 'إضافة قسم تحاليل',
            subtitle: 'اختر القسم لإضافته وإدارة أسعار تحاليله',
            isEmpty: options.isEmpty,
            dropdown: DropdownButtonHideUnderline(
              child: DropdownButton<MainLabCategoryModel>(
                isExpanded: true,
                hint: const Text('اختر قسم التحاليل...'),
                value: selected,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF2563EB),
                ),
                items: options
                    .map(
                      (cat) => DropdownMenuItem(
                    value: cat,
                    child: Row(
                      children: [
                        Icon(cat.icon, color: cat.color, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          cat.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    .toList(),
                onChanged: (val) => setState(() => selected = val),
              ),
            ),
            onSave: selected == null
                ? null
                : () {
              controller.addLabCategory(selected!);
              Get.back();
              Get.snackbar(
                'تمت الإضافة',
                'تم إضافة ${selected!.title} بنجاح',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.r),
              );
            },
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  void _showAddSpecialtySheet(BuildContext context) {
    SpecialtyModel? selected;
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          final options = controller.unaddedSpecialties;
          return _buildBottomSheet(
            title: 'إضافة تخصص طبي',
            subtitle: 'اختر التخصص من القائمة لإضافته',
            isEmpty: options.isEmpty,
            dropdown: DropdownButtonHideUnderline(
              child: DropdownButton<SpecialtyModel>(
                isExpanded: true,
                hint: const Text('اضغط لاختيار تخصص...'),
                value: selected,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF2563EB),
                ),
                items: options
                    .map(
                      (spec) => DropdownMenuItem(
                    value: spec,
                    child: Row(
                      children: [
                        Icon(spec.icon, color: spec.color, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          spec.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                    .toList(),
                onChanged: (val) => setState(() => selected = val),
              ),
            ),
            onSave: selected == null
                ? null
                : () {
              controller.addSpecialty(selected!);
              Get.back();
              Get.snackbar(
                'تمت الإضافة',
                'تم إضافة ${selected!.title} بنجاح',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.r),
              );
            },
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildBottomSheet({
    required String title,
    required String subtitle,
    required bool isEmpty,
    required Widget dropdown,
    required VoidCallback? onSave,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          20.verticalSpace,
          Text(
            title,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800),
          ),
          8.verticalSpace,
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
          ),
          24.verticalSpace,
          if (isEmpty)
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF10B981),
                  ),
                  12.horizontalSpace,
                  const Expanded(
                    child: Text(
                      'تم إضافة جميع العناصر المتاحة!',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: dropdown,
            ),
          32.verticalSpace,
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                disabledBackgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'حفظ الإضافة',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== عرض التفاصيل الفرعية للتحاليل (جديد) =====
class SubTestsView extends StatelessWidget {
  final MainLabCategoryModel category;
  const SubTestsView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            expandedHeight: 130.h,
            backgroundColor: category.color,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      category.color,
                      category.color.withValues(alpha: 0.7),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            category.icon,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                        14.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              category.title,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              '${category.subTests.length} تحاليل متاحة',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              category.title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
        body: ListView.separated(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
          itemCount: category.subTests.length,
          separatorBuilder: (_, __) => 12.verticalSpace,
          itemBuilder: (context, index) {
            final test = category.subTests[index];
            return Obx(() => _buildTestItem(theme, test, isDark));
          },
        ),
      ),
    );
  }

  Widget _buildTestItem(ThemeData theme, SubTestModel test, bool isDark) {
    final isSelected = test.isSelected.value;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected
              ? category.color.withValues(alpha: 0.5)
              : Colors.grey.withValues(alpha: 0.15),
          width: isSelected ? 1.5 : 1,
        ),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: category.color.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ]
            : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: category.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    test.code,
                    style: TextStyle(
                      color: category.color,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                8.verticalSpace,
                Text(
                  test.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                  ),
                ),
                4.verticalSpace,
                Text(
                  test.subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
          16.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 90.w,
                height: 36.h,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Text(
                        'ر.س',
                        style: TextStyle(color: Colors.grey, fontSize: 11.sp),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(
                          text: test.price.value.toString(),
                        ),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        onChanged: (val) =>
                        test.price.value = int.tryParse(val) ?? 0,
                      ),
                    ),
                  ],
                ),
              ),
              12.verticalSpace,
              GestureDetector(
                onTap: () => test.isSelected.value = !test.isSelected.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 90.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: isSelected ? category.color : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      isSelected ? 'مفعّل ✓' : 'تفعيل',
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade600,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ===== عرض خدمات التخصص (جديد) =====
class SpecialtyServicesView extends GetView<ServicesController> {
  final SpecialtyModel specialty;

  const SpecialtyServicesView({super.key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddServiceSheet(context),
        backgroundColor: specialty.color,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('إضافة خدمة'),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            expandedHeight: 132.h,
            backgroundColor: specialty.color,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
            title: Text(
              specialty.title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      specialty.color,
                      specialty.color.withValues(alpha: 0.72),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                    child: Row(
                      children: [
                        Container(
                          width: 46.r,
                          height: 46.r,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            specialty.icon,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        14.horizontalSpace,
                        Expanded(
                          child: Obx(
                                () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  specialty.title,
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                4.verticalSpace,
                                Text(
                                  '${specialty.servicesCount} خدمات ضمن الاختصاص',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.82),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        body: Obx(() {
          final services = specialty.services;
          if (services.isEmpty) {
            return _SpecialtyEmptyState(
              color: specialty.color,
              onAdd: () => _showAddServiceSheet(context),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
            itemCount: services.length,
            separatorBuilder: (_, __) => 12.verticalSpace,
            itemBuilder: (context, index) {
              final service = services[index];
              return Obx(
                    () => _SpecialtyServiceTile(
                  service: service,
                  color: specialty.color,
                  onDelete: () =>
                      controller.removeSpecialtyService(specialty, service),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  void _showAddServiceSheet(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    Get.bottomSheet(
      Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                20.verticalSpace,
                Text(
                  'إضافة خدمة ضمن ${specialty.title}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                20.verticalSpace,
                TextFormField(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'اسم الخدمة',
                    hintText: 'مثال: فحص عيون',
                    prefixIcon: const Icon(Icons.medical_services_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  validator: (value) {
                    if ((value ?? '').trim().isEmpty) {
                      return 'ادخل اسم الخدمة';
                    }
                    return null;
                  },
                ),
                14.verticalSpace,
                TextFormField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'السعر',
                    hintText: 'مثال: 200',
                    prefixIcon: const Icon(Icons.payments_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  validator: (value) {
                    final price = int.tryParse((value ?? '').trim());
                    if (price == null || price <= 0) {
                      return 'ادخل سعر صحيح';
                    }
                    return null;
                  },
                ),
                24.verticalSpace,
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      controller.addSpecialtyService(
                        specialty,
                        name: nameController.text.trim(),
                        price: int.parse(priceController.text.trim()),
                      );
                      Get.back();
                      Get.snackbar(
                        'تمت الإضافة',
                        'تمت إضافة الخدمة بنجاح',
                        backgroundColor: const Color(0xFF10B981),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        margin: EdgeInsets.all(16.r),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: specialty.color,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(
                      'حفظ الخدمة',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    ).whenComplete(() {
      nameController.dispose();
      priceController.dispose();
    });
  }
}

// ===== ويدجت خدمة التخصص =====
class _SpecialtyServiceTile extends StatelessWidget {
  final SpecialtyServiceModel service;
  final Color color;
  final VoidCallback onDelete;

  const _SpecialtyServiceTile({
    required this.service,
    required this.color,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42.r,
            height: 42.r,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.medical_services_rounded,
              color: color,
              size: 20.sp,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name.value,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '${service.price.value} ل.س',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline_rounded),
            color: const Color(0xFFEF4444),
            tooltip: 'حذف',
          ),
        ],
      ),
    );
  }
}

// ===== حالة فارغة للتخصص =====
class _SpecialtyEmptyState extends StatelessWidget {
  final Color color;
  final VoidCallback onAdd;

  const _SpecialtyEmptyState({required this.color, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88.r,
              height: 88.r,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.playlist_add_rounded,
                color: color,
                size: 42.sp,
              ),
            ),
            18.verticalSpace,
            Text(
              'لا توجد خدمات ضمن هذا الاختصاص',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            8.verticalSpace,
            Text(
              'اضف اسم الخدمة وسعرها مثل فحص عيون بسعر 200',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            22.verticalSpace,
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_rounded),
              label: const Text('إضافة خدمة'),
              style: FilledButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== إحصائية صغيرة =====
class _ServiceMiniStat extends StatelessWidget {
  final int count;
  final String label;
  final ThemeData theme;

  const _ServiceMiniStat({
    required this.count,
    required this.label,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            '$count',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 9.sp,
            ),
          ),
        ],
      ),
    );
  }
}