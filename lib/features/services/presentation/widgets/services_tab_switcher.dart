import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/service_kind.dart';
import '../cubit/services_cubit.dart';
import '../services_l10n.dart';

/// Lab/specialty tab switcher. Hidden entirely for single-role facilities —
/// they only ever manage one kind, so there is nothing to switch.
class ServicesTabSwitcher extends StatelessWidget {
  const ServicesTabSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServicesCubit>();
    if (cubit.availableKinds.length < 2) return const SizedBox.shrink();

    return BlocBuilder<ServicesCubit, ServicesState>(
      buildWhen: (previous, current) => previous.kind != current.kind,
      builder: (context, state) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.screen,
          AppSpacing.md,
          AppSpacing.screen,
          AppSpacing.xxs,
        ),
        child: Row(
          children: [
            for (final kind in cubit.availableKinds)
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: kind == cubit.availableKinds.last ? 0 : AppSpacing.xs,
                  ),
                  child: _KindTab(
                    kind: kind,
                    selected: state.kind == kind,
                    onTap: () => cubit.selectKind(kind),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _KindTab extends StatelessWidget {
  const _KindTab({
    required this.kind,
    required this.selected,
    required this.onTap,
  });

  final ServiceKind kind;
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
            Icon(kind.icon, size: AppSizes.filterChipIcon, color: foreground),
            AppGaps.w8,
            Flexible(
              child: Text(
                kind.tabLabel(context.l10n),
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: foreground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
