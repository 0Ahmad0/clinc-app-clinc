import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import 'doctor_profile_section_title.dart';

/// Services & fees list. Amounts are illustrative until a live catalog exists.
class DoctorProfileServices extends StatelessWidget {
  const DoctorProfileServices({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    final services = <(IconData, String, int)>[
      (Iconsax.hospital, l10n.doctorProfileService1, 150),
      (Iconsax.message_text, l10n.doctorProfileService2, 100),
      (Iconsax.chart_21, l10n.doctorProfileService3, 120),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DoctorProfileSectionTitle(title: l10n.doctorProfileServices),
        for (final service in services)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              0,
              AppSpacing.screen,
              AppSpacing.sm,
            ),
            child: _ServiceRow(
              icon: service.$1,
              name: service.$2,
              price: l10n.doctorFee(format.format(service.$3)),
            ),
          ),
      ],
    );
  }
}

class _ServiceRow extends StatelessWidget {
  const _ServiceRow({
    required this.icon,
    required this.name,
    required this.price,
  });

  final IconData icon;
  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.sm + 1),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.field),
        border: Border.all(color: colors.line),
        boxShadow: AppShadows.homeCard,
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.reportsStatIcon,
            height: AppSizes.reportsStatIcon,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary500.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: AppSizes.iconSm, color: colors.primary600),
          ),
          AppGaps.w12,
          Expanded(
            child: Text(
              name,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs - 2,
            ),
            decoration: BoxDecoration(
              color: colors.primary500.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Text(
              price,
              style: context.textTheme.labelSmall?.copyWith(
                color: colors.primary600,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
