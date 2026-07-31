import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/report_breakdown.dart';
import '../../domain/report_outcome.dart';
import '../reports_l10n.dart';

/// Gradient screen header: chart glyph, title, a totals summary line and a
/// single "pending" stat pill.
class ReportsHeader extends StatelessWidget {
  const ReportsHeader({
    super.key,
    required this.totals,
    required this.isLoading,
  });

  final ReportBreakdown totals;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );

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
                  color: colors.onBrand.withValues(alpha: 0.12),
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
                Container(
                  width: AppSizes.doctorsHeaderIcon,
                  height: AppSizes.doctorsHeaderIcon,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.onBrand.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(AppRadius.field),
                  ),
                  child: Icon(
                    Iconsax.chart_2,
                    color: colors.onBrand,
                    size: AppSizes.iconLg,
                  ),
                ),
                AppGaps.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.reportsTitle,
                        style: context.textTheme.titleLarge?.copyWith(
                          color: colors.onBrand,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      AppGaps.h8,
                      isLoading
                          ? const _HeaderBlurShimmer(
                              width: 148,
                              height: 14,
                              borderRadius: AppRadius.pill,
                            )
                          : Text(
                              l10n.reportsHeaderLine(
                                format.format(totals.total),
                                format.format(totals.done),
                              ),
                              style: context.textTheme.bodySmall?.copyWith(
                                color: colors.onBrand.withValues(alpha: 0.72),
                              ),
                            ),
                    ],
                  ),
                ),
                Container(
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
                                  format.format(totals.pending),
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                        color: colors.onBrand,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                        ),
                      ),
                      Text(
                        ReportOutcome.pending.shortLabel(l10n),
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
