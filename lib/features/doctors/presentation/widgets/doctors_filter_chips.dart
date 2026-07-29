import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_section_shimmers.dart';
import '../../../../shared/widgets/specialization_visual.dart';
import '../../data/models/clinic_specialization_model.dart';
import '../cubit/doctors_cubit.dart';
import '../cubit/doctors_state.dart';

/// Horizontally scrolling specialty filter. The selected pill fills with the
/// CTA gradient and glows; the rest are hairline-outlined.
class DoctorsFilterChips extends StatelessWidget {
  const DoctorsFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      buildWhen: (previous, current) =>
          previous.selectedSpecializationId !=
              current.selectedSpecializationId ||
          previous.isFiltersLoading != current.isFiltersLoading ||
          previous.specializations != current.specializations,
      builder: (context, state) {
        if (state.isFiltersLoading) return const FiltersShimmer();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.sm,
            AppSpacing.screen,
            AppSpacing.xxs,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                child: _FilterChip(
                  label: l10n.doctorsAll,
                  icon: Iconsax.category,
                  selected: state.selectedSpecializationId == null,
                  onTap: () =>
                      context.read<DoctorsCubit>().selectSpecialization(null),
                ),
              ),
              for (final specialty in state.specializations)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: AppSpacing.xs),
                  child: _FilterChip(
                    label: _label(context, specialty),
                    icon: SpecializationVisual.iconData(specialty.icon),
                    iconView: SpecializationIconView(
                      value: specialty.icon,
                      color:
                          state.selectedSpecializationId ==
                              specialty.specializationId
                          ? context.colors.onBrand
                          : SpecializationVisual.color(
                              specialty.color,
                              context.colors.gray,
                            ),
                      size: AppSizes.filterChipIcon,
                    ),
                    selected:
                        state.selectedSpecializationId ==
                        specialty.specializationId,
                    onTap: () => context
                        .read<DoctorsCubit>()
                        .selectSpecialization(specialty.specializationId),
                  ),
                ),
            ],
          ),
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

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.iconView,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  final Widget? iconView;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = selected ? colors.onBrand : colors.gray;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.quick,
        curve: AppMotion.emphasized,
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.sm,
          AppSpacing.xs + 1,
          AppSpacing.md,
          AppSpacing.xs + 1,
        ),
        decoration: BoxDecoration(
          color: selected ? null : colors.surface,
          gradient: selected ? colors.ctaGradient : null,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? colors.onBrand.withValues(alpha: 0) : colors.line,
            width: 1.5,
          ),
          boxShadow: selected ? AppShadows.selectedChip : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconView ??
                Icon(icon, size: AppSizes.filterChipIcon, color: foreground),
            AppGaps.w8,
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
