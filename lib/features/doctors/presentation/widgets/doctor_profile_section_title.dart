import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Section heading (gradient marker + bold title) used down the doctor profile.
class DoctorProfileSectionTitle extends StatelessWidget {
  const DoctorProfileSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.homeSectionMarkerWidth,
            height: AppSizes.homeSectionMarkerHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [colors.primary500, colors.primary300],
              ),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
          ),
          AppGaps.w8,
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              color: colors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
