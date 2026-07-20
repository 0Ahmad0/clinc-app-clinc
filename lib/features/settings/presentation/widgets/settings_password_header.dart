import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/settings_section.dart';
import '../cubit/settings_cubit.dart';

/// Gradient header for the change-password screen: back button, title and a
/// lock hero with a reassuring line.
class SettingsPasswordHeader extends StatelessWidget {
  const SettingsPasswordHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
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
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox.square(
                      dimension: AppSizes.hitTarget,
                      child: Material(
                        color: colors.onBrand.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(AppRadius.field),
                        child: InkWell(
                          onTap: () => context.read<SettingsCubit>().show(
                            SettingsSection.main,
                          ),
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
                    Text(
                      l10n.settingsPasswordTitle,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: colors.onBrand,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                AppGaps.h16,
                Container(
                  width: AppSizes.settingsPasswordHero,
                  height: AppSizes.settingsPasswordHero,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.onBrand.withValues(alpha: 0.14),
                    border: Border.all(
                      color: colors.onBrand.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    Iconsax.lock_1,
                    color: colors.onBrand,
                    size: AppSizes.iconLg + AppSpacing.xs,
                  ),
                ),
                AppGaps.h8,
                Text(
                  l10n.settingsPasswordHero,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.onBrand.withValues(alpha: 0.78),
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
