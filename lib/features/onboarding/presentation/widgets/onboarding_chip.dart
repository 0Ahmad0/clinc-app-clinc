import 'package:flutter/material.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Small floating card over the illustration: icon + title + subtitle.
class OnboardingChip extends StatelessWidget {
  const OnboardingChip({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.field),
        boxShadow: AppShadows.chip,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: AppSizes.chipIconBox,
            height: AppSizes.chipIconBox,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.primary500.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              icon,
              style: context.textTheme.bodyMedium?.copyWith(fontSize: 15),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: context.colors.ink,
                ),
              ),
              Text(
                subtitle,
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 10.5,
                  color: context.colors.gray,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
