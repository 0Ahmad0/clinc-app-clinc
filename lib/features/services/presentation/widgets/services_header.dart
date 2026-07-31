import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../data/models/clinic_service_model.dart';
import '../../domain/service_kind.dart';
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
    required this.kind,
    required this.availableKinds,
    required this.isLoading,
    required this.onBack,
  });

  final ClinicLabSectionModel? detail;
  final int detailCount;
  final int labTotal;
  final int specTotal;
  final int activeCount;
  final ServiceKind kind;
  final List<ServiceKind> availableKinds;
  final bool isLoading;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    final inDetail = detail != null;
    final showLabStat =
        kind == ServiceKind.lab && availableKinds.contains(ServiceKind.lab);
    final showSpecialtyStat =
        kind == ServiceKind.specialty &&
        availableKinds.contains(ServiceKind.specialty);

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
                        inDetail ? detail!.label(context) : l10n.servicesTitle,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: colors.onBrand,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppGaps.h8,
                      isLoading
                          ? const _HeaderBlurShimmer(
                              width: 142,
                              height: 14,
                              borderRadius: AppRadius.pill,
                            )
                          : Text(
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
                    if (showLabStat)
                      (format.format(labTotal), l10n.servicesLabStat),
                    if (showSpecialtyStat)
                      (format.format(specTotal), l10n.servicesSpecialtyStat),
                  ])
                    _HeaderStat(
                      value: pill.$1,
                      label: pill.$2,
                      isLoading: isLoading,
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({
    required this.value,
    required this.label,
    required this.isLoading,
  });

  final String value;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsetsDirectional.only(start: AppSpacing.xs),
      constraints: const BoxConstraints(minWidth: 58, minHeight: 40),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs - 1,
      ),
      decoration: BoxDecoration(
        color: colors.onBrand.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 23,
            child: Center(
              child: isLoading
                  ? const _HeaderBlurShimmer(
                      width: 28,
                      height: 16,
                      borderRadius: AppRadius.pill,
                    )
                  : Text(
                      value,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: colors.onBrand,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.labelSmall?.copyWith(
              color: colors.onBrand.withValues(alpha: 0.7),
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBlurShimmer extends StatelessWidget {
  const _HeaderBlurShimmer({
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.onBrand.withValues(alpha: 0.13),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: colors.onBrand.withValues(alpha: 0.22),
              width: 0.7,
            ),
          ),
          child: Shimmer(
            
            duration: const Duration(milliseconds: 1150),
            interval: const Duration(milliseconds: 80),
            color: colors.primary300,
            colorOpacity: 0.38,
            direction: const ShimmerDirection.fromLTRB(),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                  colors: [
                    colors.onBrand.withValues(alpha: 0.18),
                    colors.onBrand.withValues(alpha: 0.34),
                    colors.onBrand.withValues(alpha: 0.18),
                  ],
                ),
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: colors.onBrand.withValues(alpha: 0.08),
                    blurRadius: 10,
                    spreadRadius: 0.4,
                  ),
                ],
              ),
            ),
          ),
        ),
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
