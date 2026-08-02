import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

/// Gradient app bar for pushed detail screens: a back button that pops the
/// route, the page title and an optional supporting line under it.
class AppGradientHeader extends StatelessWidget {
  const AppGradientHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: colors.headerGradient,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.homeHeader),
        ),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: -AppSizes.doctorsHeaderCircleTop,
            end: -AppSizes.doctorsHeaderCircleEnd,
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
              MediaQuery.paddingOf(context).top + AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.lg,
            ),
            child: Row(
              children: [
                SizedBox.square(
                  dimension: AppSizes.hitTarget,
                  child: Material(
                    color: colors.onBrand.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(AppRadius.field),
                    child: InkWell(
                      onTap: context.pop,
                      borderRadius: BorderRadius.circular(AppRadius.field),
                      child: Icon(
                        rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                        color: colors.onBrand,
                        size: AppSizes.iconMd,
                      ),
                    ),
                  ),
                ),
                AppGaps.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: colors.onBrand,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: context.textTheme.labelSmall?.copyWith(
                            color: colors.onBrand.withValues(alpha: 0.72),
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
