import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../app/data/report_model.dart';
import '../../../../generated/locale_keys.g.dart';
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
        // Type Filters
        Text(
          tr(LocaleKeys.reports_filters_type),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: cs.onSurfaceVariant,
          ),
        ),
        8.verticalSpace,
        Obx(() {
          final selected = controller.selectedType.value;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ReportType.values.map((t) {
                final isSelected = t == selected;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: _FilterChip(
                    title: tr(t.key()),
                    selected: isSelected,
                    onTap: () => controller.changeType(t),
                    color: _getTypeColor(t, cs),
                  ),
                );
              }).toList(),
            ),
          );
        }),
        16.verticalSpace,

        // Range Filters
        Text(
          tr(LocaleKeys.reports_filters_range),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: cs.onSurfaceVariant,
          ),
        ),
        8.verticalSpace,
        Obx(() {
          final selected = controller.selectedRange.value;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final r in [ReportRange.today, ReportRange.week, ReportRange.month])
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: _FilterChip(
                      title: tr(r.key()),
                      selected: r == selected,
                      onTap: () => controller.changeRange(r),
                    ),
                  ),
                _FilterChip(
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
            ),
          );
        }),
      ],
    );
  }

  Color _getTypeColor(ReportType type, ColorScheme cs) {
    switch (type) {
      case ReportType.appointments:
        return cs.primary;
      case ReportType.labResults:
        return cs.secondary;
      case ReportType.revenue:
        return Colors.green;
      case ReportType.doctors:
        return cs.tertiary;
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  const _FilterChip({
    required this.title,
    required this.selected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final chipColor = color ?? cs.primaryContainer;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? chipColor : cs.surface,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? chipColor.withOpacity(0.5) : cs.outlineVariant,
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color: chipColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
              : [],
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