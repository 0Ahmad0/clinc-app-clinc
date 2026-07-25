import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/specialization_visual.dart';
import '../../domain/service_kind.dart';
import '../cubit/services_cubit.dart';
import '../services_l10n.dart';

/// Bottom sheet that lists the addable sections or specialties for the active
/// tab. Tapping an un-added item adds it via the cubit and closes the sheet.
class ServicesAddSheet extends StatelessWidget {
  const ServicesAddSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final cubit = context.read<ServicesCubit>();
    final state = context.watch<ServicesCubit>().state;
    final isLab = state.kind == ServiceKind.lab;

    return AppBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isLab ? l10n.servicesAddSection : l10n.servicesAddSpecialtyTitle,
            style: context.textTheme.titleLarge?.copyWith(
              color: colors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            isLab ? l10n.servicesAddSectionSub : l10n.servicesAddSpecialtySub,
            style: context.textTheme.bodySmall?.copyWith(color: colors.gray),
          ),
          AppGaps.h16,
          if (isLab)
            for (final section in state.labSections)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.xs,
                ),
                child: _AddTile(
                  icon: section.iconData,
                  accent: section.accent(colors),
                  iconView: (section.icon ?? '').trim().isEmpty
                      ? null
                      : SpecializationIconView(
                          value: section.icon,
                          color: section.accent(colors),
                          size: AppSizes.iconSm,
                        ),
                  name: section.label(context),
                  added: state.isLabSectionAdded(section.sectionId),
                  onTap: () {
                    if (state.isLabSectionAdded(section.sectionId)) {
                      cubit.removeSection(section);
                    } else {
                      cubit.addSection(section);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              )
          else
            for (final specialty in state.availableSpecializations.items.value)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.xs,
                ),
                child: _AddTile(
                  icon: specialty.iconData,
                  accent: specialty.accent(colors),
                  iconView: SpecializationIconView(
                    value: specialty.icon,
                    color: specialty.accent(colors),
                    size: AppSizes.iconSm,
                  ),
                  name: specialty.label(context),
                  added: state.isSpecializationEnabled(
                    specialty.specializationId,
                  ),
                  onTap: () {
                    if (state.isSpecializationEnabled(
                      specialty.specializationId,
                    )) {
                      cubit.removeSpecialty(specialty);
                    } else {
                      cubit.addSpecialty(specialty);
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
        ],
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({
    required this.icon,
    required this.accent,
    required this.name,
    required this.added,
    required this.onTap,
    this.iconView,
  });

  final IconData icon;
  final Color accent;
  final String name;
  final bool added;
  final VoidCallback onTap;
  final Widget? iconView;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: added
          ? accent.withValues(alpha: 0.08)
          : accent.withValues(alpha: 0.03),
      borderRadius: BorderRadius.circular(AppRadius.field),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.field),
        child: Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.field),
            border: Border.all(
              color: accent.withValues(alpha: added ? 0.38 : 0.2),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: AppSizes.iconBox,
                height: AppSizes.iconBox,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child:
                    iconView ??
                    Icon(icon, color: accent, size: AppSizes.iconSm),
              ),
              AppGaps.w12,
              Expanded(
                child: Text(
                  name,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: added ? colors.gray : colors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (added)
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: colors.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    context.l10n.servicesAdded,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.successFg,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
