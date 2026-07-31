import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_shimmer_placeholder.dart';
import '../../../../shared/widgets/specialization_visual.dart';
import '../../data/models/clinic_specialization_model.dart';
import '../cubit/add_doctor_cubit.dart';

/// Specialty field that expands into an inline option list.
class AddDoctorSpecialtyPicker extends StatelessWidget {
  const AddDoctorSpecialtyPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final cubit = context.read<AddDoctorCubit>();
    return BlocBuilder<AddDoctorCubit, AddDoctorState>(
      builder: (context, state) {
        final selected = state.selectedSpecialization;
        final specializations = state.specializations;
        final selectedAccent = SpecializationVisual.color(
          selected?.color,
          colors.primary500,
        );
        return Column(
          children: [
            GestureDetector(
              onTap: cubit.toggleSpecialtyPicker,
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: AppSizes.addDoctorFieldHeight,
                ),
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: colors.bg,
                  borderRadius: BorderRadius.circular(AppRadius.field),
                  border: Border.all(
                    color: colors.ink.withValues(alpha: 0.08),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    selected == null
                        ? Icon(
                            Iconsax.add,
                            size: AppSizes.iconSm,
                            color: colors.primary500,
                          )
                        : SpecializationIconView(
                            value: selected.icon,
                            color: selectedAccent,
                            size: AppSizes.iconSm,
                          ),
                    AppGaps.w8,
                    Expanded(
                      child: Text(
                        selected == null
                            ? l10n.addDoctorSpecialtyPlaceholder
                            : _label(context, selected),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: selected == null ? colors.muted : colors.ink,
                          fontWeight: selected == null
                              ? FontWeight.w400
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      duration: AppMotion.quick,
                      turns: state.specialtyOpen ? 0.5 : 0,
                      child: Icon(
                        Iconsax.arrow_down_1,
                        size: AppSizes.iconSm,
                        color: colors.gray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.isLoadingSpecializations) ...[
              AppGaps.h8,
              const _SpecialtyLoadingHint(),
            ],
            if (state.specialtyOpen) ...[
              AppGaps.h8,
              Container(
                padding: const EdgeInsetsDirectional.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.field),
                  border: Border.all(
                    color: colors.primary500.withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                  boxShadow: AppShadows.homeCard,
                ),
                child: Column(
                  children: [
                    if (state.isLoadingSpecializations)
                      for (var index = 0; index < 4; index++)
                        const _SpecialtyOptionShimmer()
                    else
                      for (final specialty in specializations)
                        Builder(
                          builder: (context) {
                            final selected =
                                specialty.specializationId ==
                                state.selectedSpecializationId;
                            final accent = SpecializationVisual.color(
                              specialty.color,
                              colors.primary600,
                            );
                            return Material(
                              color: colors.surface.withValues(alpha: 0),
                              child: InkWell(
                                onTap: specialty.specializationId == null
                                    ? null
                                    : () => cubit.selectSpecialization(
                                        specialty.specializationId!,
                                      ),
                                borderRadius: BorderRadius.circular(
                                  AppRadius.sm,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                        horizontal: AppSpacing.sm,
                                        vertical: AppSpacing.sm,
                                      ),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? accent.withValues(alpha: 0.1)
                                        : null,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.sm,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SpecializationIconView(
                                        value: specialty.icon,
                                        color: selected ? accent : colors.gray,
                                        size: AppSizes.iconSm,
                                      ),
                                      AppGaps.w8,
                                      Expanded(
                                        child: Text(
                                          _label(context, specialty),
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: selected
                                                    ? accent
                                                    : colors.ink,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  String _label(BuildContext context, ClinicSpecializationModel specialty) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'ar') {
      return specialty.nameAr ?? specialty.name ?? specialty.nameEn ?? '-';
    }
    return specialty.nameEn ?? specialty.name ?? specialty.nameAr ?? '-';
  }
}

class _SpecialtyLoadingHint extends StatelessWidget {
  const _SpecialtyLoadingHint();

  @override
  Widget build(BuildContext context) => Row(
    children: const [
      AppShimmerPlaceholder(
        width: AppSizes.iconSm,
        height: AppSizes.iconSm,
        shape: BoxShape.circle,
      ),
      AppGaps.w8,
      Expanded(
        child: AppShimmerPlaceholder(height: 10, borderRadius: AppRadius.pill),
      ),
      SizedBox(width: AppSpacing.xl),
    ],
  );
}

class _SpecialtyOptionShimmer extends StatelessWidget {
  const _SpecialtyOptionShimmer();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.sm,
      vertical: AppSpacing.sm,
    ),
    child: Row(
      children: const [
        AppShimmerPlaceholder(
          width: AppSizes.iconSm,
          height: AppSizes.iconSm,
          shape: BoxShape.circle,
        ),
        AppGaps.w8,
        Expanded(
          child: AppShimmerPlaceholder(
            height: 14,
            borderRadius: AppRadius.pill,
          ),
        ),
      ],
    ),
  );
}
