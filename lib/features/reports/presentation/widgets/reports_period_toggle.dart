import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/report_period.dart';
import '../cubit/reports_cubit.dart';
import '../cubit/reports_state.dart';
import '../reports_l10n.dart';

/// Weekly/monthly toggle — two full-width segments; the selected one fills with
/// the CTA gradient and glows.
class ReportsPeriodToggle extends StatelessWidget {
  const ReportsPeriodToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ReportsCubit>();
    return BlocBuilder<ReportsCubit, ReportsState>(
      buildWhen: (previous, current) => previous.period != current.period,
      builder: (context, state) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.screen,
          AppSpacing.md,
          AppSpacing.screen,
          0,
        ),
        child: Row(
          children: [
            for (final period in ReportPeriod.values)
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: period == ReportPeriod.values.last ? 0 : AppSpacing.xs,
                  ),
                  child: _PeriodTab(
                    period: period,
                    selected: state.period == period,
                    onTap: () => cubit.selectPeriod(period),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PeriodTab extends StatelessWidget {
  const _PeriodTab({
    required this.period,
    required this.selected,
    required this.onTap,
  });

  final ReportPeriod period;
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
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: selected ? colors.ctaGradient : null,
          borderRadius: BorderRadius.circular(AppRadius.field),
          border: Border.all(
            color: selected ? colors.onBrand.withValues(alpha: 0) : colors.line,
            width: 1.5,
          ),
          boxShadow: selected ? AppShadows.selectedChip : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(period.icon, size: AppSizes.filterChipIcon, color: foreground),
            AppGaps.w8,
            Text(
              period.label(context.l10n),
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
