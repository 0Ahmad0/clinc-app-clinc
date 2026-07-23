import 'package:flutter/material.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../data/models/clinic_report_model.dart';
import '../reports_l10n.dart';

class ReportEntryCard extends StatelessWidget {
  const ReportEntryCard({super.key, required this.report});

  final ClinicGeneratedReportModel report;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final format = report.format?.toUpperCase() ?? '-';
    final status = report.status ?? '-';

    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        border: BorderDirectional(
          top: BorderSide(color: colors.line),
          end: BorderSide(color: colors.line),
          bottom: BorderSide(color: colors.line),
          start: BorderSide(color: colors.primary600, width: 4),
        ),
        boxShadow: AppShadows.homeCard,
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.reportsEntryIcon,
            height: AppSizes.reportsEntryIcon,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary500.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.field),
            ),
            child: Icon(
              report.typeValue.icon,
              color: colors.primary600,
              size: AppSizes.iconMd,
            ),
          ),
          AppGaps.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.typeValue.label(context.l10n),
                  style: context.textTheme.titleSmall?.copyWith(
                    color: colors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  report.generatedAt ?? '-',
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.muted,
                  ),
                ),
              ],
            ),
          ),
          AppGaps.w8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Badge(text: format),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                status,
                style: context.textTheme.labelSmall?.copyWith(
                  color: colors.gray,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.xxs,
    ),
    decoration: BoxDecoration(
      color: context.colors.primary500.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(AppRadius.pill),
    ),
    child: Text(
      text,
      style: context.textTheme.labelSmall?.copyWith(
        color: context.colors.primary600,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
