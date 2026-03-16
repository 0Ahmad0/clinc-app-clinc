import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A theme-aware form field for use inside the app (post-auth screens).
/// Unlike AppAuthField (which has a fixed white fill for auth screens),
/// this field follows the active ColorScheme.
class AppFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final Color accentColor;
  final bool isNumber;
  final int maxLines;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextInputAction inputAction;
  final Function(String)? onSubmitted;

  const AppFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.accentColor,
    this.isNumber = false,
    this.maxLines = 1,
    this.isRequired = true,
    this.validator,
    this.inputAction = TextInputAction.next,
    this.onSubmitted,
  });

  String? _defaultValidator(String? v) {
    if (isRequired && (v == null || v.trim().isEmpty)) {
      return '*';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      textInputAction: inputAction,
      onFieldSubmitted: onSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator ?? _defaultValidator,
      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: accentColor, size: 18.sp),
        labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 13.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: accentColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: cs.error, width: 1.5),
        ),
        filled: true,
        fillColor: cs.surfaceContainerLowest,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
    );
  }
}
