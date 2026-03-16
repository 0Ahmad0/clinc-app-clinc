import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../models/sub_test_model.dart';

/// Single test row: code badge + title/subtitle + price field + toggle button.
/// StatefulWidget owns the TextEditingController for performance (no re-create on rebuild).
class SubTestItem extends StatefulWidget {
  final SubTestModel test;
  final Color accentColor;

  const SubTestItem({super.key, required this.test, required this.accentColor});

  @override
  State<SubTestItem> createState() => _SubTestItemState();
}

class _SubTestItemState extends State<SubTestItem> {
  late final TextEditingController _priceCtrl;

  @override
  void initState() {
    super.initState();
    _priceCtrl = TextEditingController(text: widget.test.price.value.toString());
  }

  @override
  void dispose() {
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Obx(() {
      final isSelected = widget.test.isSelected.value;
      return Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? widget.accentColor.withValues(alpha: 0.5)
                : Colors.grey.withValues(alpha: 0.15),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: widget.accentColor.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            else
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
              child: _TestInfo(test: widget.test, accentColor: widget.accentColor),
            ),
            16.horizontalSpace,
            _TestControls(
              test: widget.test,
              priceCtrl: _priceCtrl,
              accentColor: widget.accentColor,
              isSelected: isSelected,
            ),
          ],
        ),
      );
    });
  }
}

// ── Private ───────────────────────────────────────────────────────────────────

class _TestInfo extends StatelessWidget {
  final SubTestModel test;
  final Color accentColor;
  const _TestInfo({required this.test, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: accentColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            test.code,
            style: TextStyle(color: accentColor, fontSize: 11.sp, fontWeight: FontWeight.w800),
          ),
        ),
        8.verticalSpace,
        Text(test.title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.sp)),
        4.verticalSpace,
        Text(test.subtitle, style: TextStyle(color: Colors.grey, fontSize: 12.sp)),
      ],
    );
  }
}

class _TestControls extends StatelessWidget {
  final SubTestModel test;
  final TextEditingController priceCtrl;
  final Color accentColor;
  final bool isSelected;

  const _TestControls({
    required this.test,
    required this.priceCtrl,
    required this.accentColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _PriceField(priceCtrl: priceCtrl, test: test),
        12.verticalSpace,
        _ToggleBtn(test: test, accentColor: accentColor, isSelected: isSelected),
      ],
    );
  }
}

class _PriceField extends StatelessWidget {
  final TextEditingController priceCtrl;
  final SubTestModel test;
  const _PriceField({required this.priceCtrl, required this.test});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text('ر.س', style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
          ),
          Expanded(
            child: TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(border: InputBorder.none, isDense: true),
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
              onChanged: (v) => test.price.value = int.tryParse(v) ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final SubTestModel test;
  final Color accentColor;
  final bool isSelected;
  const _ToggleBtn({required this.test, required this.accentColor, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => test.isSelected.value = !test.isSelected.value,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 90.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: isSelected ? accentColor : Colors.grey.shade100,
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
    );
  }
}
