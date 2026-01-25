import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';

import '../../../../app/data/report_model.dart';
import '../../controllers/reports_controller.dart';

class ReportFiltersWidget extends GetView<ReportsController> {
  const ReportFiltersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Type chips
        Obx(() {
          final selected = controller.selectedType.value;
          return Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: ReportType.values.map((t) {
              final isSelected = t == selected;
              return _Chip(
                title: tr(t.key()),
                selected: isSelected,
                onTap: () => controller.changeType(t),
              );
            }).toList(),
          );
        }),
        12.verticalSpace,

        // Range chips
        Obx(() {
          final selected = controller.selectedRange.value;
          return Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              for (final r in [ReportRange.today, ReportRange.week, ReportRange.month])
                _Chip(
                  title: tr(r.key()),
                  selected: r == selected,
                  onTap: () => controller.changeRange(r),
                ),
              _Chip(
                title: tr(ReportRange.custom.key()),
                selected: selected == ReportRange.custom,
                onTap: () async {
                  final now = DateTime.now();
                  final range = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(now.year - 1),
                    lastDate: DateTime(now.year + 1),
                    initialDateRange: DateTimeRange(
                      start: now.subtract(const Duration(days: 7)),
                      end: now,
                    ),
                  );
                  if (range != null) controller.setCustomRange(range);
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({required this.title, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? cs.primaryContainer : cs.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? cs.primaryContainer : cs.outlineVariant),
        ),
        child: Text(
          title,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}