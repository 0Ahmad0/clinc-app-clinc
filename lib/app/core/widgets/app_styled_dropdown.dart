import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A themed DropdownButtonFormField that matches AppFormField styling.
class AppStyledDropdown<T> extends StatelessWidget {
  final T? value;
  final String label;
  final IconData icon;
  final Color accentColor;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T)? itemLabel;
  final String? Function(T?)? validator;

  const AppStyledDropdown({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.items,
    required this.onChanged,
    this.itemLabel,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return DropdownButtonFormField<T>(
      value: value,
      validator: validator ?? (v) => v == null ? '*' : null,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: accentColor),
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
      items: items.map((item) {
        final label = itemLabel != null ? itemLabel!(item) : item.toString();
        return DropdownMenuItem<T>(value: item, child: Text(label));
      }).toList(),
    );
  }
}
