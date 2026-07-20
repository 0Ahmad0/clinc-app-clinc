import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../domain/lab_section.dart';
import '../../domain/service_kind.dart';
import '../cubit/services_cubit.dart';
import '../services_catalog.dart';
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
            for (final section in LabSection.values)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.xs,
                ),
                child: _AddTile(
                  icon: section.icon,
                  accent: section.accent(colors),
                  name: section.label(l10n),
                  added: state.sections.contains(section),
                  onTap: () {
                    cubit.addSection(section);
                    Navigator.of(context).pop();
                  },
                ),
              )
          else
            for (final specialty in kClinicSpecialties)
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSpacing.xs,
                ),
                child: _AddTile(
                  icon: specialty.icon,
                  accent: specialty.accent(colors),
                  name: specialty.label(l10n),
                  added: state.specialties.contains(specialty),
                  onTap: () {
                    cubit.addSpecialty(specialty);
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
  });

  final IconData icon;
  final Color accent;
  final String name;
  final bool added;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: added ? colors.fill : colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.field),
      child: InkWell(
        onTap: added ? null : onTap,
        borderRadius: BorderRadius.circular(AppRadius.field),
        child: Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.field),
            border: Border.all(color: colors.line),
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
                child: Icon(icon, color: accent, size: AppSizes.iconSm),
              ),
              AppGaps.w12,
              Expanded(
                child: Text(
                  name,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: colors.ink,
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
