import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/lab_section.dart';
import '../services_l10n.dart';

/// Gradient screen header. In list mode it shows a briefcase, the title and two
/// stat pills; in a section's detail view it swaps in a back button.
class ServicesHeader extends StatelessWidget {
  const ServicesHeader({
    super.key,
    required this.detail,
    required this.detailCount,
    required this.labTotal,
    required this.specTotal,
    required this.activeCount,
    required this.onBack,
  });

  final LabSection? detail;
  final int detailCount;
  final int labTotal;
  final int specTotal;
  final int activeCount;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    final inDetail = detail != null;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: colors.headerGradient,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.card),
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: -AppSizes.doctorsHeaderCircleTop,
            start: -AppSizes.doctorsHeaderCircleEnd,
            child: Container(
              width: AppSizes.doctorsHeaderCircle,
              height: AppSizes.doctorsHeaderCircle,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.onBrand.withValues(alpha: 0.1),
                  width: 1.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              MediaQuery.paddingOf(context).top + AppSpacing.lg,
              AppSpacing.screen,
              AppSpacing.lg,
            ),
            child: Row(
              children: [
                if (inDetail)
                  _HeaderLeading(
                    icon: Directionality.of(context) == TextDirection.rtl
                        ? Iconsax.arrow_right_3
                        : Iconsax.arrow_left_2,
                    onTap: onBack,
                  )
                else
                  const _HeaderLeading(icon: Iconsax.briefcase),
                AppGaps.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        inDetail ? detail!.label(l10n) : l10n.servicesTitle,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: colors.onBrand,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppGaps.h8,
                      Text(
                        inDetail
                            ? l10n.servicesTestsAvailable(
                                format.format(detailCount),
                              )
                            : l10n.servicesActiveLine(
                                format.format(activeCount),
                              ),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.onBrand.withValues(alpha: 0.72),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!inDetail)
                  for (final pill in [
                    (format.format(labTotal), l10n.servicesLabStat),
                    (format.format(specTotal), l10n.servicesSpecialtyStat),
                  ])
                    Container(
                      margin: const EdgeInsetsDirectional.only(
                        start: AppSpacing.xs,
                      ),
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: colors.onBrand.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Column(
                        children: [
                          Text(
                            pill.$1,
                            style: context.textTheme.titleMedium?.copyWith(
                              color: colors.onBrand,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            pill.$2,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.onBrand.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Leading square in the header — a tappable back button or a static glyph.
class _HeaderLeading extends StatelessWidget {
  const _HeaderLeading({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.onBrand.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(AppRadius.field),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.field),
        child: SizedBox(
          width: AppSizes.doctorsHeaderIcon,
          height: AppSizes.doctorsHeaderIcon,
          child: Icon(icon, color: colors.onBrand, size: AppSizes.iconLg),
        ),
      ),
    );
  }
}
