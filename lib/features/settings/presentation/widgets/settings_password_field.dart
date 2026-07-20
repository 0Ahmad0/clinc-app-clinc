import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Password input with a lock icon and a shared show/hide toggle.
class SettingsPasswordField extends StatelessWidget {
  const SettingsPasswordField({
    super.key,
    required this.controller,
    required this.hint,
    required this.obscure,
    required this.onToggleObscure,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      constraints: const BoxConstraints(minHeight: AppSizes.searchBarHeight),
      padding: const EdgeInsetsDirectional.only(start: AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.field),
        border: Border.all(
          color: colors.ink.withValues(alpha: 0.08),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(Iconsax.lock_1, size: AppSizes.iconSm, color: colors.primary500),
          AppGaps.w12,
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              onChanged: onChanged,
              style: context.textTheme.bodyMedium?.copyWith(color: colors.ink),
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: hint,
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: colors.muted,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onToggleObscure,
            icon: Icon(
              obscure ? Iconsax.eye_slash : Iconsax.eye,
              size: AppSizes.iconSm,
              color: colors.muted,
            ),
          ),
        ],
      ),
    );
  }
}
