import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/doctor_summary.dart';

/// Three-across stat row (experience / patients / rating) that overlaps the
/// hero's lower edge.
class DoctorProfileStats extends StatelessWidget {
  const DoctorProfileStats({super.key, required this.doctor});

  final DoctorSummary doctor;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    final items = <(String, String)>[
      ('${format.format(doctor.experienceYears)}+', l10n.doctorProfileYearsExp),
      ('${format.format(doctor.patients)}+', l10n.doctorProfilePatients),
      (format.format(doctor.rating), l10n.doctorProfileRating),
    ];

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.screen,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in items)
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: item == items.last ? 0 : AppSpacing.xs,
                ),
                child: _StatCard(value: item.$1, label: item.$2),
              ),
            ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        border: Border.all(color: colors.line),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        children: [
          Text(
            value,
            textDirection: TextDirection.ltr,
            style: context.textTheme.titleLarge?.copyWith(
              color: colors.primary600,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(color: colors.gray),
          ),
        ],
      ),
    );
  }
}
