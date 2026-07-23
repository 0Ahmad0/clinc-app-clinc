import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// A labeled, editable profile field: caption label above an icon + text input
/// seeded with the current [value].
class SettingsProfileField extends StatelessWidget {
  const SettingsProfileField({
    super.key,
    required this.label,
    required this.icon,
    this.value,
    this.controller,
    this.readOnly = false,
  });

  final String label;
  final IconData icon;
  final String? value;
  final TextEditingController? controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.field),
        border: Border.all(
          color: colors.ink.withValues(alpha: 0.08),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.labelSmall?.copyWith(color: colors.muted),
          ),
          Row(
            children: [
              Icon(icon, size: AppSizes.iconSm, color: colors.primary500),
              AppGaps.w8,
              Expanded(
                child: TextFormField(
                  controller: controller,
                  initialValue: controller == null ? value : null,
                  readOnly: readOnly,
                  textDirection: TextDirection.ltr,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
