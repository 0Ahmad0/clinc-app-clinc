import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_avatar.dart';
import '../../../../shared/widgets/app_switch.dart';
import '../../data/models/clinic_doctor_model.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.doctor,
    required this.accent,
    required this.onToggle,
    required this.onTap,
  });

  final ClinicDoctorModel doctor;
  final Color accent;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final format = NumberFormat.decimalPattern(locale);
    final available = doctor.isActive;
    final name = doctor.name ?? doctor.nameAr ?? doctor.nameEn ?? '-';
    return Opacity(
      opacity: available ? 1 : 0.72,
      child: Material(
        color: colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: colors.line),
        ),
        shadowColor: AppShadows.homeCard.first.color,
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Container(
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            decoration: BoxDecoration(
              border: BorderDirectional(
                start: BorderSide(color: accent, width: 4),
              ),
            ),
            child: Row(
              children: [
                AppAvatar(
                  size: AppSizes.doctorAvatar,
                  imageUrl: doctor.imageUrl,
                  fallback: Container(
                    alignment: Alignment.center,
                    color: accent.withValues(alpha: 0.12),
                    child: Text(
                      name.characters.isEmpty ? '-' : name.characters.first,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                AppGaps.w12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.titleSmall?.copyWith(
                                color: colors.ink,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          AppGaps.w8,
                          Container(
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: AppSpacing.xs,
                              vertical: AppSpacing.xxs,
                            ),
                            decoration: BoxDecoration(
                              color: (available ? colors.success : colors.muted)
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(
                                AppRadius.pill,
                              ),
                            ),
                            child: Text(
                              available
                                  ? context.l10n.doctorAvailable
                                  : context.l10n.doctorUnavailable,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: available
                                    ? colors.successFg
                                    : colors.muted,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      AppGaps.h8,
                      Text(
                        doctor.specializationName ?? '-',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppGaps.h8,
                      Row(
                        children: [
                          Icon(
                            Iconsax.medal_star,
                            size: AppSizes.iconSm,
                            color: colors.warningFg,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          Text(
                            context.l10n.doctorExperience(
                              format.format(doctor.experienceYears),
                            ),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.gray,
                            ),
                          ),
                          AppGaps.w12,
                          Icon(
                            Iconsax.money,
                            size: AppSizes.iconSm,
                            color: colors.successFg,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          Text(
                            context.l10n.doctorFee(
                              format.format(doctor.consultationFee),
                            ),
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.successFg,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    AppSwitch(value: available, onChanged: onToggle),
                    AppGaps.h12,
                    Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Iconsax.arrow_left_2
                          : Iconsax.arrow_right_3,
                      size: AppSizes.iconSm,
                      color: colors.muted,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
