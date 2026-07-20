import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/report_type.dart';
import '../reports_catalog.dart';
import 'report_entry_card.dart';

/// "Reports list" section: a titled header with a count badge and the saved
/// report cards (each titled with the active report type).
class ReportsList extends StatelessWidget {
  const ReportsList({super.key, required this.type, required this.entries});

  final ReportType type;
  final List<ReportEntry> entries;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              Container(
                width: AppSizes.homeSectionMarkerWidth,
                height: AppSizes.homeSectionMarkerHeight,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [colors.primary500, colors.primary300],
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
              AppGaps.w8,
              Text(
                context.l10n.reportsListTitle,
                style: context.textTheme.titleMedium?.copyWith(
                  color: colors.ink,
                  fontWeight: FontWeight.w700,
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
                  format.format(entries.length),
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.primary600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (final entry in entries)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              0,
              AppSpacing.screen,
              AppSpacing.sm,
            ),
            child: ReportEntryCard(
              type: type,
              date: entry.$1,
              breakdown: entry.$2,
            ),
          ),
      ],
    );
  }
}
