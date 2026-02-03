import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../controllers/settings_controller.dart';

class ThemeDialog extends GetView<SettingsController> {
  const ThemeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return AlertDialog(
      title: Text(
        tr(LocaleKeys.settings_theme),
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Obx(() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ThemeOption(
            title: tr(LocaleKeys.settings_theme_system),
            icon: Icons.brightness_auto_outlined,
            isSelected: controller.themeMode.value == ThemeMode.system,
            onTap: () => controller.changeTheme(ThemeMode.system),
          ),
          12.verticalSpace,
          _ThemeOption(
            title: tr(LocaleKeys.settings_theme_light),
            icon: Icons.brightness_5_outlined,
            isSelected: controller.themeMode.value == ThemeMode.light,
            onTap: () => controller.changeTheme(ThemeMode.light),
          ),
          12.verticalSpace,
          _ThemeOption(
            title: tr(LocaleKeys.settings_theme_dark),
            icon: Icons.brightness_2_outlined,
            isSelected: controller.themeMode.value == ThemeMode.dark,
            onTap: () => controller.changeTheme(ThemeMode.dark),
          ),
        ],
      )),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            tr(LocaleKeys.settings_close),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.primary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? cs.primary.withOpacity(0.1) : cs.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? cs.primary : cs.outlineVariant,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? cs.primary : cs.onSurfaceVariant,
            ),
            12.horizontalSpace,
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? cs.onSurface : cs.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: cs.primary,
              ),
          ],
        ),
      ),
    );
  }
}