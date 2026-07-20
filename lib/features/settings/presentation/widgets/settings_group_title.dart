import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Section heading used above card-less field groups: a gradient marker bar and
/// a bold title (the same marker the settings cards use).
class SettingsGroupTitle extends StatelessWidget {
  const SettingsGroupTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
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
          style: context.textTheme.bodyMedium?.copyWith(
            color: colors.ink,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
