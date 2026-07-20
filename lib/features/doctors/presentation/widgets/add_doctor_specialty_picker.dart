import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/add_doctor_cubit.dart';
import '../cubit/add_doctor_state.dart';
import '../doctor_specialty_l10n.dart';

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
        final selected = state.specialty;
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
                    Icon(
                      Iconsax.add,
                      size: AppSizes.iconSm,
                      color: colors.primary500,
                    ),
                    AppGaps.w8,
                    Expanded(
                      child: Text(
                        selected?.label(l10n) ??
                            l10n.addDoctorSpecialtyPlaceholder,
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
                    for (final specialty in kPickableSpecialties)
                      Material(
                        color: colors.surface.withValues(alpha: 0),
                        child: InkWell(
                          onTap: () => cubit.selectSpecialty(specialty),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: specialty == selected
                                  ? colors.primary500.withValues(alpha: 0.1)
                                  : null,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              specialty.label(l10n),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: specialty == selected
                                    ? colors.primary600
                                    : colors.ink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
}
