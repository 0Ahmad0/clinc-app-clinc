import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Pill-outlined form field with a leading tinted icon. Handles both single-line
/// inputs and the multi-line bio (via [maxLines]).
class AddDoctorTextField extends StatelessWidget {
  const AddDoctorTextField({
    super.key,
    required this.icon,
    required this.hint,
    this.iconColor,
    this.keyboardType,
    this.maxLines = 1,
  });

  final IconData icon;
  final String hint;
  final Color? iconColor;
  final TextInputType? keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final multiline = maxLines > 1;
    return Container(
      constraints: const BoxConstraints(
        minHeight: AppSizes.addDoctorFieldHeight,
      ),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(AppRadius.field),
        border: Border.all(
          color: colors.ink.withValues(alpha: 0.08),
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: multiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: multiline ? AppSpacing.sm : 0,
            ),
            child: Icon(
              icon,
              size: AppSizes.iconSm,
              color: iconColor ?? colors.primary500,
            ),
          ),
          AppGaps.w8,
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              maxLines: maxLines,
              minLines: multiline ? maxLines : null,
              style: context.textTheme.bodyMedium?.copyWith(
                color: colors.ink,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsetsDirectional.symmetric(
                  vertical: multiline ? AppSpacing.sm : AppSpacing.md,
                ),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: context.textTheme.bodyMedium?.copyWith(
                  color: colors.muted,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
