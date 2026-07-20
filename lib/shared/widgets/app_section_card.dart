import 'package:flutter/material.dart';

import '../../config/theme/app_shadows.dart';
import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

/// White rounded card with a tinted icon + title header, used for the sections
/// of form and detail screens.
class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    required this.icon,
    required this.tint,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final Color tint;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md + 2),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: colors.line),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSizes.addDoctorSectionIcon,
                height: AppSizes.addDoctorSectionIcon,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, size: AppSizes.iconSm, color: tint),
              ),
              AppGaps.w12,
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: colors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          AppGaps.h16,
          child,
        ],
      ),
    );
  }
}
