import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/services_controller.dart';
import '../../models/main_lab_category_model.dart';
import '../../models/specialty_model.dart';

const _kBlue  = Color(0xFF2563EB);
const _kGreen = Color(0xFF10B981);

// ── Add Lab Sheet ─────────────────────────────────────────────────────────────

class AddLabSheet extends StatefulWidget {
  const AddLabSheet({super.key});

  @override
  State<AddLabSheet> createState() => _AddLabSheetState();
}

class _AddLabSheetState extends State<AddLabSheet> {
  final _ctrl = Get.find<ServicesController>();
  MainLabCategoryModel? _selected;

  @override
  Widget build(BuildContext context) {
    final options = _ctrl.unaddedLabCategories;
    return _SheetContent(
      title: 'إضافة قسم تحاليل',
      subtitle: 'اختر القسم لإضافته وإدارة أسعار تحاليله',
      isEmpty: options.isEmpty,
      dropdown: _SheetDropdown<MainLabCategoryModel>(
        hint: 'اختر قسم التحاليل...',
        value: _selected,
        items: options,
        iconOf: (e) => e.icon,
        colorOf: (e) => e.color,
        labelOf: (e) => e.title,
        onChanged: (v) => setState(() => _selected = v),
      ),
      onSave: _selected == null
          ? null
          : () {
              _ctrl.addLabCategory(_selected!);
              Get.back();
              Get.snackbar(
                'تمت الإضافة',
                'تم إضافة ${_selected!.title} بنجاح',
                backgroundColor: _kGreen,
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.r),
              );
            },
    );
  }
}

// ── Add Specialty Sheet ───────────────────────────────────────────────────────

class AddSpecialtySheet extends StatefulWidget {
  const AddSpecialtySheet({super.key});

  @override
  State<AddSpecialtySheet> createState() => _AddSpecialtySheetState();
}

class _AddSpecialtySheetState extends State<AddSpecialtySheet> {
  final _ctrl = Get.find<ServicesController>();
  SpecialtyModel? _selected;

  @override
  Widget build(BuildContext context) {
    final options = _ctrl.unaddedSpecialties;
    return _SheetContent(
      title: 'إضافة تخصص طبي',
      subtitle: 'اختر التخصص من القائمة لإضافته',
      isEmpty: options.isEmpty,
      dropdown: _SheetDropdown<SpecialtyModel>(
        hint: 'اضغط لاختيار تخصص...',
        value: _selected,
        items: options,
        iconOf: (e) => e.icon,
        colorOf: (e) => e.color,
        labelOf: (e) => e.title,
        onChanged: (v) => setState(() => _selected = v),
      ),
      onSave: _selected == null
          ? null
          : () {
              _ctrl.addSpecialty(_selected!);
              Get.back();
              Get.snackbar(
                'تمت الإضافة',
                'تم إضافة ${_selected!.title} بنجاح',
                backgroundColor: _kGreen,
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.all(16.r),
              );
            },
    );
  }
}

// ── Shared Sheet Layout ───────────────────────────────────────────────────────

class _SheetContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isEmpty;
  final Widget dropdown;
  final VoidCallback? onSave;

  const _SheetContent({
    required this.title,
    required this.subtitle,
    required this.isEmpty,
    required this.dropdown,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
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
          Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w800)),
          8.verticalSpace,
          Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp)),
          24.verticalSpace,
          isEmpty ? const _AllAddedBanner() : _DropdownBox(child: dropdown),
          32.verticalSpace,
          _SaveButton(onSave: onSave),
        ],
      ),
    );
  }
}

class _AllAddedBanner extends StatelessWidget {
  const _AllAddedBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: _kGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded, color: _kGreen),
          12.horizontalSpace,
          const Expanded(
            child: Text(
              'تم إضافة جميع العناصر المتاحة!',
              style: TextStyle(color: _kGreen, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownBox extends StatelessWidget {
  final Widget child;
  const _DropdownBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: child,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback? onSave;
  const _SaveButton({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: _kBlue,
          disabledBackgroundColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
          elevation: 0,
        ),
        child: Text(
          'حفظ الإضافة',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
    );
  }
}

// ── Generic Dropdown ──────────────────────────────────────────────────────────

class _SheetDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final List<T> items;
  final IconData Function(T) iconOf;
  final Color Function(T) colorOf;
  final String Function(T) labelOf;
  final ValueChanged<T?> onChanged;

  const _SheetDropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.iconOf,
    required this.colorOf,
    required this.labelOf,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        isExpanded: true,
        hint: Text(hint),
        value: value,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: _kBlue),
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(iconOf(item), color: colorOf(item), size: 20),
                      const SizedBox(width: 12),
                      Text(labelOf(item), style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
