import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Gradient app bar shared by the about / privacy / contact screens: a back
/// button that pops the route and the page title.
class LegalHeader extends StatelessWidget {
  const LegalHeader({super.key, required this.title});

  final String title;

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
            top: -AppSizes.homeHeaderCircleTop,
            start: -AppSizes.homeHeaderCircleStart,
            child: Container(
              width: AppSizes.homeHeaderCircleSmall,
              height: AppSizes.homeHeaderCircleSmall,
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
                  child: Text(
                    title,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: colors.onBrand,
                      fontWeight: FontWeight.w700,
                    ),
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
