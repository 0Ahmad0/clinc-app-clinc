import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_app_clinc/generated/locale_keys.g.dart';

import '../../controllers/reports_controller.dart';

class ReportSummaryGrid extends GetView<ReportsController> {
  const ReportSummaryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Obx(() {
      final s = controller.summary;

      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 1.7,
        children: [
          _StatCard(title: tr(LocaleKeys.reports_cards_total), value: s.total.toString()),
          _StatCard(title: tr(LocaleKeys.reports_cards_completed), value: s.completed.toString()),
          _StatCard(title: tr(LocaleKeys.reports_cards_pending), value: s.pending.toString()),
          _StatCard(title: tr(LocaleKeys.reports_cards_cancelled), value: s.cancelled.toString()),
        ],
      );
    });
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(color: cs.shadow.withOpacity(0.03), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800, color: cs.primary)),
          6.verticalSpace,
          Text(title, style: theme.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}