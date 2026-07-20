import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/report_breakdown.dart';
import '../../domain/report_outcome.dart';
import '../../domain/report_type.dart';
import '../reports_l10n.dart';

/// One saved report: title (the active type), issue date, an outcome ratio bar
/// and the per-outcome counts with a total badge.
class ReportEntryCard extends StatelessWidget {
  const ReportEntryCard({
    super.key,
    required this.type,
    required this.date,
    required this.breakdown,
  });

  final ReportType type;
  final String date;
  final ReportBreakdown breakdown;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  Iconsax.calendar,
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
                      type.label(l10n),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      date,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.muted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Directionality.of(context) == TextDirection.rtl
                    ? Iconsax.arrow_left_2
                    : Iconsax.arrow_right_3,
                size: AppSizes.iconSm,
                color: colors.muted.withValues(alpha: 0.6),
              ),
            ],
          ),
          AppGaps.h12,
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: SizedBox(
              height: AppSizes.reportsProgressBar,
              child: Row(
                children: [
                  for (final outcome in ReportOutcome.values)
                    Expanded(
                      flex: breakdown.count(outcome),
                      child: ColoredBox(color: outcome.barColor(colors)),
                    ),
                ],
              ),
            ),
          ),
          AppGaps.h12,
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.xxs,
                  children: [
                    for (final outcome in ReportOutcome.values)
                      _CountLabel(
                        color: outcome.barColor(colors),
                        text: l10n.reportsCountLabel(
                          format.format(breakdown.count(outcome)),
                          outcome.label(l10n),
                        ),
                      ),
                  ],
                ),
              ),
              AppGaps.w8,
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: colors.primary500.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  l10n.reportsTotalLabel(format.format(breakdown.total)),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.primary600,
                    fontWeight: FontWeight.w700,
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

class _CountLabel extends StatelessWidget {
  const _CountLabel({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: AppSizes.iconXs / 2,
        height: AppSizes.iconXs / 2,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: AppSpacing.xxs),
      Text(
        text,
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colors.gray,
        ),
      ),
    ],
  );
}
