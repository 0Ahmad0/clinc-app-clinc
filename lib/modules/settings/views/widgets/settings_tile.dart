import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isSwitch;
  final bool? value;
  final ValueChanged<bool>? onChanged;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.isSwitch = false,
    this.value,
    this.onChanged,
  });

  // Constructor for switch tiles
  const SettingsTile.switchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  }) : isSwitch = true,
        onTap = null,
        trailing = null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: isSwitch ? null : onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: cs.outlineVariant.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: cs.shadow.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: cs.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                icon,
                color: cs.primary,
                size: 20.sp,
              ),
            ),
            16.horizontalSpace,

            // Title and Subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    4.verticalSpace,
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            12.horizontalSpace,

            // Trailing (Switch or Arrow)
            if (isSwitch)
              Switch(
                value: value ?? false,
                onChanged: onChanged,
                activeColor: cs.primary,
                activeTrackColor: cs.primary.withOpacity(0.3),
                inactiveThumbColor: cs.outline,
                inactiveTrackColor: cs.outlineVariant,
              )
            else
              trailing ?? Icon(
                Icons.chevron_right,
                color: cs.onSurfaceVariant,
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }
}