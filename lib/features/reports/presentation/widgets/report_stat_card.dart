import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/report_outcome.dart';
import '../reports_l10n.dart';

/// One outcome stat: a tinted icon, the count and its label.
class ReportStatCard extends StatelessWidget {
  const ReportStatCard({
    super.key,
    required this.outcome,
    required this.value,
  });

  final ReportOutcome outcome;
  final int value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = outcome.textColor(colors);
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        border: Border.all(color: accent.withValues(alpha: 0.15), width: 1.5),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        children: [
          Container(
            width: AppSizes.reportsStatIcon,
            height: AppSizes.reportsStatIcon,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: outcome.barColor(colors).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(outcome.icon, color: accent, size: AppSizes.iconSm),
          ),
          AppGaps.h8,
          Text(
            format.format(value),
            style: context.textTheme.headlineSmall?.copyWith(
              color: accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            outcome.label(context.l10n),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(color: colors.gray),
          ),
        ],
      ),
    );
  }
}
