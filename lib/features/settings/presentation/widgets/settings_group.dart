import 'package:flutter/material.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// A titled settings section: a gradient marker + heading above a white card
/// that holds [rows] separated by hairline dividers.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.title, required this.rows});

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
          child: Row(
            children: [
              Container(
                width: AppSizes.homeSectionMarkerWidth,
                height: AppSizes.homeSectionMarkerHeight,
                decoration: BoxDecoration(
                  color: colors.primary500,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
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
          ),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
            border: Border.all(color: colors.line),
            boxShadow: AppShadows.homeCard,
          ),
          child: Column(
            children: [
              for (var i = 0; i < rows.length; i++) ...[
                if (i > 0) Divider(height: 1, color: colors.line),
                rows[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}
