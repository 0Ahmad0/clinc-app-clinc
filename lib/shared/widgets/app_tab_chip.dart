import 'package:flutter/material.dart';

import '../../config/theme/app_motion.dart';
import '../../config/theme/app_shadows.dart';
import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';
import 'app_shimmer_placeholder.dart';

/// Filter pill with a trailing count badge. Selected fills with the CTA
/// gradient and glows; the rest are hairline-outlined.
class AppTabChip extends StatelessWidget {
  const AppTabChip({
    super.key,
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
    this.isCountLoading = false,
  });

  final String label;
  final String count;
  final bool selected;
  final VoidCallback onTap;
  final bool isCountLoading;

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
          vertical: AppSpacing.xs + 1,
        ),
        decoration: BoxDecoration(
          gradient: selected ? colors.ctaGradient : null,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected
                ? colors.onBrand.withValues(alpha: 0)
                : colors.ink.withValues(alpha: 0.12),
            width: 1.5,
          ),
          boxShadow: selected ? AppShadows.selectedChip : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
            ),
            AppGaps.w8,
            Container(
              constraints: const BoxConstraints(minWidth: AppSpacing.lg),
              height: AppSpacing.lg,
              alignment: Alignment.center,
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.xxs + 1,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? colors.onBrand.withValues(alpha: 0.22)
                    : colors.ink.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: isCountLoading
                  ? AppShimmerPlaceholder(
                      width: AppSpacing.md,
                      height: AppSpacing.xs + 2,
                      borderRadius: AppRadius.pill,
                    )
                  : Text(
                      count,
                      style: context.textTheme.labelSmall?.copyWith(
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
