import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../domain/doctor_summary.dart';

/// Gradient hero: back/edit buttons, avatar with a presence dot, name and the
/// specialty + rating chips.
class DoctorProfileHeader extends StatelessWidget {
  const DoctorProfileHeader({
    super.key,
    required this.doctor,
    required this.available,
    required this.onBack,
  });

  final DoctorSummary doctor;
  final bool available;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final rtl = Directionality.of(context) == TextDirection.rtl;
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );

    return Container(
      width: double.infinity,
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
            end: -AppSizes.homeHeaderCircleStart,
            child: const _Ring(size: AppSizes.homeHeaderCircleSmall),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              MediaQuery.paddingOf(context).top + AppSpacing.md,
              AppSpacing.screen,
              AppSpacing.xxl + AppSpacing.md,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CircleButton(
                      icon: rtl ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2,
                      onTap: onBack,
                    ),
                    Text(
                      context.l10n.doctorProfileTitle,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: colors.onBrand,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const _CircleButton(icon: Iconsax.edit_2),
                  ],
                ),
                AppGaps.h16,
                SizedBox(
                  width: AppSizes.addDoctorAvatar,
                  height: AppSizes.addDoctorAvatar,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.onBrand.withValues(alpha: 0.16),
                          border: Border.all(
                            color: colors.onBrand.withValues(alpha: 0.4),
                            width: 2.5,
                          ),
                        ),
                        child: AppAvatar(
                          size: AppSizes.addDoctorAvatar,
                          imageUrl: doctor.imageUrl,
                          fallback: Center(
                            child: Text(
                              doctor.initials,
                              style: context.textTheme.headlineMedium?.copyWith(
                                color: colors.onBrand,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: AppSpacing.xxs,
                        end: AppSpacing.xxs,
                        child: Container(
                          width: AppSizes.homeStatusDot + AppSpacing.xs,
                          height: AppSizes.homeStatusDot + AppSpacing.xs,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: available
                                ? colors.successBright
                                : colors.muted,
                            border: Border.all(
                              color: colors.primary600,
                              width: 2.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppGaps.h8,
                Text(
                  doctor.name,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: colors.onBrand,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppGaps.h8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs - 2,
                      ),
                      decoration: BoxDecoration(
                        color: colors.onBrand.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Text(
                        doctor.specialtyName,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.onBrand,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AppGaps.w8,
                    Container(
                      padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs - 2,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.star,
                            size: AppSizes.iconXs,
                            color: colors.warning,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          Text(
                            format.format(doctor.rating),
                            textDirection: TextDirection.ltr,
                            style: context.textTheme.labelSmall?.copyWith(
                              color: colors.warningFg,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: context.colors.onBrand.withValues(alpha: 0.12),
        width: 1.5,
      ),
    ),
  );
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.icon, this.onTap});

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
        child: SizedBox.square(
          dimension: AppSizes.hitTarget - 2,
          child: Icon(icon, color: colors.onBrand, size: AppSizes.iconMd),
        ),
      ),
    );
  }
}
