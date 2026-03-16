import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app/data/report_model.dart';
import '../../../../generated/locale_keys.g.dart';

class ReportStatGrid extends StatelessWidget {
  final ReportModel report;
  const ReportStatGrid({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12.w,
      mainAxisSpacing: 12.h,
      childAspectRatio: 1.6,
      children: [
        _GridStatCard(
          value: '${report.total}',
          label: tr(LocaleKeys.reports_cards_total),
          icon: Icons.assessment_rounded,
          color: cs.primary,
        ),
        _GridStatCard(
          value: '${report.completed}',
          label: tr(LocaleKeys.reports_cards_completed),
          icon: Icons.check_circle_rounded,
          color: const Color(0xFF10B981),
        ),
        _GridStatCard(
          value: '${report.pending}',
          label: tr(LocaleKeys.reports_cards_pending),
          icon: Icons.hourglass_top_rounded,
          color: const Color(0xFFF59E0B),
        ),
        _GridStatCard(
          value: '${report.cancelled}',
          label: tr(LocaleKeys.reports_cards_cancelled),
          icon: Icons.cancel_rounded,
          color: const Color(0xFFEF4444),
        ),
      ],
    );
  }
}

class _GridStatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _GridStatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.15)
                : color.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: color, size: 18.sp),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: color,
                    height: 1,
                  ),
                ),
                4.verticalSpace,
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontSize: 10.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
