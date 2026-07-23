import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/report_type.dart';
import '../cubit/reports_cubit.dart';
import '../reports_l10n.dart';

/// "Report type" label plus a horizontally scrolling row of type chips. The
/// available types are role-scoped by the cubit.
class ReportsTypeChips extends StatelessWidget {
  const ReportsTypeChips({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.md + 2,
            AppSpacing.lg,
            AppSpacing.xs + 2,
          ),
          child: Text(
            context.l10n.reportsTypeSection,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.colors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        BlocBuilder<ReportsCubit, ReportsState>(
          buildWhen: (previous, current) => previous.type != current.type,
          builder: (context, state) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.screen,
            ),
            child: Row(
              children: [
                for (final type in cubit.availableTypes)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: AppSpacing.xs,
                    ),
                    child: _TypeChip(
                      type: type,
                      selected: state.type == type,
                      onTap: () => cubit.selectType(type),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TypeChip extends StatelessWidget {
  const _TypeChip({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final ReportType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = selected ? colors.onBrand : colors.gray;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.quick,
        curve: AppMotion.emphasized,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm - 2,
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
            Icon(type.icon, size: AppSizes.filterChipIcon, color: foreground),
            AppGaps.w8,
            Text(
              type.label(context.l10n),
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
